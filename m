Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUHAPIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUHAPIs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 11:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUHAPIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 11:08:48 -0400
Received: from quechua.inka.de ([193.197.184.2]:17577 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265978AbUHAPIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 11:08:45 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Software RAID 5 and crashes
Organization: Deban GNU/Linux Homesite
In-Reply-To: <410CF7AA.2020604@baldauf.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BrHx5-0004sd-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 01 Aug 2004 17:08:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <410CF7AA.2020604@baldauf.org> you wrote:
> Unfortunately, it still does not make me satisfied, because: The 

IMHO the current Raid5 implementation can be better in terms of crash
recovery, BUT one should not forget that RAID5 is simply pretty bad even if
ideally coded with ordered write and transaction sequence numbers. Therefore
it is perhaps better to spend more time on alternatives or at least in
communicating the inherent problems of raid5 to the users which want more
(like you seem to need?)

>    * <>Example 0: s3,s2,s1 are written to disk, while s0 is not written
>    * Example 1: s0,s1,s2 are written to disk, while s3 is not written

One has to state clearly state that the failure to commit raid stripes in a
crash result in guranteed data loss even when the data is written redundant.
This is one of the raid5 problems, and it is even worse in a degregated
scenario.

> If we now consider, that for each disk (as member of a RAID 5), there 
> are parity stripes and there are data stripes. Doesn't it make sense to 
> prefer data blocks over partiy blocks when writing, just to get more 
> cases of "example 1" against "example 0" than without this preference?

I guess it depends on what "prefer" mean? Do you think about write ordering
with a performance impact or about some minor tweaking with possibly no use
(ie. because sorting the requests will be reordered in the controller and
device anyway)

> One could even imagine to intensionally postpone the parity block 
> writing for some time in favour of peak throughput.

That would only help, if you defer the decision when the data is stable to
that delayed time, which is for sure a performance killer.

> The RAID 5 device 
> looses its rendundancy for some bounded time at a bounded region of its 
> space, but this may be acceptable for certain applications, I think.

Well, I cant imagine applications which are sensitive to losing random file
appends without a transaction protocol, but are not sensitive to degregaded
redundancy?

BTW: I dont think hardware raid5 of any vendor performs much better?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/

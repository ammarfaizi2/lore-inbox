Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbUCFDJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 22:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUCFDJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 22:09:19 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:62906 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261571AbUCFDJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 22:09:18 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: 2.6.4-rc1-mm[12] - dm_any_congested issues 
Date: Sat, 6 Mar 2004 03:09:15 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c2bfcr$bkc$2@news.cistron.nl>
References: <20040302201536.52c4e467.akpm@osdl.org> <200403051754.i25Hsjg7015052@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1078542555 11916 62.216.29.200 (6 Mar 2004 03:09:15 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200403051754.i25Hsjg7015052@turing-police.cc.vt.edu>,
 <Valdis.Kletnieks@vt.edu> wrote:
>On Tue, 02 Mar 2004 20:15:36 PST, Andrew Morton <akpm@osdl.org>  said:
>
>(Added in -rc1-mm1 which I didn't try, problem noticed in -rc2-mm2)
>
>> queue-congestion-dm-implementation.patch
>>   Implement queue congestion callout for device mapper
>
>This is causing the following trace every second or 2 on my laptop:
>
>Mar  4 17:47:26 turing-police kernel: Debug: sleeping function called
>from invalid context at include/linux/rwsem.h:43
>Of course backing it out makes the messages go away, since dm_any_congested()
>was added by that patch.  This patch just not ready for prime time, or
>am I (as usual)
>managing to trip over some silly corner case due to odd configuration?

It's a bug. The new queue congestion function cannot sleep, yet
it calls parts of DM that can sleep (indirectly). This needs to
be fixed in DM (I think).
See https://www.redhat.com/archives/linux-lvm/2004-March/msg00033.html

Mike.


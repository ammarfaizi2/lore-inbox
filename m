Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263821AbUC3SGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUC3SGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:06:04 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:49936 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263812AbUC3SFp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:05:45 -0500
Date: Tue, 30 Mar 2004 11:04:40 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org,
       dm-devel@redhat.com
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <866290000.1080669880@aslan.btc.adaptec.com>
In-Reply-To: <4069B289.9030807@pobox.com>
References: <760890000.1079727553@aslan.btc.adaptec.com> <200403261315.20213.kevcorry@us.ibm.com> <1644340000.1080333901@aslan.btc.adaptec.com> <200403270939.29164.kevcorry@us.ibm.com> <842610000.1080666235@aslan.btc.adaptec.com> <4069AB1B.90108@pobox.com> <854630000.1080668158@aslan.btc.adaptec.com> <4069B289.9030807@pobox.com>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> That's unfortunate for those using ATA.  A command submitted from userland
> 
> Required, since one cannot know the data phase of vendor-specific commands.

So you are saying that this presents an unrecoverable situation?

> Particularly, checking whether the kernel is doing something wrong, or wrong,
> just wastes cycles.  That's not a scalable way to code...  if every driver
> and Linux subsystem did that, things would be unbearable slow.

Hmm.  I've never had someone tell me that my SCSI drivers are slow.

I don't think that your statement is true in the general case.  My
belief is that validation should occur where it is cheap and efficient
to do so.  More expensive checks should be pushed into diagnostic code
that is disabled by default, but the code *should be there*.  In any event,
for RAID meta-data, we're talking about code that is *not* in the common
or time critical path of the kernel.  A few dozen lines of validation code
there has almost no impact on the size of the kernel and yields huge
benefits for debugging and maintaining the code.  This is even more
the case in Linux the end user is often your test lab.

--
Justin


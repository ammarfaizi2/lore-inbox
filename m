Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266685AbUG1WeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266685AbUG1WeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUG1WdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:33:05 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:25763 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S266531AbUG1Wbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:31:49 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040728142026.79860177.akpm@osdl.org>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040728142026.79860177.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1091053501.8867.18.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 29 Jul 2004 08:25:01 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-07-29 at 07:20, Andrew Morton wrote:
> hm.  In some ways I'd prefer to see new
> create_singlethread_workqueue_freezer(char *) or whatever, rather than
> adding an extra argument.  That's neater, smaller code and
> forward-compatible.
> 
> But then again, the advantage of breaking the build for unconverted code is
> that it makes people think about what their threads should be doing, so
> let's go your way.
> 
> The one concern I'd have is that $RANDOM_KERNEL_DEVELOPER probably doesn't
> have a clue whether or not his kernel thread should be setting PF_NOFREEZE.
> What are the guidelines here?

If a process might be/is needed to get the image to the storage device,
it should be NOFREEZE. (Thus, USB threads might be NOFREEZE to allow for
USB storage, likewise for SCSI). When I get an NFS writer done, the
threads for network cards could probably be made NOFREEZE too. Things
like kjournald don't need to run during suspend (even if we're writing
to a swapfile in an ext3 partition), so can be 0 for now (SYNCTHREAD
later).

> wrt your "Add missing refrigerator support" patch: I'll suck that up, but
> be aware that there's a big i2o patch in -mm which basically rips out the
> driver which you just fixed up.  Perhaps you can send Markus Lidel
> <Markus.Lidel@shadowconnect.com> and I a fix for that version of the driver
> sometime?

I've just started following your mm patches, and will do updates for
last nights release shortly.

Regards,

Nigel


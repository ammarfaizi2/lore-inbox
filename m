Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVBACWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVBACWN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 21:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVBACWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 21:22:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5271 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261506AbVBACV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 21:21:56 -0500
Date: Mon, 31 Jan 2005 21:17:52 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vasily Averin <vvs@sw.ru>, Andrey Melnikov <temnota+kernel@kmv.ru>
Cc: linux-kernel@vger.kernel.org, Atul Mukker <Atul.Mukker@lsil.com>,
       Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
Subject: Re: [PATCH] Prevent NMI oopser
Message-ID: <20050131231752.GA17126@logos.cnet>
References: <41F5FC96.2010103@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F5FC96.2010103@sw.ru>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 11:00:22AM +0300, Vasily Averin wrote:
> cc: Andrey Melnikov <temnota+kernel@kmv.ru>
> cc: linux-kernel@vger.kernel.org
> 
> Marcello, Andrey
> 
> I believe this patch is wrong.
> First, it prevent nothing: NMI watchdog is a signal that you wait too
> long with disabled interrupts. Your controller was not answered too
> long, obviously it is a hardware issue.
> Second, you could not call schedule() with io_request_lock spinlock taken.
> 
> You should unlock io_request_lock before msleep, like in latest versions
> of megaraid2 drivers.
> 
> Please fix it.

Andrey, 

Can you please update your patch to unlock io_request_lock before sleeping
and locking after coming back? 

What the driver is doing is indeed wrong.

Thank you.

Is there anybody out there at LSI? 

> Thank you,
>       Vasily Averin, SWSoft Linux Kernel Team
> 
> # ChangeSet
> #   2005/01/19 14:16:32-02:00 temnota@kmv.ru
> #   [PATCH] Prevent NMI oopser from triggering when megaraid2 waits
> #   for abort/reset cmd completion
> #
> #   > We should backport msleep() in 2.4.29-pre1.
> #
> #   Ok, msleep() backported, but driver isn't fixed. This patch
> #   acceptable?
> #
> #   Prevent NMI oopser kill kernel thread when megaraid2 driver waiting
> #   abort or reset command completion.
> #
> #   Signed-off-by: Andrey Melnikov <temnota+kernel@kmv.ru>
> 

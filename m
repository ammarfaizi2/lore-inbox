Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWIAOz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWIAOz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 10:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWIAOz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 10:55:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25617 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750739AbWIAOz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 10:55:56 -0400
Date: Fri, 1 Sep 2006 14:55:39 +0000
From: Pavel Machek <pavel@suse.cz>
To: Simon Tatham <anakin@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Magic SysRq SAK does nothing on serial consoles
Message-ID: <20060901145539.GC4377@ucw.cz>
References: <E1GILQi-0004QF-00@ixion.tartarus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GILQi-0004QF-00@ixion.tartarus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Applying the attached patch resolved the problem for me; now when I
> send BREAK-k, the kernel prints `SysRq : SAK', then prints a couple
> of lines indicating that some processes have been killed, and then
> init spawns a new login process as I would expect.
> 
> (The patch is defensively coded, since I wasn't sure whether
> port->info was guaranteeably non-NULL. If it is, the change can be
> even simpler!)

Try to find out if port->info can be NULL; then you should probably
resubmit, cc akpm and rmk. Also see Doc*/SubmittingPatches.

> --- linux-2.6.17.6.orig/include/linux/serial_core.h	2006-07-15 20:00:43.000000000 +0100
> +++ linux-2.6.17.6/include/linux/serial_core.h	2006-08-30 07:55:00.000000000 +0100
> @@ -411,7 +411,7 @@
>  #ifdef SUPPORT_SYSRQ
>  	if (port->sysrq) {
>  		if (ch && time_before(jiffies, port->sysrq)) {
> -			handle_sysrq(ch, regs, NULL);
> +			handle_sysrq(ch, regs, port->info ? port->info->tty : NULL);
>  			port->sysrq = 0;
>  			return 1;
>  		}



-- 
Thanks for all the (sleeping) penguins.

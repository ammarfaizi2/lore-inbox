Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTIBXvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 19:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTIBXvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 19:51:33 -0400
Received: from platane.lps.ens.fr ([129.199.121.28]:25986 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S261326AbTIBXv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 19:51:29 -0400
Date: Wed, 3 Sep 2003 01:50:24 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Patrick Mochel <mochel@osdl.org>, benh@kernel.crashing.org
Cc: Mathieu LESNIAK <maverick@eskuel.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Power Management Update
Message-ID: <20030902235023.GA21645@lps.ens.fr>
References: <3F51F274.9050300@eskuel.com> <Pine.LNX.4.44.0309021108040.5614-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0309021108040.5614-100000@cherise>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 11:13:24AM -0700, Patrick Mochel wrote:
> I encountered this problem by having an IDE CD-ROM, but not having the 
> ide-cd drier compiled in. The patch below is from Benh, who wrote the IDE 
> power managment handlers. 
> 
> He mentioned producing a cleaner patch, but this should at least fix the 
> Oops. Please give it a try and report if it helps or not.

I was waiting for Ben's « new patch later today », but I finally gave a
try to this one
> ===== drivers/ide/ide-io.c 1.21 vs edited =====
> --- 1.21/drivers/ide/ide-io.c	Mon Sep  1 10:21:10 2003
> +++ edited/drivers/ide/ide-io.c	Tue Sep  2 09:58:19 2003
> @@ -609,6 +609,22 @@
>  EXPORT_SYMBOL(execute_drive_cmd);
>  
>  /**
> + *	do_start_power_step	- wrapper on subdriver start_power_step()
> + *
> + *	This is called by start_request instead of directly calling
> + *	the subdriver's start_power_step() to deal with either no
> + *	subdriver or no start_power_step method in the subdriver
> + *	properly.
> + */
[snip]

The result is a panic at different place when resuming from suspend to
disk. Hand written partial debugging info:

EIP is at swsusp_arch_suspend
eax: 07200720 ebx: 07200720 ecx: c1700000 edx=esi=edi=ebp=0 esp=df793fac
Process swapper 
Call trace:
	swsusp_restore
	pm_resume
	do_initcalls
	init_workqueues
	init
	init
	kernel_thread_helper
Code: 8a 04 02 88 04 1a 0f 20 d8 0f 22 d8 a1 18 70 37 c0 8d 50 01
Panic: attempted to kill init !

Complete (?) information on my computer and kernel logs at 
http://perso.nerim.net/~tudia/bug-reports

By the way, how comes the computer suspends when echoing 4 to
/proc/acpi/sleep, and nothing happens when echoing disk to
/sys/power/state ? Aren't those two things supposed to be equivalent ?
Regards,

	Éric Brunet

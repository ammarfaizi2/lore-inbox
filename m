Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266281AbUH3E6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUH3E6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 00:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUH3E6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 00:58:08 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:60146 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266281AbUH3E6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 00:58:05 -0400
Date: Mon, 30 Aug 2004 01:02:26 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Anton Blanchard <anton@samba.org>, John Levon <levon@movementarian.org>,
       Philippe Elie <phil.el@wanadoo.fr>
Subject: Re: [PATCH][1/3] Completely out of line spinlocks / generic
In-Reply-To: <Pine.LNX.4.58.0408292359320.24992@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0408300057130.24992@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408292359320.24992@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004, Zwane Mwaikambo wrote:

> Index: linux-2.6.9-rc1-mm1/drivers/oprofile/timer_int.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.9-rc1-mm1/drivers/oprofile/timer_int.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 timer_int.c
> --- linux-2.6.9-rc1-mm1/drivers/oprofile/timer_int.c	26 Aug 2004 13:13:41 -0000	1.1.1.1
> +++ linux-2.6.9-rc1-mm1/drivers/oprofile/timer_int.c	28 Aug 2004 20:00:47 -0000
> @@ -19,7 +19,7 @@ static int timer_notify(struct notifier_
>  {
>  	struct pt_regs * regs = (struct pt_regs *)data;
>  	int cpu = smp_processor_id();
> -	unsigned long eip = instruction_pointer(regs);
> +	unsigned long eip = profile_pc(regs);
>
>  	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
>  	return 0;

Looking at the PPC oprofile code, how does contention get reported?
get_pc() looks like it may be returning _raw_spin_*

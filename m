Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTKBT16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 14:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTKBT16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 14:27:58 -0500
Received: from mail-6.tiscali.it ([195.130.225.152]:2498 "EHLO
	mail-6.tiscali.it") by vger.kernel.org with ESMTP id S261806AbTKBT14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 14:27:56 -0500
Date: Sun, 2 Nov 2003 19:25:56 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Geoffrey Lee <glee@gnupilgrims.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] reproducible athlon mce fix
Message-ID: <20031102182556.GA4974@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031102055748.GA1218@anakin.wychk.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geoffrey Lee ha scritto:
> After switching from 2.4.22 to 2.6.0-test9, I have received reproducible
> MCE non-fatal error check messages in my kernel log.  (For example, one
> shows up right after my first scsi card init).
[cut]
> would seem to imply that Athlons don't like having their Bank 0 poked at,
> though that's what non-fatal.c does.  Would it be correct to make sure
> that that non-fatal.c starts at bank 1, if it is an Athlon?
>
> --- linux-2.6.0-test9/arch/i386/kernel/cpu/mcheck/non-fatal.c.orig	2003-11-02 13:31:43.000000000 +0800
> +++ linux-2.6.0-test9/arch/i386/kernel/cpu/mcheck/non-fatal.c	2003-11-02 13:34:37.000000000 +0800
> @@ -30,7 +30,11 @@
>  	int i;
> 
> 	preempt_disable(); 
> +#if CONFIG_MK7
> +	for (i=1; i<nr_mce_banks; i++) {
> +#else
>  	for (i=0; i<nr_mce_banks; i++) {
> +#endif
>  		rdmsr (MSR_IA32_MC0_STATUS+i*4, low, high);
> 
>  		if (high & (1<<31)) {

In  this way  you don't  read  from bank  0. The strange  thing is  that
amd_mcheck_init doesn't enable reporting on  this bank... it should stay
clean. What's going on here?

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Quando un uomo porta dei fiori a sua moglie senza motivo, 
un motivo c'e`.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751742AbWBQUek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbWBQUek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWBQUek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:34:40 -0500
Received: from cantor2.suse.de ([195.135.220.15]:9410 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751742AbWBQUej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:34:39 -0500
From: Andi Kleen <ak@suse.de>
To: dan.yeisley@unisys.com
Subject: Re: [patch] i386 need to pass virtual address to smp_read_mpc()
Date: Fri, 17 Feb 2006 21:34:24 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1140207880.2910.10.camel@localhost.localdomain>
In-Reply-To: <1140207880.2910.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602172134.24582.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 21:24, Daniel Yeisley wrote:
> I'm seeing a kernel panic on an ES7000-600 when booting in virtual wire
> mode.  The panic happens because smp_read_mpc() is passed a physical
> address, and it should be virtual.  I tested the attached patch on the
> ES7000-600 and on a 2 cpu Dell box, and saw no problems on either.

Looks obviously correct. Should probably be in 2.6.16

-Andi

> 
> Signed-off-by:  Dan Yeisley <dan.yeisley@unisys.com>
> ---
> 
> diff -Naur -p linux-2.6.16-rc1-git3-7/arch/i386/kernel/mpparse.c linux-2.6.16-rc1-git3-7-a/arch/i386/kernel/mpparse.c
> --- linux-2.6.16-rc1-git3-7/arch/i386/kernel/mpparse.c  2006-01-30 18:38:18.000000000 -0500
> +++ linux-2.6.16-rc1-git3-7-a/arch/i386/kernel/mpparse.c        2006-02-16 04:51:35.551014272 -0500
> @@ -710,7 +710,7 @@ void __init get_smp_config (void)
>                  * Read the physical hardware table.  Anything here will
>                  * override the defaults.
>                  */
> -               if (!smp_read_mpc((void *)mpf->mpf_physptr)) {
> +               if (!smp_read_mpc(phys_to_virt(mpf->mpf_physptr)))
>                         smp_found_config = 0;
>                         printk(KERN_ERR "BIOS bug, MP table errors detected!...\n");
>                         printk(KERN_ERR "... disabling SMP support. (tell your hw vendor)\n");
> 
> 
> 

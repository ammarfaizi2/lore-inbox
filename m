Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVFBI5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVFBI5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVFBI5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:57:04 -0400
Received: from lugor.de ([217.160.170.124]:16844 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S261225AbVFBIbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 04:31:15 -0400
From: Christian Hesse <mail@earthworm.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-1
Date: Thu, 2 Jun 2005 10:30:34 +0200
User-Agent: KMail/1.8.1
Cc: Tony Lindgren <tony@atomide.com>
References: <20050602013641.GL21597@atomide.com>
In-Reply-To: <20050602013641.GL21597@atomide.com>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1289244.f0YQy2tCgn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506021030.50585.mail@earthworm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1289244.f0YQy2tCgn
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 02 June 2005 03:36, Tony Lindgren wrote:
> Hi all,
>
> Here's an updated version of the dynamic tick patch.
>
> It's mostly clean-up and it's now using the standard
> monotonic_clock() functions as suggested by John Stultz.
>
> Please let me know of any issues with the patch. I'll continue to do
> more clean-up on it, but I think the basic functionality is done.

I would like to test it, but have some trouble. The patch applies cleanly a=
nd=20
everything compiles fine, but linking fails:

# ld -m elf_i386  -R arch/i386/kernel/vsyscall-syms.o -r -o=20
arch/i386/kernel/built-in.o arch/i386/kernel/process.o=20
arch/i386/kernel/semaphore.o arch/i386/kernel/signal.o=20
arch/i386/kernel/entry.o arch/i386/kernel/traps.o arch/i386/kernel/irq.o=20
arch/i386/kernel/vm86.o arch/i386/kernel/ptrace.o arch/i386/kernel/time.o=20
arch/i386/kernel/ioport.o arch/i386/kernel/ldt.o arch/i386/kernel/setup.o=20
arch/i386/kernel/i8259.o arch/i386/kernel/sys_i386.o=20
arch/i386/kernel/pci-dma.o arch/i386/kernel/i386_ksyms.o=20
arch/i386/kernel/i387.o arch/i386/kernel/dmi_scan.o=20
arch/i386/kernel/bootflag.o arch/i386/kernel/doublefault.o=20
arch/i386/kernel/quirks.o arch/i386/kernel/cpu/built-in.o=20
arch/i386/kernel/timers/built-in.o arch/i386/kernel/acpi/built-in.o=20
arch/i386/kernel/reboot.o arch/i386/kernel/module.o=20
arch/i386/kernel/sysenter.o arch/i386/kernel/vsyscall.o=20
arch/i386/kernel/dyn-tick.o arch/i386/kernel/early_printk.o
arch/i386/kernel/irq.o: In function `reprogram_apic_timer':
irq.c:(.text+0x0): multiple definition of `reprogram_apic_timer'
arch/i386/kernel/process.o:process.c:(.text+0x0): first defined here
arch/i386/kernel/time.o: In function `reprogram_apic_timer':
time.c:(.text+0x0): multiple definition of `reprogram_apic_timer'
arch/i386/kernel/process.o:process.c:(.text+0x0): first defined here
arch/i386/kernel/dyn-tick.o: In function `reprogram_apic_timer':
dyn-tick.c:(.text+0x0): multiple definition of `reprogram_apic_timer'
arch/i386/kernel/process.o:process.c:(.text+0x0): first defined here

=2D-=20
Christian

--nextPart1289244.f0YQy2tCgn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.15 (GNU/Linux)

iD8DBQBCnsO6lZfG2c8gdSURAolyAKCGCzLSci2QpFUX1nMBvqFC7Blx1QCgwbck
L+XJvhxHUhw/8RQQ3cGinns=
=D2pu
-----END PGP SIGNATURE-----

--nextPart1289244.f0YQy2tCgn--

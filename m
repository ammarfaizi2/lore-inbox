Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272657AbRHaKO6>; Fri, 31 Aug 2001 06:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272658AbRHaKOs>; Fri, 31 Aug 2001 06:14:48 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:55050 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S272657AbRHaKOi>;
	Fri, 31 Aug 2001 06:14:38 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15247.24917.74550.455485@cargo.ozlabs.ibm.com>
Date: Fri, 31 Aug 2001 20:05:09 +1000 (EST)
To: Tsunehiko Baba <tsn@niagara.crl8.crl.hitachi.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: simple patches for Linux 2.4.9-ac5 or Linux 2.4.10-pre2 on PPC
In-Reply-To: <kt1yls1xrf.wl@niagara.crl8.crl.hitachi.co.jp>
In-Reply-To: <kt1yls1xrf.wl@niagara.crl8.crl.hitachi.co.jp>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tsunehiko Baba writes:

> I tried to compile 2.4.10-pre2 or 2.4.9-ac5 on ppc but failed.
> To avoid some errors, I made following patches.
> Please check and apply these patches. 

> *** include/linux/vt_kern.h.orig	Thu Aug 30 20:22:52 2001
> --- include/linux/vt_kern.h	Thu Aug 30 20:28:35 2001

A simpler and better solution for this is to just remove the
definition of kbd_rate from include/asm-ppc/keyboard.h and remove the
lines which reference pckbd_rate from arch/ppc/kernel/chrp_setup.c and
prep_setup.c.  I have sent Linus a patch to this effect already.

> *** drivers/ide/ide-pci.c.orig	Mon Aug 13 17:56:19 2001
> --- drivers/ide/ide-pci.c	Thu Aug 30 20:55:38 2001
> ***************
> *** 445,451 ****
>    * settings of split-mirror pci-config space, place chipset into init-mode,
>    * and/or preserve an interrupt if the card is not native ide support.
>    */
> ! static unsigned int __init ide_special_settings (struct pci_dev *dev, const char *name)

The better fix is to go into drivers/ide/sl82c105.c and change it to
use the code that is currently inside the #ifdef CONFIG_ARCH_NETWINDER
block instead of the code that is in the #else branch of that
conditional.  I have posted that patch to lkml a couple of times and
sent to Linus as well, but he hasn't taken it yet (Alan has).
Alternatively, if you don't use the sl82c105 driver, remove it from
your config.

Paul.

-- 
Paul Mackerras, PPC/Linux Maintainer		paulus@samba.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264005AbRFEPAP>; Tue, 5 Jun 2001 11:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264007AbRFEPAG>; Tue, 5 Jun 2001 11:00:06 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:5 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264005AbRFEO7w>;
	Tue, 5 Jun 2001 10:59:52 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Stephen Wille Padnos <stephenwp@adelphia.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Exporting new functions from kernel 2.2.14 
In-Reply-To: Your message of "Tue, 05 Jun 2001 10:32:41 MST."
             <3B1D17B9.92D046A1@adelphia.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Jun 2001 00:59:39 +1000
Message-ID: <18174.991753179@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jun 2001 10:32:41 -0700, 
Stephen Wille Padnos <stephenwp@adelphia.net> wrote:
>Unfortunately, the printk warning was still there.
>
>I replaced the unconditional #define MODVERSIONS with
>#include <linux/config.h>
>#ifdef CONFIG_MODVERSIONS
>#define MODVERSIONS
>#include <linux/modversions.h>
>#endif
>
>this is at the top of my source file. (before module.h and linux.h)
>
>(as seen somewhere on the web)

And like many things on the web, it is wrong.  Do not put anything in
the source code expect #include <linux/module.h> as the first include.
In particular do not include modversions.h yourself, it will break in
2.5.  You compile a module with these gcc flags

(1) -DMODULE
(2) -DMODVERSIONS -include $(TOPDIR)/include/linux/modversions.h
(3) -DEXPORT_SYMTAB

All modules get flag (1).
All modules get flags (2) but only if .config contains
CONFIG_MODVERSIONS, otherwise omit these flags.
Only modules that export symbols get flag (3).

That is what the standard kernel Makefiles do and is the only correct
way to compile modules.

Keith Owens, kernel build and modutils maintainer.


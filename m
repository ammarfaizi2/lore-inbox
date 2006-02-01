Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbWBAK3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWBAK3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWBAK3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:29:21 -0500
Received: from aun.it.uu.se ([130.238.12.36]:15579 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932397AbWBAK3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:29:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17376.36154.580526.776564@alkaid.it.uu.se>
Date: Wed, 1 Feb 2006 11:28:10 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jacek Lipkowski <sq5bpf@acid.ch.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch to make 2.4.32 work on i486 again
In-Reply-To: <Pine.LNX.4.58.0601312313050.6477@acid.ch.pw.edu.pl>
References: <Pine.LNX.4.58.0601312313050.6477@acid.ch.pw.edu.pl>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek Lipkowski writes:
 > Booting the 2.4.32 kernel compiled for a i486 on an i486 box fails,
 > because "Kernel compiled for Pentium+, requires TSC feature!" (printed
 > from check_config() include/asm-i386/bugs.h). To reproduce, select 486 in
 > the kernel configuration and grep CONFIG_X86_TSC .config
 > 
 > Seems strange that no one noticed this, am i the only one still using 486
 > boxes? :)
 > 
 > Jacek
 > 
 > Simple patch against vanilla 2.4.32:
 > 
 > --- arch/i386/config.in.old	2006-01-30 22:57:21.000000000 +0100
 > +++ arch/i386/config.in	2006-01-30 23:00:55.000000000 +0100
 > @@ -65,6 +65,7 @@
 >     define_bool CONFIG_X86_POPAD_OK y
 >     define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
 >     define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 > +   define_bool CONFIG_X86_TSC n
 >  fi
 >  if [ "$CONFIG_M486" = "y" ]; then
 >     define_int  CONFIG_X86_L1_CACHE_SHIFT 4
 > @@ -72,6 +73,7 @@
 >     define_bool CONFIG_X86_ALIGNMENT_16 y
 >     define_bool CONFIG_X86_PPRO_FENCE y
 >     define_bool CONFIG_X86_F00F_WORKS_OK n
 > +   define_bool CONFIG_X86_TSC n
 >  fi
 >  if [ "$CONFIG_M586" = "y" ]; then
 >     define_int  CONFIG_X86_L1_CACHE_SHIFT 5

This is a known limitation of the 2.4 kernel's configuration system:
a single round of make ${foo}config doesn't always reach a fixpoint
with regard to the derived options. CONFIG_X86_TSC is the standard
example of this: switching from a stable .config with TSC (say i686)
to one without (say i486) leaves a stray definition of CONFIG_X86_TSC
behind in .config. Solution: run 'make oldconfig' after flipping the
user-selectatable options.

Your patch may fix the TSC case, but there are probably more cases
like this in 2.4.

/Mikael

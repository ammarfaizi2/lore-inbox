Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVGXG3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVGXG3H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 02:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVGXG3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 02:29:07 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:15514 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261934AbVGXG3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 02:29:06 -0400
From: Grant Coady <lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc3 test: finding compile errors with make randconfig
Date: Sun, 24 Jul 2005 16:28:54 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Few days ago I compiled 241 random configurations of 2.6.13-rc3, today 
I finally got around to parsing the results, top 40, sorted by name.  
Percentage is error_builds / total_builds.

build script similar to:
count=0
while [ $((++count)) -le $limit ]; do
        trial=$(printf %003d $count)
        make randconfig
        cp .config "$store/$trial-config"
        make clean
        make -j2 2> "$store/$trial-error"
done

Curious whether this is worth doing, I'm about to start a run for 2.6.12.3, 
any interesting errors I can find the particular config + error to recover 
context.  Deliberately simplistic for traceability at the moment, truncated 
error length for this post.

# Linux kernel version: 2.6.13-rc3
# Tue Jul 19 04:04:05 2005..Wed Jul 20 09:46:33 2005  241 runs in three sessions

compile host 2.4.31-hf2 on: http://scatter.mine.nu/test/boxen/sempro/
data filter: http://scatter.mine.nu/test/scripts/count_errors-2.6.13-rc3.gz

arch/i386/mach-es7000/es7000.h: error: field `Header' has incomplete type   4.9%
arch/i386/mach-es7000/es7000.h: error: field `id' has incomplete type       4.9%
arch/i386/mach-es7000/es7000plat.c: error: `es7000_rename_gsi' undeclared   4.9%
arch/i386/mach-es7000/es7000plat.c: error: dereferencing pointer to incomp 49.7%
arch/i386/mach-es7000/es7000plat.c: error: invalid application of `sizeof' 14.9%
drivers/char/drm/gamma_context.h: error: `DRM' declared as function return 24.8%
drivers/char/drm/gamma_context.h: error: `DRM' previously defined here     24.8%
drivers/char/drm/gamma_context.h: error: `arg' undeclared (first use in th 14.5%
drivers/char/drm/gamma_context.h: error: `dev' undeclared (first use in th 10.3%
drivers/char/drm/gamma_context.h: error: `filp' undeclared (first use in t 12.4%
drivers/char/drm/gamma_context.h: error: called object is not a function   26.9%
drivers/char/drm/gamma_context.h: error: redefinition of `DRM'             22.8%
drivers/char/drm/gamma_context.h: error: structure has no member named `de 16.5%
drivers/char/drm/gamma_drv.h: error: `DRM' declared as function returning  31.1%
drivers/char/drm/gamma_lists.h: error: `DRM' declared as function returnin 18.6%
drivers/char/drm/gamma_lists.h: error: `DRM' previously defined here       18.6%
drivers/char/drm/gamma_lists.h: error: `bl' undeclared (first use in this  18.6%
drivers/char/drm/gamma_lists.h: error: called object is not a function      8.2%
drivers/char/drm/gamma_lists.h: error: redefinition of `DRM'               18.6%
drivers/char/drm/gamma_lock.h: error: `DRM' declared as function returning 10.3%
drivers/char/drm/gamma_lock.h: error: `DRM' previously defined here         8.2%
drivers/char/drm/gamma_lock.h: error: `context' undeclared (first use in t  8.2%
drivers/char/drm/gamma_lock.h: error: `dev' undeclared (first use in this   8.2%
drivers/char/drm/gamma_lock.h: error: called object is not a function      16.5%
drivers/char/drm/gamma_lock.h: error: redefinition of `DRM'                10.3%
drivers/char/drm/gamma_old_dma.h: error: `DRM' declared as function return 10.3%
drivers/char/drm/gamma_old_dma.h: error: `DRM' previously defined here     10.3%
drivers/char/drm/gamma_old_dma.h: error: `filp' undeclared (first use in t  6.2%
drivers/char/drm/gamma_old_dma.h: error: called object is not a function   18.6%
drivers/char/drm/gamma_old_dma.h: error: redefinition of `DRM'             10.3%
drivers/char/drm/gamma_old_dma.h: error: structure has no member named `ne 18.6%
drivers/char/ipmi/ipmi_msghandler.c: error: (near initialization for `__ks 14.9%
drivers/char/ipmi/ipmi_msghandler.c: error: __ksymtab_proc_ipmi_root cause 14.9%
drivers/char/ipmi/ipmi_msghandler.c: error: `proc_ipmi_root' undeclared he 14.9%
drivers/char/ipmi/ipmi_msghandler.c: error: initializer element is not con 14.9%
drivers/mtd/chips/amd_flash.c: error: structure has no member named `buswi 14.9%
drivers/mtd/chips/jedec.c: error: structure has no member named `buswidth' 13.2%
include/asm-i386/mach-default/mach_apic.h: error: `phys_cpu_present_map' u  4.9%
include/asm-i386/mach-default/mach_apic.h: error: dereferencing pointer to  8.2%
include/asm-i386/mach-visws/do_timer.h: error: `i8259A_lock' undeclared (f 14.1%

Grant.


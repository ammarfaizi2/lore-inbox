Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUHRUdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUHRUdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267643AbUHRUdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:33:53 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:977 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267638AbUHRUdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:33:50 -0400
Date: Wed, 18 Aug 2004 13:33:48 -0700
From: Paul Jackson <pj@sgi.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Does io_remap_page_range() take 5 or 6 args?
Message-Id: <20040818133348.7e319e0e.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is up with io_remap_page_range()?  Seems like half of its
mentions take 5 args, and half 6 args (the 6th arg being 'space').

Grep'ing and eyeballing in 2.6.8.1-mm1 just now shows the following
files using 5 args:

        arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c
        arch/ia64/sn/io/sn2/xbow.c
        arch/sh/kernel/cpu/sh4/sq.c
        drivers/video/acornfb.c
        drivers/video/controlfb.c
        drivers/video/fbmem.c
        include/asm-alpha/pgtable.h
        include/asm-arm/pgtable.h
        include/asm-arm26/pgtable.h
        sound/core/pcm_native.c

and the following files using 6 args:

        arch/sparc/mm/generic.c
        arch/sparc64/kernel/pci.c
        arch/sparc64/kernel/pci.c
        arch/sparc64/kernel/sparc64_ksyms.c
        arch/sparc64/mm/generic.c
        drivers/char/drm/drm_vm.h
        drivers/sbus/char/vfc_dev.c
        drivers/video/fbmem.c
        drivers/video/sbuslib.c
        include/asm-sparc/pgtable.h
        include/asm-sparc64/pgtable.h

I'm noticing this trying to build 2.6.8.1-mm1 sparc64, using crosstool
and 'make defconfig'.   It errors out with:

 $ make sound/core/pcm_native.o
 CC [M]  sound/core/pcm_native.o
 sound/core/pcm_native.c: In function `snd_pcm_mmap_data':
 sound/core/pcm_native.c:3088: error: too few arguments to function `io_remap_page_range'

My dimm recollection is that this error has been here a while, but that
I've just been commenting CONFIG_SOUND out, since I really didn't care
about either sound nor about sparc64 (only that I wasn't contributing
further grief to sparc64 with my cpumask and cpuset stuff).

Does anyone know the story behind this odd inconsistency?

Better yet, is anyone signed up to resolve this?  No, I'm not
volunteering ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

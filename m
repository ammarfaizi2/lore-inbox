Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWAKCYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWAKCYy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 21:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWAKCYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 21:24:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:56802 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932590AbWAKCYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 21:24:53 -0500
Date: Tue, 10 Jan 2006 18:24:22 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: adobriyan@gmail.com, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.15-mm2: alpha broken
Message-Id: <20060110182422.d26c5d8b.pj@sgi.com>
In-Reply-To: <20060107154842.5832af75.akpm@osdl.org>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<20060107210646.GA26124@mipter.zuzino.mipt.ru>
	<20060107154842.5832af75.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> This is caused by the inclusion of user.h in kernel.h added by
> dump_thread-cleanup.patch.

This same build breakage showed up on ia64 sn2_defconfig,
and your patch fixes it nicely.  Thanks.

Acked-by: Paul Jackson <pj@sgi.com>


Andrian - I think that was your dump_thread-cleanup patch.

Please be sure to cross build other arch's when making non-local
changes, such as this one that affected the files:

    arch/alpha/kernel/alpha_ksyms.c
    arch/arm26/kernel/armksyms.c
    arch/cris/kernel/crisksyms.c
    arch/cris/kernel/process.c
    arch/frv/kernel/frv_ksyms.c
    arch/frv/kernel/process.c
    arch/h8300/kernel/h8300_ksyms.c
    arch/h8300/kernel/process.c
    arch/m32r/kernel/m32r_ksyms.c
    arch/m32r/kernel/process.c
    arch/m68k/kernel/m68k_ksyms.c
    arch/m68knommu/kernel/m68k_ksyms.c
    arch/m68knommu/kernel/process.c
    arch/s390/kernel/process.c
    arch/sh64/kernel/process.c
    arch/sh64/kernel/sh_ksyms.c
    arch/sh/kernel/process.c
    arch/sh/kernel/sh_ksyms.c
    arch/sparc64/kernel/binfmt_aout32.c
    arch/sparc64/kernel/sparc64_ksyms.c
    arch/sparc/kernel/sparc_ksyms.c
    arch/v850/kernel/process.c
    arch/v850/kernel/v850_ksyms.c
    fs/binfmt_aout.c
    fs/binfmt_flat.c
    include/asm-um/processor-generic.h
    include/linux/kernel.h

Sure, it consumes some time, but better you do it once, then each of
several of us have to first do a bisection on Andrew's gazillion
patches to find the culprit, and then stare at the patch until the light
bulb goes on in our dimm brains, only to grep back through the lkml
messages to find that we are not alone in our misery.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWH1SeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWH1SeX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWH1SeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:34:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751314AbWH1SeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:34:22 -0400
Date: Mon, 28 Aug 2006 11:34:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: mel@skynet.ie (Mel Gorman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm3
Message-Id: <20060828113403.868c6c9c.akpm@osdl.org>
In-Reply-To: <20060828090754.GA21146@skynet.ie>
References: <20060826160922.3324a707.akpm@osdl.org>
	<20060828090754.GA21146@skynet.ie>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 10:07:54 +0100
mel@skynet.ie (Mel Gorman) wrote:

> On (26/08/06 16:09), Andrew Morton didst pronounce:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/
> > 
> 
> This failed to build on two x86_64 machines I have access to with (one
> on test.kernel.org);
> 
>   OBJCOPY arch/x86_64/boot/compressed/vmlinux.bin
>   BFD: Warning: Writing section `.data.percpu' to huge (ie negative)
>   file offset 0x80471000.
>   /usr/local/autobench/sources/x86_64-cross/gcc-3.4.0-glibc-2.3.2/bin/x86_64-unknown-linux-gnu-objcopy:
>   arch/x86_64/boot/compressed/vmlinux.bin: File truncated
>   make[2]: *** [arch/x86_64/boot/compressed/vmlinux.bin] Error 1
>   make[1]: *** [arch/x86_64/boot/compressed/vmlinux] Error 2
>   make: *** [bzImage] Error 2
>   08/26/06-17:16:14 Build the kernel. Failed rc = 2
>   08/26/06-17:16:14 build: kernel build Failed rc = 1
>   08/26/06-17:16:14 command complete: (2) rc=126
>   Failed and terminated the run
>    Fatal error, aborting autorun
> 
> CONFIG_NR_CPUS was 8. The build log can be seen at
> http://test.kernel.org/abat/45342/debug/test.log.0 and the .config is at
> http://test.kernel.org/abat/45342/build/dotconfig . I haven't done any
> further investigation in case this is a known problem. If it's new, I'll
> start digging.
> 

hm.  It works for me.  

BINUTILS_DIR=binutils-2.16.1
GCC_DIR=gcc-4.0.2
GLIBC_DIR=glibc-2.3.6

I guess one could poke around in vmlinux, find out what's happened to the
.data.percpu section.  `readelf --sections vmlinux', etc?


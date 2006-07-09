Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbWGIIZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbWGIIZu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 04:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWGIIZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 04:25:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33035 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030433AbWGIIZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 04:25:49 -0400
Date: Sun, 9 Jul 2006 10:25:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Reuther <mreuther@umich.edu>, linux-kernel@vger.kernel.org
Subject: Re: Compile Error on 2.6.17-mm6
Message-ID: <20060709082546.GB13938@stusta.de>
References: <200607072222.31586.mreuther@umich.edu> <20060708174347.76391c7b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060708174347.76391c7b.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 05:43:47PM -0700, Andrew Morton wrote:
> On Fri, 7 Jul 2006 22:22:16 -0400
> Matt Reuther <mreuther@umich.edu> wrote:
> 
> > Here is the error:
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > arch/i386/kernel/built-in.o(.text+0xe282): In function 
> > `cpu_request_microcode':
> > arch/i386/kernel/microcode.c:544: undefined reference to `request_firmware'
> > arch/i386/kernel/built-in.o(.text+0xe304):arch/i386/kernel/microcode.c:573: 
> > undefined reference to `release_firmware'
> 
> CONFIG_FW_LOADER=m
> CONFIG_MICROCODE=y
> 
> So
> 
> config MICROCODE
> 	tristate "/dev/cpu/microcode - Intel IA32 CPU microcode support"
> 	depends on FW_LOADER
> 
> is not sufficient.

This should be sufficient and prevent the above problem (it was only a 
problem if MICROCODE was a bool).

> There's a fix for this, but I cannot remember what it
> is.  Help.

The above dependency is technically correct, but since FW_LOADER is only 
an internal helper variable the more user friendly solution is:

config MICROCODE
	tristate "/dev/cpu/microcode - Intel IA32 CPU microcode support"
	select FW_LOADER

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


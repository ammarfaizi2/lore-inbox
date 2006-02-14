Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbWBNNRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWBNNRS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 08:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWBNNRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 08:17:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41489 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161043AbWBNNRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 08:17:17 -0500
Date: Tue, 14 Feb 2006 14:17:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc3-mm1: i386 compilation broken
Message-ID: <20060214131715.GA10701@stusta.de>
References: <20060214014157.59af972f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214014157.59af972f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 01:41:57AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc2-mm1:
>...
> +x86_64-fix-string.patch
>...
>  x86_64 tree updates.
>...

This patch breaks the compilation on i386:

<--  snip  -->

...
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function 
`show_type':intel_cacheinfo.c:(.text+0x768b): undefined reference to `strcpy'
:intel_cacheinfo.c:(.text+0x769d): undefined reference to `strcpy'
:intel_cacheinfo.c:(.text+0x76af): undefined reference to `strcpy'
:intel_cacheinfo.c:(.text+0x76c1): undefined reference to `strcpy'
kernel/built-in.o: In function `prof_cpu_mask_read_proc':profile.c:(.text+0x4a84): undefined reference to `strcpy'
kernel/built-in.o:clocksource.c:(.text+0x17bc1): more undefined references to `strcpy' follow
drivers/built-in.o: In function `zoran_write':zoran_procfs.c:(.text+0x41edd6): undefined reference to `strchr'
drivers/built-in.o: In function `cpia_read_proc':cpia.c:(.text+0x42d175): undefined reference to `strcpy'
:cpia.c:(.text+0x42d34c): undefined reference to `strcpy'
:cpia.c:(.text+0x42d35c): undefined reference to `strcpy'
:cpia.c:(.text+0x42d4d7): undefined reference to `strcpy'
:cpia.c:(.text+0x42d5df): undefined reference to `strcpy'
drivers/built-in.o:cpia.c:(.text+0x42d8b9): more undefined references to `strcpy' follow
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Andi, you should have known that your patch could breaks i386 now that 
we are no longer using no-unit-at-a-time:
  http://lkml.org/lkml/2004/11/8/284


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


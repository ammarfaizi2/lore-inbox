Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWCCXBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWCCXBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWCCXBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:01:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5645 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750738AbWCCXBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:01:50 -0500
Date: Sat, 4 Mar 2006 00:01:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ".geert"@linux-m68k.org, zippel@linux-m68k.org,
       linux-m68k@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rc regression: m68k CONFIG_RMW_INSNS=n compile broken
Message-ID: <20060303230149.GB9295@stusta.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The m68k defconfig does no longer compile in 2.6.16-rc:

<--  snip  -->

...
  CC      fs/file_table.o
fs/file_table.c: In function `fget':
fs/file_table.c:170: warning: implicit declaration of function `cmpxchg'
...
  LD      .tmp_vmlinux1
fs/built-in.o(.text+0x275a): In function `fget':
: undefined reference to `cmpxchg'
fs/built-in.o(.text+0x27da): In function `fget_light':
: undefined reference to `cmpxchg'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


It seems the problem is that in the CONFIG_RMW_INSNS=n case, there's no 
cmpxchg #define in include/asm-m68k/system.h required for the 
atomic_add_unless #define in include/asm-m68k/atomic.h.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


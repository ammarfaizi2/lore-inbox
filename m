Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWICRZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWICRZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 13:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWICRZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 13:25:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:531 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751446AbWICRZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 13:25:30 -0400
Date: Sun, 3 Sep 2006 19:25:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@kernel.dk>,
       David Howells <dhowells@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc5-mm1: sysfs_init() related compile error
Message-ID: <20060903172528.GB4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following compile error on h8300:

<--  snip  -->

...
  CC      arch/h8300/kernel/asm-offsets.s
In file included from /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/include/linux/kobject.h:22,
                 from /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/include/linux/sysdev.h:24,
                 from /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/include/linux/sched.h:1605,
                 from /home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/arch/h8300/kernel/asm-offsets.c:12:
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/include/linux/sysfs.h:210: error: redefinition of 'sysfs_init'
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/include/linux/sysfs.h:136: error: previous definition of 'sysfs_init' was here
make[2]: *** [arch/h8300/kernel/asm-offsets.s] Error 1

<--  snip  -->

The problem is a merge conflict since both git-block.patch and 
gregkh-driver-sysfs-add-proper-sysfs_init-prototype.patch added
sysfs_init() prototypes and CONFIG_SYSFS=n dummmies to sysfs.h .

The git-block.patch version lacks the __must_check annotation.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-- 
VGER BF report: H 0.332312

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbTIWNgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 09:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTIWNgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 09:36:37 -0400
Received: from ns2.anankeit.com.br ([200.189.180.110]:39147 "HELO
	mail.m2b.com.br") by vger.kernel.org with SMTP id S261277AbTIWNgf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 09:36:35 -0400
X-Qmail-Scanner-Mail-From: thiago@ananke.com.br via mail
X-Qmail-Scanner-Rcpt-To: cafuego@cafuego.net,linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.16 (Clear:. Processed in 0.173044 secs)
Date: Tue, 23 Sep 2003 10:36:24 -0300
From: Thiago Rondon <thiago@ananke.com.br>
To: Peter Lieverdink <cafuego@cafuego.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cryptoloop hard lockup 2.6.0-test5-mm4
Message-ID: <20030923133624.GA2479@ananke.com.br>
References: <5.1.0.14.2.20030923151949.01d37568@caffeine.cc.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030923151949.01d37568@caffeine.cc.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Can you please test that?

--- mm/swapfile.c.orig  2003-09-23 09:34:16.000000000 -0400
+++ mm/swapfile.c       2003-09-23 09:34:39.000000000 -0400
@@ -1223,7 +1223,7 @@
        unsigned int type;
        int i, prev;
        int error;
-       static int least_priority;
+       static int least_priority = 0;
        union swap_header *swap_header = 0;
        int swap_header_version;
        int nr_good_pages = 0;


On Tue, Sep 23, 2003 at 03:25:47PM +1000, Peter Lieverdink wrote:
> I just had a play with an article from an old LinuxJournal, to see if I 
> could set up a cryptoloop homedir on my Debian unstable box. Found making 
> an fs on the loop device locks the kernel hard. (need reset button) When 
> using loopback without crypto it all works fine.
> 
> Ayone else have the same experience?
> 
> Using util-linux 2.12, aes (same prob with twofish, blowfish).
> 
> Crash dump is attached, as is kernel config. When not running uml-switch, 
> the crash still occurs but doesn't print the VM: messages. (I don't have a 
> swap partition anyway, so what's that all about?)
> 
> - Peter.

> kahlua:~# modprobe cryptoloop
> loop: loaded (max 8 devices)
> kahlua:~# modprobe aes
> kahlua:~# losetup -e aes -k 128 /dev/loop0 /home/cafuego.img
> kahlua:~# mkfs -t ext2 /dev/loop0
> mke2fs 1.35-WIP (21-Aug-2003)
> Filesystem label=
> OS type: Linux
> Block size=1024 (log=0)
> Fragment size=1024 (log=0)
> 131072 inodes, 524288 blocks
> 26214 blocks (5.00%) reserved for the super user
> First data block=1
> 64 block groups
> 8192 blocks per group, 8192 fragments per group
> 2048 inodes per group
> Superblock backups stored on blocks:
>         8193, 24577, 40961, 57345, 73729, 204801, 221185, 401409
> 
> Writing inode tables: done
> Writing superblocks and filesystem accounting information: do_wp_page: bogus page at address 0804d056
> VM: killing process uml_switch
> swap_dup: Bad swap file entry 90885fdb
> VM: killing process uml_switch
> swap_dup: Bad swap file entry 286be58f
> VM: killing process uml_switch
> Debug: sleeping fucntion called from invalid context at include/linux/rwsem.h:43
> in_atomic():0, irqs_disabled():1
> Call Trace:



-- 
-Thiago Rondon,
MAKETRADEFAIR.ORG

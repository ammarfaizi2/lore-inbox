Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264283AbUE2MOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUE2MOT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 08:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbUE2MOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 08:14:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27085 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264283AbUE2MOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 08:14:16 -0400
Date: Sat, 29 May 2004 14:14:08 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Artemio <theman@artemio.net>, bcollins@debian.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [2.6 patch] let IEEE1394 select NET
Message-ID: <20040529121408.GM16099@fs.tum.de>
References: <200405291424.43982.theman@artemio.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405291424.43982.theman@artemio.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 02:24:43PM +0300, Artemio wrote:

> Hello all!

Hi Artemio!

> I am trying to compile a clean, non-patched 2.6.6 kernel from right from 
> kernel.org, using gcc 3.3.2. I have tried both gcc 3.3.2 in uclibc i386 root 
> distribution and gcc 3.3.2-6mdk in mandrake 10.0. With both gcc's, at the end 
> of all, I get:
> 
> [make output]
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x6ef62): In function `hpsb_alloc_packet':
> : undefined reference to `alloc_skb'
> drivers/built-in.o(.text+0x6f68f): In function `hpsb_packet_sent':
> : undefined reference to `skb_unlink'
> drivers/built-in.o(.text+0x6f82d): In function `hpsb_send_packet':
> : undefined reference to `skb_queue_tail'
> drivers/built-in.o(.text+0x70199): In function `abort_requests':
> : undefined reference to `skb_dequeue'
> drivers/built-in.o(.text+0x7025b): In function `queue_packet_complete':
> : undefined reference to `skb_queue_tail'
> drivers/built-in.o(.text+0x702bf): In function `hpsbpkt_thread':
> : undefined reference to `skb_dequeue'
> drivers/built-in.o(.text+0x6f006): In function `hpsb_free_packet':
> : undefined reference to `__kfree_skb'
> make: *** [.tmp_vmlinux1] Error 1
> [/make output]
> 
> Could someone please tell me what to do? :-/
> 
> I'd really appreciate any help. 
>...

Thanks for this report.

FireWire support requires Networking support.

The following patch lets FireWire support automatically select 
Networking support:

--- linux-2.6.7-rc1-mm1-full/drivers/ieee1394/Kconfig.old	2004-05-29 14:07:55.000000000 +0200
+++ linux-2.6.7-rc1-mm1-full/drivers/ieee1394/Kconfig	2004-05-29 14:08:13.000000000 +0200
@@ -4,6 +4,7 @@
 
 config IEEE1394
 	tristate "IEEE 1394 (FireWire) support"
+	select NET
 	help
 	  IEEE 1394 describes a high performance serial bus, which is also
 	  known as FireWire(tm) or i.Link(tm) and is used for connecting all


> Artemio.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


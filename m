Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271977AbRH2OVR>; Wed, 29 Aug 2001 10:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271976AbRH2OVH>; Wed, 29 Aug 2001 10:21:07 -0400
Received: from wit.mht.bme.hu ([152.66.80.190]:42892 "HELO wit.wit.mht.bme.hu")
	by vger.kernel.org with SMTP id <S271977AbRH2OUy>;
	Wed, 29 Aug 2001 10:20:54 -0400
Date: Wed, 29 Aug 2001 16:21:05 +0200 (CEST)
From: Csanad Szabo <csanad.szabo@wit.mht.bme.hu>
To: Kernel <linux-kernel@vger.kernel.org>
Cc: Netfilter <netfilter@lists.samba.org>
Subject: kernel panic because of route manipulation
Message-ID: <Pine.LNX.4.02.10108281433410.1828-100000@wit.wit.mht.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm writing a kernel module that uses the netfilter framework to catch IP
packets upon which I want to manipulate the kernel routing table.

I use the ip_rt_ioctl (in: net/ipv4/fib_frontend.c) to manipulate the
routing table. I succeeded to manipulate it whenever my kernel module is
not registered to a netfilter hook.

Unfortunately, whenever my kernel module has registered a function to a
netfilter hook and I want to add/delete a valid routing entry it leads to
kernel panic. I found out that the function 'rtmsg_fib' (in: 
net/ipv4/fib_hash.c) calls 'alloc_skb' nonatomically (the kernel
error msg can be found in net/core/skbuff.c, lines 172-4) although the
arguments passed to alloc_skb, i.e., size and gfp_mask, are the same as in
those cases when the routing entry is taken successfully.

Is there any spinlock, semaphore or memory management operation which I
have forgotten to investigate? Or having a pointer to a packet I cannot
freely manipulate the routing table as in any other case? What can lead to
such a kernel panic?

I'm using the kernel 2.4.3 on an HP Omnibook 900 (i686). If anyone can
help me I'm willing to send him the kernel module and the list of
the changes (printk with KERN_ALERT) I made.

Regards,

	Csanad
--------------------------------------------------------------------------
Csanad Szabo, Ph.D. Student                    mail: csanad@wit.mht.bme.hu
Technical University of Budapest          Department of Telecommunications




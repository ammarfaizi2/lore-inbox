Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271694AbRHUO1G>; Tue, 21 Aug 2001 10:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271698AbRHUO05>; Tue, 21 Aug 2001 10:26:57 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:49156 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271694AbRHUO0u>; Tue, 21 Aug 2001 10:26:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.9 ?
Date: Tue, 21 Aug 2001 16:33:27 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20010821154617.4671f85d.skraw@ithnet.com>
In-Reply-To: <20010821154617.4671f85d.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010821142659Z16034-32384+269@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 21, 2001 03:46 pm, Stephan von Krawczynski wrote:
> Hello all,
> 
> can anybody enlighten me about the following kernel-message:
> 
> Aug 21 14:37:39 admin kernel: __alloc_pages: 3-order allocation failed.
> Aug 21 14:37:39 admin kernel: __alloc_pages: 2-order allocation failed. 
> Aug 21 14:37:39 admin kernel: __alloc_pages: 3-order allocation failed.
> Aug 21 14:37:39 admin kernel: __alloc_pages: 3-order allocation failed.
> Aug 21 14:37:39 admin kernel: __alloc_pages: 2-order allocation failed.
> Aug 21 14:37:39 admin kernel: __alloc_pages: 3-order allocation failed.
> Aug 21 14:37:39 admin last message repeated 69 times
> 
> I get tons of them during verifying burned CDs with xcdroast (which takes
> a really long time, and must have some problem therefore).  I would not 
> worry you if it didn't work with earlier kernel-versions, but in fact it
> did. 

The following patch will tell us more about the failure, could you please
apply (patch -p0): 

--- ../2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
+++ ./mm/page_alloc.c	Mon Aug 20 22:05:40 2001
@@ -502,7 +502,7 @@
 	}
 
 	/* No luck.. */
-	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order);
+	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed (gfp=0x%x/%i).\n", order, gfp_mask, !!(current->flags & PF_MEMALLOC));
 	return NULL;
 }
 

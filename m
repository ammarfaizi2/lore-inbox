Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269412AbRHTVOK>; Mon, 20 Aug 2001 17:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRHTVOA>; Mon, 20 Aug 2001 17:14:00 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:34321 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269412AbRHTVNu>; Mon, 20 Aug 2001 17:13:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrey Nekrasov <andy@spylog.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8/2.4.9 problem
Date: Mon, 20 Aug 2001 23:20:37 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200108171310.PAA26032@lambik.cc.kuleuven.ac.be> <20010819205452Z16128-32383+429@humbolt.nl.linux.org> <20010820011356.A6667@spylog.ru>
In-Reply-To: <20010820011356.A6667@spylog.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010820211403Z16263-32383+585@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 19, 2001 11:13 pm, Andrey Nekrasov wrote:
> Hello.
> 
> I am have problem with "kernel: __alloc_pages: 0-order allocation failed."
> 
> 1. syslog kern.*
> 
>    ...
> 	 Aug 19 12:28:16 sol kernel: __alloc_pages: 0-order allocation failed.
> 	 Aug 19 12:28:37 sol last message repeated 364 times
> 	 Aug 19 12:29:17 sol last message repeated 47 times
> [etc]

Could you please try it with this patch, which will tell us a little more 
about what's happening (patch -p0):

--- ../2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
+++ ./mm/page_alloc.c	Mon Aug 20 22:05:40 2001
@@ -502,7 +502,7 @@
 	}
 
 	/* No luck.. */
-	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order);
+	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed (gfp=0x%x/%i).\n", order, gfp_mask, !!(current->flags & PF_MEMALLOC));
 	return NULL;
 }
 

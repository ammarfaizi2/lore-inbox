Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272102AbRH2Vzp>; Wed, 29 Aug 2001 17:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272098AbRH2Vzg>; Wed, 29 Aug 2001 17:55:36 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:56846 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272101AbRH2VzZ>; Wed, 29 Aug 2001 17:55:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Gergely Madarasz <gorgo@thunderchild.debian.net>,
        linux-kernel@vger.kernel.org
Subject: Re: vm problems
Date: Thu, 30 Aug 2001 00:02:27 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20010829131419.Z6202@thunderchild.ikk.sztaki.hu> <20010829134757.A6202@thunderchild.ikk.sztaki.hu>
In-Reply-To: <20010829134757.A6202@thunderchild.ikk.sztaki.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010829215542Z16262-32383+2341@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 29, 2001 01:47 pm, Gergely Madarasz wrote:
> On Wed, Aug 29, 2001 at 01:14:19PM +0200, Gergely Madarasz wrote:
> > Hello,
> > 
> > I get hundreds of this error message:
> > 
> > __alloc_pages: 0-order allocation failed.
> > 
> > The machine is an IBM x250 with 4G ram, the kernel is vanilla 2.4.9 and
> > 2.4.9-ac3, no swap, running bonnie++. When the memory fills up with cache,
> > I start receiving the error message. 
> 
> actually I thought I was running 2.4.9-ac3, but no, and I see the message
> is commented out in 2.4.9-ac3. Does this mean that it doesn't mean
> anything serious? Some of my processes were stuck in uninterruptible
> sleep, I couldn't even shutdown correctly, so there are some problems.

Please try it again with this patch so we can see what kind of allocation is failing:

--- 2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
+++ 2.4.9/mm/page_alloc.c	Mon Aug 20 22:05:40 2001
@@ -502,7 +502,8 @@
 	}
 
 	/* No luck.. */
-	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order);
+	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed (gfp=0x%x/%i).\n",
+		order, gfp_mask, !!(current->flags & PF_MEMALLOC));
 	return NULL;
 }
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131581AbRBMN5f>; Tue, 13 Feb 2001 08:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131584AbRBMN50>; Tue, 13 Feb 2001 08:57:26 -0500
Received: from ns.suse.de ([213.95.15.193]:50193 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131581AbRBMN5P>;
	Tue, 13 Feb 2001 08:57:15 -0500
Date: Tue, 13 Feb 2001 14:56:10 +0100
From: Andi Kleen <ak@suse.de>
To: Krzysztof Rusocki <kszysiu@braxis.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [?] __alloc_pages: 1-order allocation failed.
Message-ID: <20010213145610.A16767@gruyere.muc.suse.de>
In-Reply-To: <20010213105957.A16713@main.braxis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010213105957.A16713@main.braxis.co.uk>; from kszysiu@braxis.co.uk on Tue, Feb 13, 2001 at 10:59:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2001 at 10:59:57AM +0100, Krzysztof Rusocki wrote:
> 
> Hi,
> 
> Here's what i've found today in logs:
> 
> Feb 13 02:10:41 main kernel: __alloc_pages: 1-order allocation failed. 
> Feb 13 02:10:42 main last message repeated 143 times
> Feb 13 02:10:47 main kernel: ed. 
> Feb 13 02:10:47 main kernel: __alloc_pages: 1-order allocation failed. 
> Feb 13 02:50:30 main syslogd 1.3-3: restart (remote reception).
> 
> 
> After that there was possibly lock-up or reboot (i don't know, when i 
> connected to  the machine it was already running).
> 
> What can be possible cause of such things ?

When you add the following patch you should see the addresses of functions
that cause allocation failures. Look the hex value up in the System.map
then. For this XFS should be compiled in, not be a module.
Is it always the same address?




-Andi

Index: mm/page_alloc.c
===================================================================
RCS file: /cvs/linux-2.4-xfs/linux/mm/page_alloc.c,v
retrieving revision 1.32
diff -u -r1.32 page_alloc.c
--- mm/page_alloc.c	2000/12/17 19:15:00	1.32
+++ mm/page_alloc.c	2001/02/13 13:54:33
@@ -529,7 +529,8 @@
 	}
 
 	/* No luck.. */
-	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order);
+	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed from %p\n", 
+		order, __builtin_return_address(0));
 	return NULL;
 }
 

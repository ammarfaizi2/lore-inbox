Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262163AbREXQK7>; Thu, 24 May 2001 12:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262168AbREXQKt>; Thu, 24 May 2001 12:10:49 -0400
Received: from marine.sonic.net ([208.201.224.37]:13112 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S262163AbREXQKa>;
	Thu, 24 May 2001 12:10:30 -0400
Message-ID: <20010524090920.A24268@sonic.net>
Date: Thu, 24 May 2001 09:09:20 -0700
From: David Hinds <dhinds@sonic.net>
To: Praveen Srinivasan <praveens@stanford.edu>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] rsrc_mgr.c - null ptr fix for 2.4.4
In-Reply-To: <200105240734.f4O7YB404249@smtp1.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200105240734.f4O7YB404249@smtp1.Stanford.EDU>; from Praveen Srinivasan on Thu, May 24, 2001 at 12:35:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 12:35:17AM -0700, Praveen Srinivasan wrote:
> Hi,
> This fixes an unchecked ptr bug in the resource manager code for the PCMCIA 
> driver (rsrc_mgr.c).

I would instead suggest:

--- ../linux/./drivers/pcmcia/rsrc_mgr.c	Tue Mar  6 19:28:32 2001
+++ ./drivers/pcmcia/rsrc_mgr.c	Mon May  7 22:09:09 2001
@@ -189,6 +189,12 @@
     
     /* First, what does a floating port look like? */
     b = kmalloc(256, GFP_KERNEL);
+
+    if(b == NULL){
+      printk(" kmalloc failed!\n");
+      return;
+    }
+
     memset(b, 0, 256);
     for (i = base, most = 0; i < base+num; i += 8) {
 	if (check_io_resource(i, 8))

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRC3Bhr>; Thu, 29 Mar 2001 20:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbRC3Bhh>; Thu, 29 Mar 2001 20:37:37 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:266 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S129638AbRC3BhT>;
	Thu, 29 Mar 2001 20:37:19 -0500
Message-ID: <3AC3E32F.1050704@magenta-netlogic.com>
Date: Fri, 30 Mar 2001 02:36:47 +0100
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac26 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] Fix SMP lockup in usbdevfs
Content-Type: multipart/mixed;
 boundary="------------080100000406050208060308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080100000406050208060308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This fixes a lockup when calling the USBDEVFS_SUBMITURB ioctl in an SMP 
kernel.

Tony

-- 
Don't click on this sig - a cyberwoozle will eat your underwear.

tmh@magenta-netlogic.com        http://www.nothing-on.tv

--------------080100000406050208060308
Content-Type: text/plain;
 name="devio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devio.patch"

--- devio.c.old	Fri Mar 30 02:22:32 2001
+++ devio.c	Fri Mar 30 02:12:09 2001
@@ -175,6 +175,7 @@
                 return NULL;
         memset(as, 0, assize);
         as->urb.number_of_packets = numisoframes;
+        spin_lock_init(&as->urb.lock);
         return as;
 }
 
@@ -250,7 +251,7 @@
         struct dev_state *ps = as->ps;
 	struct siginfo sinfo;
 
-#if 1
+#if 0
 	printk(KERN_DEBUG "usbdevfs: async_completed: status %d errcount %d actlen %d pipe 0x%x\n", 
 	       urb->status, urb->error_count, urb->actual_length, urb->pipe);
 #endif

--------------080100000406050208060308--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263398AbREXHfE>; Thu, 24 May 2001 03:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263402AbREXHey>; Thu, 24 May 2001 03:34:54 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:42724 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263398AbREXHer>; Thu, 24 May 2001 03:34:47 -0400
Message-Id: <200105240734.f4O7YB404249@smtp1.Stanford.EDU>
Content-Type: text/plain; charset=US-ASCII
From: Praveen Srinivasan <praveens@stanford.edu>
Organization: Stanford University
To: torvalds@transmeta.com
Subject: [PATCH] rsrc_mgr.c - null ptr fix for 2.4.4 
Date: Thu, 24 May 2001 00:35:17 -0700
X-Mailer: KMail [version 1.2.2]
Cc: dhinds@zen.stanford.edu, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This fixes an unchecked ptr bug in the resource manager code for the PCMCIA 
driver (rsrc_mgr.c).

Praveen Srinivasan and Frederick Akalin

--- ../linux/./drivers/pcmcia/rsrc_mgr.c	Tue Mar  6 19:28:32 2001
+++ ./drivers/pcmcia/rsrc_mgr.c	Mon May  7 22:09:09 2001
@@ -189,6 +189,11 @@
     
     /* First, what does a floating port look like? */
     b = kmalloc(256, GFP_KERNEL);
+
+    if(b == NULL){
+      return;
+    }
+
     memset(b, 0, 256);
     for (i = base, most = 0; i < base+num; i += 8) {
 	if (check_io_resource(i, 8))

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263390AbREXHXo>; Thu, 24 May 2001 03:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263391AbREXHXe>; Thu, 24 May 2001 03:23:34 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:5091 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263390AbREXHXS>; Thu, 24 May 2001 03:23:18 -0400
Message-Id: <200105240723.f4O7NG403563@smtp1.Stanford.EDU>
Content-Type: text/plain; charset=US-ASCII
From: Praveen Srinivasan <praveens@stanford.edu>
Organization: Stanford University
To: torvalds@transmeta.com
Subject: [PATCH] bulkmem.c - null ptr fixes for 2.4.4
Date: Thu, 24 May 2001 00:24:21 -0700
X-Mailer: KMail [version 1.2.2]
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        dhinds@zen.stanford.edu
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Using the Stanford checker, we searched for null-pointer bugs in the linux 
kernel code. This patch fixes numerous unchecked pointers in the PCMCIA 
bulkmem driver. 

Praveen Srinivasan and Frederick Akalin

--- ../linux/./drivers/pcmcia/bulkmem.c	Tue Mar  6 19:28:32 2001
+++ ./drivers/pcmcia/bulkmem.c	Mon May  7 21:53:49 2001
@@ -229,6 +229,10 @@
 	else {
 	    erase->State = 1;
 	    busy = kmalloc(sizeof(erase_busy_t), GFP_KERNEL);
+
+	    if(busy == NULL) {
+	      return;
+	    }
 	    busy->erase = erase;
 	    busy->client = handle;
 	    init_timer(&busy->timeout);
@@ -360,6 +364,10 @@
 	if ((device.dev[i].type != CISTPL_DTYPE_NULL) &&
 	    (device.dev[i].size != 0)) {
 	    r = kmalloc(sizeof(*r), GFP_KERNEL);
+	    if(r == NULL) {
+	      return;
+	    }
+
 	    r->region_magic = REGION_MAGIC;
 	    r->state = 0;
 	    r->dev_info[0] = '\0';

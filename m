Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291446AbSBHGvM>; Fri, 8 Feb 2002 01:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291445AbSBHGux>; Fri, 8 Feb 2002 01:50:53 -0500
Received: from holomorphy.com ([216.36.33.161]:61840 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291444AbSBHGun>;
	Fri, 8 Feb 2002 01:50:43 -0500
Date: Thu, 7 Feb 2002 22:50:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix aha1542.c setup_str[] not protected by #ifndef MODULE
Message-ID: <20020208065036.GH11971@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, axboe@suse.de,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, this at least shuts up a warning coming from aha1542.c
setup_str[] is just not needed #ifdef MODULE Not sure what else might
be going on with this, but if the patch looks good to you, here it is.


Cheers,
Bill

--- linux/drivers/scsi/aha1542.c.orig	Thu Feb  7 22:34:49 2002
+++ linux/drivers/scsi/aha1542.c	Thu Feb  7 22:35:30 2002
@@ -111,8 +111,6 @@
 static int setup_busoff[MAXBOARDS];
 static int setup_dmaspeed[MAXBOARDS] __initdata = { -1, -1, -1, -1 };
 
-static char *setup_str[MAXBOARDS] __initdata;
-
 /*
  * LILO/Module params:  aha1542=<PORTBASE>[,<BUSON>,<BUSOFF>[,<DMASPEED>]]
  *
@@ -959,6 +957,7 @@
 }
 
 #ifndef MODULE
+static char *setup_str[MAXBOARDS] __initdata;
 static int setup_idx = 0;
 
 void __init aha1542_setup(char *str, int *ints)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316899AbSGCEeE>; Wed, 3 Jul 2002 00:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSGCEeD>; Wed, 3 Jul 2002 00:34:03 -0400
Received: from pacman.mweb.co.za ([196.2.45.77]:24968 "EHLO pacman.mweb.co.za")
	by vger.kernel.org with ESMTP id <S316899AbSGCEeC>;
	Wed, 3 Jul 2002 00:34:02 -0400
Subject: [PATCH] Replacing strtok with strsep
From: Bongani <bonganilinux@mweb.co.za>
To: langa2@kph.uni-mainz.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-1mdk 
Date: 03 Jul 2002 06:39:03 +0200
Message-Id: <1025671145.1499.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

You are listed as the maintainer of this driver so I'm sending this to
you. This patch is against 2.5.24, it replaces strtok with a thread safe
strsep as listed on the Kernel-Janitor's TODO file. Could you please
verify that it is OK.

Thanx


--- linux-2.5/drivers/scsi/ibmmca.c_orig	Wed Jun 26 23:50:11 2002
+++ linux-2.5/drivers/scsi/ibmmca.c	Wed Jun 26 23:50:40 2002
@@ -1406,9 +1406,8 @@
    io_base = 0;
    id_base = 0;
    if (str) {
-      token = strtok(str,",");
       j = 0;
-      while (token) {
+      while (token = strsep(&str,",")) {
 	 if (!strcmp(token,"activity")) display_mode |= LED_ACTIVITY;
 	 if (!strcmp(token,"display")) display_mode |= LED_DISP;
 	 if (!strcmp(token,"adisplay")) display_mode |= LED_ADISP;
@@ -1424,7 +1423,6 @@
 	      scsi_id[id_base++] = simple_strtoul(token,NULL,0);
 	    j++;
 	 }
-	 token = strtok(NULL,",");
       }
    } else if (ints) {
       for (i = 0; i < IM_MAX_HOSTS && 2*i+2 < ints[0]; i++) {




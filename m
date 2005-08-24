Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbVHXTHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbVHXTHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbVHXTHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:07:51 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:41170 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751411AbVHXTHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:07:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=g4hH1gpsThyP6nrRxC5aq85DR2uWELa9NWl0OoNXonDLxf2EuCE1FOzD+Cn6hLkn6Y8msSvwiLrwgikq+0a8EJKdrbhYX44As2IYHvOm6XeuC0qWvsOPmGgIOMlvFSHbnW+2f6AOOySikHKrv39ZdaUEhycMwHmpS8bStRYu9YQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] exterminate strtok - drivers/video/au1100fb.c
Date: Wed, 24 Aug 2005 21:08:32 +0200
User-Agent: KMail/1.8.2
Cc: ppopov@mvista.com, source@mvista.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508242108.32885.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since strtok() died in 2002 let's not use it - use strsep() instead which
is the replacement function.

Note: I've not been able to test this patch since I lack both hardware and 
a cross compiler, so if someone else could please check it and sign off on 
it before I send it to Andrew for inclusion in -mm I'd appreciate it.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 au1100fb.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.13-rc6-mm2-orig/drivers/video/au1100fb.c	2005-08-17 21:51:59.000000000 +0200
+++ linux-2.6.13-rc6-mm2/drivers/video/au1100fb.c	2005-08-24 18:58:18.000000000 +0200
@@ -614,7 +614,7 @@ void au1100fb_cleanup(struct fb_info *in
 
 void au1100fb_setup(char *options, int *ints)
 {
-	char* this_opt;
+	char *this_opt;
 	int i;
 	int num_panels = sizeof(panels)/sizeof(struct known_lcd_panels);
 
@@ -622,8 +622,9 @@ void au1100fb_setup(char *options, int *
 	if (!options || !*options)
 		return;
 
-	for(this_opt=strtok(options, ","); this_opt;
-	    this_opt=strtok(NULL, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
+		if (!*this_opt)
+			continue;
 		if (!strncmp(this_opt, "panel:", 6)) {
 #if defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100)
 			/* Read Pb1100 Switch S10 ? */



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTDJQDM (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 12:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264084AbTDJQDM (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 12:03:12 -0400
Received: from smtp02.web.de ([217.72.192.151]:21783 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S264082AbTDJQDL (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 12:03:11 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: Bruno Boettcher <bboett@adlp.org>
Subject: Re: 2.5.67 compile problem...
Date: Thu, 10 Apr 2003 18:14:35 +0200
User-Agent: KMail/1.5
References: <20030408180604.GA3709@adlp.org> <20030410142506.GM29225@adlp.org> <200304101806.59241.freesoftwaredeveloper@web.de>
In-Reply-To: <200304101806.59241.freesoftwaredeveloper@web.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304101814.35455.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 April 2003 18:06, Michael Buesch wrote:
> On Thursday 10 April 2003 16:25, Bruno Boettcher wrote:
> > On Tue, Apr 08, 2003 at 08:56:12PM +0200, Michael Buesch wrote:
> > > This may fix it. (It's not tested)
> >
> > partly :D
>
> oops. :) Give this one a try:
> (patch against 2.5.67)
sorry prevoiusly posted patch was wrong.
I hope this one is correct. :D

--- drivers/block/ps2esdi.c.orig	2003-04-10 17:44:57.000000000 +0200
+++ drivers/block/ps2esdi.c	2003-04-10 18:10:13.000000000 +0200
@@ -165,7 +165,6 @@
 	return 0;
 }				/* ps2esdi_init */
 
-module_init(ps2esdi_init);
 
 #ifdef MODULE
 
@@ -183,7 +182,7 @@
 	int drive;
 
 	for(drive = 0; drive < MAX_HD; drive++) {
-	        struct ps2_esdi_i_struct *info = &ps2esdi_info[drive];
+	        struct ps2esdi_i_struct *info = &ps2esdi_info[drive];
 
         	if (cyl[drive] != -1) {
 		  	info->cyl = info->lzone = cyl[drive];
@@ -200,6 +199,8 @@
 
 void
 cleanup_module(void) {
+	int i;
+
 	if(ps2esdi_slot) {
 		mca_mark_as_unused(ps2esdi_slot);
 		mca_set_adapter_procfn(ps2esdi_slot, NULL, NULL);
@@ -214,6 +215,8 @@
 		put_disk(ps2esdi_gendisk[i]);
 	}
 }
+#else /* MODULE */
+module_init(ps2esdi_init);
 #endif /* MODULE */
 
 /* handles boot time command line parameters */



Regards
Michael Buesch.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity


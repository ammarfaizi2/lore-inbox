Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbTDHSp1 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 14:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbTDHSp1 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 14:45:27 -0400
Received: from smtp01.web.de ([217.72.192.180]:14357 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261533AbTDHSpZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 14:45:25 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: bboett@adlp.org
Subject: Re: 2.5.67 compile problem...
Date: Tue, 8 Apr 2003 20:56:12 +0200
User-Agent: KMail/1.5
References: <20030408180604.GA3709@adlp.org>
In-Reply-To: <20030408180604.GA3709@adlp.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304082056.12305.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 April 2003 20:06, Bruno Boettcher wrote:
> Hello!
>
> after the yesterday cramfs problem, (BTW thanks for those who helped me
>     iron that out) here another compile problem, with
> the patched 2.5.66 thus mathing a 67 kernel:
>
> [...]
>
> again if someone has a suggestion....
> and please add me as CC to any reply


This may fix it. (It's not tested)

Regards Michael Buesch.



--- drivers/block/ps2esdi.c.orig	2003-04-08 20:50:17.000000000 +0200
+++ drivers/block/ps2esdi.c	2003-04-08 20:52:43.000000000 +0200
@@ -165,7 +165,6 @@
 	return 0;
 }				/* ps2esdi_init */
 
-module_init(ps2esdi_init);
 
 #ifdef MODULE
 
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


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbUKEONh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbUKEONh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbUKEONh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:13:37 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:4253 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262696AbUKEONc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:13:32 -0500
Message-ID: <418B8A8B.9020507@free.fr>
Date: Fri, 05 Nov 2004 15:13:31 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch} turn off pcspeaker when unloading
Content-Type: multipart/mixed;
 boundary="------------060307010609020305050804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060307010609020305050804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch turn off the pc speaker when you unload it : with whe current 
version if you unload it when the speacker beep, the beep never stop.

Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>

--------------060307010609020305050804
Content-Type: text/x-patch;
 name="pcspkr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcspkr.patch"

--- linux/drivers/input/misc/pcspkr.c	2004-10-18 23:54:32.000000000 +0200
+++ linux/drivers/input/misc/pcspkr.c	2004-11-05 15:08:57.000000000 +0100
@@ -89,6 +89,8 @@
 static void __exit pcspkr_exit(void)
 {
         input_unregister_device(&pcspkr_dev);
+	/* turn off the speaker */
+	pcspkr_event(NULL, EV_SND, SND_BELL, 0);
 }
 
 module_init(pcspkr_init);

--------------060307010609020305050804--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285381AbRLGCot>; Thu, 6 Dec 2001 21:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285383AbRLGCoh>; Thu, 6 Dec 2001 21:44:37 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:9344 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S285381AbRLGCod>; Thu, 6 Dec 2001 21:44:33 -0500
Message-ID: <3C102D0C.7070104@optonline.net>
Date: Thu, 06 Dec 2001 21:44:28 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: dledford@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] i810_audio fix for version 0.11
Content-Type: multipart/mixed;
 boundary="------------050104020202030405030908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050104020202030405030908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


With this patch, it seems to work fine. Without, it hangs on write.

--------------050104020202030405030908
Content-Type: text/plain;
 name="11fixed.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="11fixed.diff"

--- i810_audio.c.11	Thu Dec  6 18:07:35 2001
+++ linux/drivers/sound/i810_audio.c	Thu Dec  6 21:27:42 2001
@@ -955,8 +955,13 @@
 	if (!dmabuf->enable) {
 		outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
 		if(rec) {
+			/* must set trigger or we won't really start the
+			   converter, and we'll hang waiting for it to
+			   start. */
+			dmabuf->trigger = PCM_ENABLE_INPUT;
 			__start_adc(state);
 		} else {
+			dmabuf->trigger = PCM_ENABLE_OUTPUT;
 			__start_dac(state);
 		}
 		while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;

--------------050104020202030405030908--


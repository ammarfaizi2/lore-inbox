Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285020AbRLZXBz>; Wed, 26 Dec 2001 18:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285022AbRLZXBq>; Wed, 26 Dec 2001 18:01:46 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:14208 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S285020AbRLZXBg>; Wed, 26 Dec 2001 18:01:36 -0500
Message-ID: <3C2A56C7.5050801@allegientsystems.com>
Date: Wed, 26 Dec 2001 18:01:27 -0500
From: Nathan Bryant <nbryant@allegientsystems.com>
Organization: Allegient Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: saidani@info.unicaen.fr, dledford@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TEST of patch proposed for i810 audio
Content-Type: multipart/mixed;
 boundary="------------060104030408050109060208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060104030408050109060208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


maybe this patch will solve your problem, samir, maybe it won't; 
regardless, it should fix at least one corner case and is either 
obviously correct or start_*c is not ;-)

patch is against doug's 0.12.

--------------060104030408050109060208
Content-Type: text/plain;
 name="new.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="new.diff"

--- i810_audio.c.12	Wed Dec 19 02:04:06 2001
+++ linux/drivers/sound/i810_audio.c	Wed Dec 26 17:31:22 2001
@@ -952,12 +952,12 @@
 	 * the CIV value to the next sg segment to be played so that when
 	 * we call start_{dac,adc}, things will operate properly
 	 */
-	if (!dmabuf->enable && dmabuf->trigger) {
-		if(rec && dmabuf->count != dmabuf->dmasize) {
+	if (!dmabuf->enable && dmabuf->trigger && dmabuf->ready) {
+		if(rec && dmabuf->count < dmabuf->dmasize) {
 			outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
 			__start_adc(state);
 			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;
-		} else if(dmabuf->count) {
+		} else if(!rec && dmabuf->count) {
 			outb((inb(port+OFF_CIV)+1)&31, port+OFF_LVI);
 			__start_dac(state);
 			while( !(inb(port + OFF_CR) & ((1<<4) | (1<<2))) ) ;

--------------060104030408050109060208--


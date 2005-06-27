Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVF0Nh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVF0Nh0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVF0NdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:33:01 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:25829 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262074AbVF0MQw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:52 -0400
Message-Id: <20050627121409.748333000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:01 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Loschwitz <madkiss@madkiss.org>,
       Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-cinergyT2-ir-endian-fix.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 01/51] cinergyT2: endianness fix for raw remote-control keys
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Loschwitz <madkiss@madkiss.org>

Fixed litte/big-endian conversion for raw remote-control keys.

Signed-off-by: Martin Loschwitz <madkiss@madkiss.org>
Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/cinergyT2/cinergyT2.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.12-git8/drivers/media/dvb/cinergyT2/cinergyT2.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-06-27 13:22:35.000000000 +0200
@@ -699,6 +699,8 @@ static void cinergyt2_query_rc (void *da
 	for (n=0; len>0 && n<(len/sizeof(rc_events[0])); n++) {
 		int i;
 
+/*		dprintk(1,"rc_events[%d].value = %x, type=%x\n",n,le32_to_cpu(rc_events[n].value),rc_events[n].type);*/
+
 		if (rc_events[n].type == CINERGYT2_RC_EVENT_TYPE_NEC &&
 		    rc_events[n].value == ~0)
 		{
@@ -714,7 +716,7 @@ static void cinergyt2_query_rc (void *da
 			cinergyt2->rc_input_event = KEY_MAX;
 			for (i=0; i<sizeof(rc_keys)/sizeof(rc_keys[0]); i+=3) {
 				if (rc_keys[i+0] == rc_events[n].type &&
-				    rc_keys[i+1] == rc_events[n].value)
+				    rc_keys[i+1] == le32_to_cpu(rc_events[n].value))
 				{
 					cinergyt2->rc_input_event = rc_keys[i+2];
 					break;

--


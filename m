Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVCVGFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVCVGFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVCVCJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:09:31 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:11147 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262326AbVCVBfQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:16 -0500
Message-Id: <20050322013459.373118000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:10 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-core-cleanup.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 37/48] clear up confusion between ids and adapters
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

clear up confusion between ids and adapters (Kenneth Aafloy)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvbdev.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvbdev.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvbdev.c	2005-03-22 00:27:13.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvbdev.c	2005-03-22 00:27:34.000000000 +0100
@@ -51,9 +51,10 @@ static const char * const dnames[] = {
 	"net", "osd"
 };
 
-#define DVB_MAX_IDS              6
-#define nums2minor(num,type,id)  ((num << 6) | (id << 4) | type)
-#define MAX_DVB_MINORS           (DVB_MAX_IDS*64)
+#define DVB_MAX_ADAPTERS	8
+#define DVB_MAX_IDS		4
+#define nums2minor(num,type,id)	((num << 6) | (id << 4) | type)
+#define MAX_DVB_MINORS		(DVB_MAX_ADAPTERS*64)
 
 static struct class_simple *dvb_class;
 
@@ -267,7 +268,7 @@ static int dvbdev_get_free_adapter_num (
 {
 	int num = 0;
 
-	while (1) {
+	while (num < DVB_MAX_ADAPTERS) {
 		struct list_head *entry;
 		list_for_each (entry, &dvb_adapter_list) {
 			struct dvb_adapter *adap;

--


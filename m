Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265306AbUAPGOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 01:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265309AbUAPGOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 01:14:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:14044 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265306AbUAPGOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 01:14:46 -0500
Date: Thu, 15 Jan 2004 22:14:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix qla2xxx build for older gcc's
Message-Id: <20040115221446.63fdd808.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



drivers/scsi/qla2xxx/qla_def.h:1139: warning: unnamed struct/union that defines no instances
drivers/scsi/qla2xxx/qla_iocb.c:440: union has no member named `standard'

Older gcc's don't understand anonymous unions.


---

 drivers/scsi/qla2xxx/qla_def.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/scsi/qla2xxx/qla_def.h~qla2xxx-build-fix drivers/scsi/qla2xxx/qla_def.h
--- 25/drivers/scsi/qla2xxx/qla_def.h~qla2xxx-build-fix	2004-01-15 22:09:17.000000000 -0800
+++ 25-akpm/drivers/scsi/qla2xxx/qla_def.h	2004-01-15 22:10:28.000000000 -0800
@@ -1135,8 +1135,8 @@ typedef union {
 	uint16_t extended;
 	struct {
 		uint8_t reserved;
-		uint8_t standard;;
-	};
+		uint8_t standard;
+	} id;
 } target_id_t;
 
 #define SET_TARGET_ID(ha, to, from)			\
@@ -1144,7 +1144,7 @@ do {							\
 	if (HAS_EXTENDED_IDS(ha))			\
 		to.extended = cpu_to_le16(from);	\
 	else						\
-		to.standard = (uint8_t)from;		\
+		to.id.standard = (uint8_t)from;		\
 } while (0)
 
 /*

_


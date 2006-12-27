Return-Path: <linux-kernel-owner+w=401wt.eu-S933015AbWL0RLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015AbWL0RLX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932993AbWL0RK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:10:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41441 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932997AbWL0RKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:10:43 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Ang Way Chuang <wcang@nrg.cs.usm.my>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 10/28] V4L/DVB (4972): Dvb-core: fix bug in CRC-32 checking
	on 64-bit systems
Date: Wed, 27 Dec 2006 14:57:29 -0200
Message-id: <20061227165728.PS93298400010@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ang Way Chuang <wcang@nrg.cs.usm.my>

CRC-32 checking during ULE decapsulation always failed on x86_64 systems due
to the size of a variable used to store CRC. This bug was discovered on
Fedora Core 6 with kernel-2.6.18-1.2849. The i386 counterpart has no such
problem. This patch has been tested on 64-bit system as well as 32-bit system.

Signed-off-by: Ang Way Chuang <wcang@nrg.cs.usm.my>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-core/dvb_net.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/dvb-core/dvb_net.c b/drivers/media/dvb/dvb-core/dvb_net.c
index ebf4dc5..8138b37 100644
--- a/drivers/media/dvb/dvb-core/dvb_net.c
+++ b/drivers/media/dvb/dvb-core/dvb_net.c
@@ -605,7 +605,7 @@ #endif
 				{ &utype, sizeof utype },
 				{ priv->ule_skb->data, priv->ule_skb->len - 4 }
 			};
-			unsigned long ule_crc = ~0L, expected_crc;
+			u32 ule_crc = ~0L, expected_crc;
 			if (priv->ule_dbit) {
 				/* Set D-bit for CRC32 verification,
 				 * if it was set originally. */


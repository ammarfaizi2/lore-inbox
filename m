Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965271AbWCTPYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965271AbWCTPYE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbWCTPXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:23:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59874 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965284AbWCTPXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:23:10 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Marco Schluessler <marco@lordzodiac.de>,
       Oliver Endriss <o.endriss@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 131/141] V4L/DVB (3403): Workaround to fix initialization
	for Nexus CA
Date: Mon, 20 Mar 2006 12:08:58 -0300
Message-id: <20060320150858.PS873270000131@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Schluessler <marco@lordzodiac.de>
Date: 1140817980 -0300

Workaround for Nexus CA: Debi test fails unless first debi write is repeated.

Signed-off-by: Marco Schluessler <marco@lordzodiac.de>
Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/ttpci/av7110_hw.c b/drivers/media/dvb/ttpci/av7110_hw.c
diff --git a/drivers/media/dvb/ttpci/av7110_hw.c b/drivers/media/dvb/ttpci/av7110_hw.c
index 3c5366d..75736f2 100644
--- a/drivers/media/dvb/ttpci/av7110_hw.c
+++ b/drivers/media/dvb/ttpci/av7110_hw.c
@@ -245,6 +245,9 @@ int av7110_bootarm(struct av7110 *av7110
 
 	/* test DEBI */
 	iwdebi(av7110, DEBISWAP, DPRAM_BASE, 0x76543210, 4);
+	/* FIXME: Why does Nexus CA require 2x iwdebi for first init? */
+	iwdebi(av7110, DEBISWAP, DPRAM_BASE, 0x76543210, 4);
+
 	if ((ret=irdebi(av7110, DEBINOSWAP, DPRAM_BASE, 0, 4)) != 0x10325476) {
 		printk(KERN_ERR "dvb-ttpci: debi test in av7110_bootarm() failed: "
 		       "%08x != %08x (check your BIOS 'Plug&Play OS' settings)\n",


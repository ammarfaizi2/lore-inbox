Return-Path: <linux-kernel-owner+w=401wt.eu-S1751138AbXAFCcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbXAFCcn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbXAFCcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:32:41 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36816 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbXAFCcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:32:08 -0500
Message-Id: <20070106023619.196764000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:34 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jean Delvare <khali@linux-fr.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [patch 41/50] V4L: cx88: Fix leadtek_eeprom tagging
Content-Disposition: inline; filename=v4l-cx88-fix-leadtek_eeprom-tagging.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jean Delvare <khali@linux-fr.org>

reference to .init.text: from .text between 'cx88_card_setup'
(at offset 0x68c) and 'cx88_risc_field'
Caused by leadtek_eeprom() being declared __devinit and called from
a non-devinit context.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
(cherry picked from commit 69f7e75a9d45e5eaca16917a8d0dedf76149f13f)

 drivers/media/video/cx88/cx88-cards.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.1.orig/drivers/media/video/cx88/cx88-cards.c
+++ linux-2.6.19.1/drivers/media/video/cx88/cx88-cards.c
@@ -1610,7 +1610,7 @@ const unsigned int cx88_idcount = ARRAY_
 /* ----------------------------------------------------------------------- */
 /* some leadtek specific stuff                                             */
 
-static void __devinit leadtek_eeprom(struct cx88_core *core, u8 *eeprom_data)
+static void leadtek_eeprom(struct cx88_core *core, u8 *eeprom_data)
 {
 	/* This is just for the "Winfast 2000XP Expert" board ATM; I don't have data on
 	 * any others.

--

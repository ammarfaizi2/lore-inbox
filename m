Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSHFUwN>; Tue, 6 Aug 2002 16:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSHFUvR>; Tue, 6 Aug 2002 16:51:17 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:63714 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316135AbSHFUtv>;
	Tue, 6 Aug 2002 16:49:51 -0400
Date: Tue, 6 Aug 2002 13:53:28 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] : ir240_nsc_ob6100.diff
Message-ID: <20020806205328.GG11677@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir240_nsc_ob6100.diff :
---------------------
        <Following patch from Kevin Thayer>
	o [FEATURE] Handle what is probably a new variant of NSC chip


diff -u -p linux/drivers/net/irda/nsc-ircc.d5.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda/nsc-ircc.d5.c	Thu Mar 21 15:28:16 2002
+++ linux/drivers/net/irda/nsc-ircc.c	Thu Mar 21 15:39:22 2002
@@ -88,10 +88,14 @@ static int nsc_ircc_init_338(nsc_chip_t 
 
 /* These are the known NSC chips */
 static nsc_chip_t chips[] = {
+/*  Name, {cfg registers}, chip id index reg, chip id expected value, revision mask */
 	{ "PC87108", { 0x150, 0x398, 0xea }, 0x05, 0x10, 0xf0, 
 	  nsc_ircc_probe_108, nsc_ircc_init_108 },
 	{ "PC87338", { 0x398, 0x15c, 0x2e }, 0x08, 0xb0, 0xf8, 
 	  nsc_ircc_probe_338, nsc_ircc_init_338 },
+	/* Contributed by Kevin Thayer - OmniBook 6100 */
+	{ "PC87338?", { 0x2e, 0x15c, 0x398 }, 0x08, 0x00, 0xf8, 
+	  nsc_ircc_probe_338, nsc_ircc_init_338 },
 	{ NULL }
 };
 
@@ -697,6 +701,9 @@ static int nsc_ircc_setup(chipio_t *info
 	/* Read the Module ID */
 	switch_bank(iobase, BANK3);
 	version = inb(iobase+MID);
+
+	IRDA_DEBUG(2, __FUNCTION__  "() Driver %s Found chip version %02x\n",
+		   driver_name, version);
 
 	/* Should be 0x2? */
 	if (0x20 != (version & 0xf0)) {

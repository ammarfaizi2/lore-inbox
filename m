Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264661AbTFEMw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 08:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264662AbTFEMw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 08:52:58 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:54534 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S264661AbTFEMw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 08:52:57 -0400
Date: Thu, 5 Jun 2003 23:05:26 +1000
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix init of mp_bus_id_to_pci_bus
Message-ID: <20030605130526.GA15512@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes size argument in the initialisation of
mp_bus_id_to_pci_bus.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: arch/i386/kernel/mpparse.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/arch/i386/kernel/mpparse.c,v
retrieving revision 1.1.1.10
diff -u -r1.1.1.10 mpparse.c
--- arch/i386/kernel/mpparse.c	1 Jun 2003 03:06:21 -0000	1.1.1.10
+++ arch/i386/kernel/mpparse.c	4 Jun 2003 13:28:24 -0000
@@ -517,7 +517,7 @@
 	mp_bus_id_to_local = (int *)&bus_data[(max_mp_busses * sizeof(int)) * 2];
 	mp_bus_id_to_pci_bus = (int *)&bus_data[(max_mp_busses * sizeof(int)) * 3];
 	mp_irqs = (struct mpc_config_intsrc *)&bus_data[(max_mp_busses * sizeof(int)) * 4];
-	memset(mp_bus_id_to_pci_bus, -1, max_mp_busses);
+	memset(mp_bus_id_to_pci_bus, -1, max_mp_busses * sizeof(int));
 
 	/*
 	 *	Now process the configuration blocks.

--ZGiS0Q5IWpPtfppv--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSDJOrJ>; Wed, 10 Apr 2002 10:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312570AbSDJOrI>; Wed, 10 Apr 2002 10:47:08 -0400
Received: from CPE-144-132-248-138.nsw.bigpond.net.au ([144.132.248.138]:45184
	"EHLO orthos") by vger.kernel.org with ESMTP id <S312486AbSDJOrI>;
	Wed, 10 Apr 2002 10:47:08 -0400
Date: Thu, 11 Apr 2002 00:47:09 +1000
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI oops with 2.5.8-pre3 on asus dual athlon (A7M266-D)
Message-ID: <20020410144709.GA852@orthos.rcpt.to>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: dichro@orthos.rcpt.to (Mikolaj J. Habryn)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Null pointer dereference in some deep internal ACPI state thing.
Attached patch gets it past that point, but kernel then hangs after
probing disks (as did -pre2, and possibly earlier ones). Almost
certainly not the right fix :)

m.

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=acpi-diff

--- linux-2.5.8-pre3/drivers/acpi/executer/exfield.c.orig	Thu Apr 11 00:40:19 2002
+++ linux-2.5.8-pre3/drivers/acpi/executer/exfield.c	Thu Apr 11 00:36:52 2002
@@ -103,6 +103,10 @@
 	/* Handle both ACPI 1.0 and ACPI 2.0 Integer widths */
 
 	integer_size = sizeof (acpi_integer);
+	if (!walk_state || !walk_state->method_node) {
+		printk("ACPI argh!\n");
+		return_ACPI_STATUS(AE_ERROR);
+	}
 	if (walk_state->method_node->flags & ANOBJ_DATA_WIDTH_32) {
 		/*
 		 * We are running a method that exists in a 32-bit ACPI table.

--qMm9M+Fa2AknHoGS--

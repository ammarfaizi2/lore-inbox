Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUBFPBQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 10:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUBFPBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 10:01:16 -0500
Received: from q.bofh.de ([212.126.220.202]:20998 "EHLO q.bofh.de")
	by vger.kernel.org with ESMTP id S265494AbUBFPBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 10:01:15 -0500
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, perex@suse.cz
Subject: [patch] Fix for minor error in 2.4 /proc/isapnp output
Mail-Copies-To: nobody
From: Hilko Bengen <bengen@hilluzination.de>
Date: Fri, 06 Feb 2004 15:57:33 +0100
Message-ID: <87llngs1b6.fsf@hilluzination.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In isapnp_proc.c, the wrong registers from the PnP device are read to
determine the iomem area the device is configured to use. According to
the "Plug and Play ISA Specification Version 1.0a", only bits 23
through 8 of the start address can be retrieved from two one-byte
registers.

The attached patch makes isapnp_proc.c read the right registers.q
Please apply it to the 2.4 tree.

Greetings,
-Hilko

diff -uir orig/linux-2.4.24/drivers/pnp/isapnp_proc.c linux-2.4.24/drivers/pnp/isapnp_proc.c
--- orig/linux-2.4.24/drivers/pnp/isapnp_proc.c	2002-11-29 00:53:14.000000000 +0100
+++ linux-2.4.24/drivers/pnp/isapnp_proc.c	2004-02-06 14:56:45.000000000 +0100
@@ -649,7 +649,7 @@
 	if (next)
 		isapnp_printf(buffer, "\n");
 	for (i = next = 0; i < 4; i++) {
-		tmp = isapnp_read_dword(ISAPNP_CFG_MEM + (i << 3));
+		tmp = isapnp_read_word(ISAPNP_CFG_MEM + (i << 3)) << 8;
 		if (!tmp)
 			continue;
 		if (!next) {


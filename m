Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTFYCVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 22:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTFYCVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 22:21:21 -0400
Received: from smtp1.brturbo.com ([200.199.201.21]:48035 "EHLO
	smtp.brturbo.com") by vger.kernel.org with ESMTP id S262023AbTFYCVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 22:21:20 -0400
From: Marcelo Penna Guerra <eu@marcelopenna.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] nVidia nForce AGP fix
Date: Tue, 24 Jun 2003 19:03:14 -0300
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iqM++wNNPHmPK3s"
Message-Id: <200306241903.14271.eu@marcelopenna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_iqM++wNNPHmPK3s
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

nVidia nForce AGP is broken in 2.4.21-ac2. This patch fixed it for me.
I think 2.5.x needs a similar fix too.

Marcelo Penna Guerra

--Boundary-00=_iqM++wNNPHmPK3s
Content-Type: text/x-diff;
  charset="us-ascii";
  name="nvagp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nvagp.diff"

--- agpgart_be.c	2003-06-24 18:24:31.000000000 -0300
+++ agpgart_be.c.new	2003-06-24 18:30:53.000000000 -0300
@@ -4285,7 +4285,7 @@
 		mem->is_flushed = TRUE;
 	}
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
-		agp_bridge.gatt_table[nvidia_private.pg_offset + j] = mem->memory[i];
+		agp_bridge.gatt_table[nvidia_private.pg_offset + j] = agp_bridge.mask_memory(mem->memory[i], mem->type);
 	}
 
 	agp_bridge.tlb_flush(mem);

--Boundary-00=_iqM++wNNPHmPK3s--

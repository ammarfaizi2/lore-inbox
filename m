Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbVJEQ6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVJEQ6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVJEQ6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:58:41 -0400
Received: from magic.adaptec.com ([216.52.22.17]:41883 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030251AbVJEQ6k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:58:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.13.2 aacraid regression
Date: Wed, 5 Oct 2005 12:58:38 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F01B02355@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.13.2 aacraid regression
Thread-Index: AcXIZKFZsBTK1dnsSwKmNSJmN2l7mgAdkaMgADwwCIA=
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-scsi@vger.kernel.org>, "Juan D Ch" <jchimienti@most.com.ar>,
       "Mark Haverkamp" <markh@osdl.org>,
       "Martin Drab" <drab@kepler.fjfi.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juan was kind enough to linger on site, and work on a production
machine, to try the parameter to make the system stable. He discovered
that reducing the maximum transfer size issued to the adapter to 128KB
stabilized his system. This is related to an earlier change for the
2.6.13 tree resulting from Martin Drab's testing where the transfer size
was reduced from 4G to 256KB; we needed to go still further in scaling
back the request size.

Here is the patch that tames this regression.

Applies to the 2.6.13.2 tree.

Signed-off-by: Mark Salyzyn <aacraid@adaptec.com>

Index: linux-2.6.13.2/drivers/scsi/aacraid/aacraid.h
===================================================================
--- linux-2.6.13.2/drivers/scsi/aacraid/aacraid.h       2005-10-05
12:45:16 -0400
+++ linux-2.6.13.2-aacraid-fix/drivers/scsi/aacraid/aacraid.h
2005-09-16 21:02:12 -0400
@@ -15,7 +15,7 @@
 #define AAC_MAX_LUN            (8)

 #define AAC_MAX_HOSTPHYSMEMPAGES (0xfffff)
-#define AAC_MAX_32BIT_SGBCOUNT ((unsigned short)512)
+#define AAC_MAX_32BIT_SGBCOUNT ((unsigned short)256)

 /*
  * These macros convert from physical channels to virtual channels

Sincerely -- Mark Salyzyn

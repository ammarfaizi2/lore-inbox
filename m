Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264799AbUE0PXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264799AbUE0PXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264800AbUE0PXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:23:18 -0400
Received: from fmr12.intel.com ([134.134.136.15]:7627 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S264799AbUE0PXO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:23:14 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: idebus setup problem (2.6.7-rc1)
Date: Thu, 27 May 2004 23:21:52 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F842DB1E0@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: idebus setup problem (2.6.7-rc1)
Thread-Index: AcRD+JdnCNMTBV2QTACEOvVp7uR9qAABQbTg
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Auzanneau Gregory" <mls@reolight.net>
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 27 May 2004 15:21:53.0391 (UTC) FILETIME=[5704E7F0:01C443FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz [B.Zolnierkiewicz@elka.pw.edu.pl] wrote:
> 
> I remember seeing patch related to handling '=' in kernel
> params, maybe it's related (or maybe not).

Yes, this is caused by my kernel-parameter-parsing-fix.patch.

But I think below code in ide.c is a hack.
__setup("", ide_setup);

How about below change?

--- linux-2.6.7-rc1-mm1.orig/drivers/ide/ide.c      2004-05-27
23:07:59.405138992 +0800
+++ linux-2.6.7-rc1-mm1/drivers/ide/ide.c   2004-05-27
23:09:47.529701560 +0800
@@ -2459,7 +2459,8 @@ void cleanup_module (void)

 #else /* !MODULE */

-__setup("", ide_setup);
+__setup("hd", ide_setup);
+__setup("ide", ide_setup);

 module_init(ide_init);


-yi

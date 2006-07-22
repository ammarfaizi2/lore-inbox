Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWGVCWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWGVCWQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 22:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWGVCWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 22:22:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:16022 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750838AbWGVCWP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 22:22:15 -0400
X-IronPort-AV: i="4.07,170,1151910000"; 
   d="scan'208"; a="102021192:sNHT2266278665"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Date: Fri, 21 Jul 2006 22:22:10 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601091274@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Thread-Index: AcasMA0n0RkBna8CQ4uc3+uZCKjoAgBBJ+Pw
From: "Brown, Len" <len.brown@intel.com>
To: "Panagiotis Issaris" <takis@lumumba.uhasselt.be>,
       <linux-kernel@vger.kernel.org>
Cc: <chas@cmf.nrl.navy.mil>, <miquel@df.uba.ar>, <kkeil@suse.de>,
       <benh@kernel.crashing.org>, <video4linux-list@redhat.com>,
       <rmk+mmc@arm.linux.org.uk>, <Neela.Kolli@engenio.com>,
       <jgarzik@pobox.com>, <vandrove@vc.cvut.cz>, <adaplas@pol.net>,
       <thomas@winischhofer.net>, <weissg@vienna.at>, <philb@gnu.org>,
       <linux-pcmcia@lists.infradead.org>, <jkmaline@cc.hut.fi>,
       <paulus@samba.org>
X-OriginalArrivalTime: 22 Jul 2006 02:22:13.0272 (UTC) FILETIME=[A494B980:01C6AD35]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>diff --git a/drivers/acpi/hotkey.c b/drivers/acpi/hotkey.c
>index 32c9d88..037d022 100644
>--- a/drivers/acpi/hotkey.c
>+++ b/drivers/acpi/hotkey.c
>@@ -246,10 +246,8 @@ static char *format_result(union acpi_ob
> {
> 	char *buf = NULL;
> 
>-	buf = (char *)kmalloc(RESULT_STR_LEN, GFP_KERNEL);
>-	if (buf)
>-		memset(buf, 0, RESULT_STR_LEN);
>-	else
>+	buf = kzalloc(RESULT_STR_LEN, GFP_KERNEL);
>+	if (!buf)
> 		goto do_fail;

Go ahead and delete the '= NULL' while you're there.

Acked-by: Len Brown <len.brown@intel.com>

thanks,
-Len

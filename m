Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271266AbTG2Fc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 01:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271269AbTG2Fc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 01:32:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:64213 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271266AbTG2Fc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 01:32:56 -0400
Date: Mon, 28 Jul 2003 22:32:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: "S. Anderson" <sa@xmission.com>
Cc: sa@xmission.com, pavel@xal.co.uk, linux-kernel@vger.kernel.org,
       adaplas@pol.net
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
Message-Id: <20030728223229.528ddad1.akpm@osdl.org>
In-Reply-To: <20030728231812.A20738@xmission.xmission.com>
References: <20030728171806.GA1860@xal.co.uk>
	<20030728201954.A16103@xmission.xmission.com>
	<20030728202600.18338fa9.akpm@osdl.org>
	<20030728231812.A20738@xmission.xmission.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"S. Anderson" <sa@xmission.com> wrote:
>
> when that driver is 
>  "i810fb, i810_audio or intel-agp" (and i810fb, i810_audio or intel-agp
>  is allready loaded) the id_table is at an address that cant be handled, 
>  thus cauing the oops. I am having trouble figuring out why 
>  pci_drv->id_table isnt valid in this case.

Does this fix?  I'm not sure whether that "{ }" in there will generate
another table entry...


diff -puN drivers/char/agp/intel-agp.c~intel-agp-oops-fix drivers/char/agp/intel-agp.c
--- 25/drivers/char/agp/intel-agp.c~intel-agp-oops-fix	2003-07-28 22:30:30.000000000 -0700
+++ 25-akpm/drivers/char/agp/intel-agp.c	2003-07-28 22:30:53.000000000 -0700
@@ -1426,7 +1426,7 @@ static struct pci_device_id agp_intel_pc
 	.subvendor	= PCI_ANY_ID,
 	.subdevice	= PCI_ANY_ID,
 	},
-	{ }
+	{ 0, },
 };
 
 MODULE_DEVICE_TABLE(pci, agp_intel_pci_table);

_


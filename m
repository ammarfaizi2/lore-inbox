Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUK0ESl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUK0ESl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUK0EFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:05:25 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262295AbUKZTUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:20:50 -0500
Message-ID: <41A753A0.1070305@free.fr>
Date: Fri, 26 Nov 2004 17:02:40 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
Cc: Li Shaohua <shaohua.li@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr>  <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee>  <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee>  <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee>  <419F136B.8010308@free.fr> <Pine.SOC.4.61.0411211949260.23880@math.ut.ee>  <41A0DB78.2010807@free.fr> <Pine.SOC.4.61.0411212050490.11420@math.ut.ee>  <41A0F893.9020106@free.fr> <1101086961.2940.7.camel@sli10-desk.sh.intel.com> <Pine.SOC.4.61.0411221016270.16427@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0411221016270.16427@math.ut.ee>
Content-Type: multipart/mixed;
 boundary="------------080107020706010509070705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080107020706010509070705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Meelis Roos wrote:
>> Could you please attach the output of 'cat 00:0a/resources' (0a is the
>> device, right?). ACPI spec said set resource should be according to the
>> output of current resource. That is we should build a template according
>> to current resource (_CRS). If _CRS doesn't return a correct resource
>> templete, set resource will fail.
> 
> 
Hi,

could you try this patch with the previous one. (You must enable ACPI 
DEBUG in kernel config)

When you activate the device, it sould print usefull information.
Could attach the output, please.

Matthieu

--------------080107020706010509070705
Content-Type: text/x-patch;
 name="rs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rs.patch"

--- linux-2.6.9/drivers/pnp/pnpacpi/rsparser.c.old	2004-11-12 22:55:10.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/rsparser.c	2004-11-26 16:33:42.000000000 +0100
@@ -29,6 +29,18 @@
 #define valid_IRQ(i) (((i) != 0) && ((i) != 2))
 #endif
 
+static void debug_pnp(struct acpi_resource *res, int line) {
+	int tmp = acpi_dbg_level;
+	int tmp1 = acpi_dbg_layer;
+
+	acpi_dbg_level = 0x00010000;
+	acpi_dbg_layer = 0x00000100;
+	printk("******%d*******\n",line);
+	ACPI_DUMP_RESOURCE_LIST(res);
+	acpi_dbg_level = tmp;
+	acpi_dbg_layer = tmp1;
+}
+	
 /*
  * Allocated Resources
  */
@@ -152,6 +164,8 @@
 {
 	struct pnp_resource_table * res_table = (struct pnp_resource_table *)data;
 
+	debug_pnp(res,__LINE__);
+
 	switch (res->id) {
 	case ACPI_RSTYPE_IRQ:
 		if ((res->data.irq.number_of_interrupts > 0) &&
@@ -454,6 +469,8 @@
 	struct pnp_dev *dev = parse_data->dev;
 	struct pnp_option *option = parse_data->option;
 
+	debug_pnp(res,__LINE__);
+
 	switch (res->id) {
 		case ACPI_RSTYPE_IRQ:
 			pnpacpi_parse_irq_option(option, &res->data.irq);
@@ -816,5 +843,7 @@
 		resource ++;
 		i ++;
 	}
+	debug_pnp(res,__LINE__);
+
 	return 0;
 }

--------------080107020706010509070705--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWILHmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWILHmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWILHmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:42:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:18832 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964960AbWILHmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:42:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=KFBRDuJ5gE8mvEFaHnsLQEBzTU88gnXyhagRuZ4/2J7xRTF7/ntzSbOwN6dTYIb34wbazBSE3seS64WIg88FmemP7ZC7psdvMx027ghbiXdZwy5acGvm3DQwpsPNjMgiiQAUvaFurGrIaY+B38Lu2JPRn+TF83pj2wvKaSlhJt4=
Message-ID: <450664C7.3000105@gmail.com>
Date: Tue, 12 Sep 2006 09:41:59 +0200
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: "Nelson A. de Oliveira" <naoliv@gmail.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: PROBLEM: (libata) cdrom drive not detected in -mm series
References: <9bfa9ae0609111802o9131e8bg6c5d394ad87b16ea@mail.gmail.com>
In-Reply-To: <9bfa9ae0609111802o9131e8bg6c5d394ad87b16ea@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------000009060807020903060601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000009060807020903060601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nelson A. de Oliveira wrote:
> Hi!
> 
> My USB CD-ROM drive (that is detected as a SCSI drive) is not being
> detected on the -mm series of the Kernel.

s/USB/SATA/, I presume.

[--snip--]
-ata2.00: ATAPI, max UDMA/33
-ata2.00: configured for UDMA/33
-  Vendor: HL-DT-ST  Model: CDRW/DVD GCC4244  Rev: B101
-  Type:   CD-ROM                             ANSI SCSI revision: 05

Argh... yet another PCS problem.  With whole -mm applied, does adding 
kernel parameter 'ata_piix.force_pcs=1' make any difference?

Please provide the following info.

* the result of 'lspci -nvvv'

* dmesg output with the attached patch applied (on top of -mm).

Thanks.

-- 
tejun

--------------000009060807020903060601
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 22b2dba..53a19fd 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -560,7 +560,7 @@ static unsigned int piix_sata_present_ma
 	u16 pcs;
 
 	pci_read_config_word(pdev, ICH5_PCS, &pcs);
-	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
+	printk(KERN_INFO "ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
 
 	for (i = 0; i < 2; i++) {
 		port = map[base + i];
@@ -571,7 +571,7 @@ static unsigned int piix_sata_present_ma
 			present_mask |= 1 << i;
 	}
 
-	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
+	printk(KERN_INFO "ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
 		ap->id, pcs, present_mask);
 
 	return present_mask;

--------------000009060807020903060601--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWJTDQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWJTDQK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWJTDQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:16:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:10963 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751618AbWJTDQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:16:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=VfBh9dJzUlhh18gNdYCBtS4335Or9PafWlKtckj10/tWVW/IQWXEfU0AQsLkXESsj/2z0wa7Aij62Vd1EjjyRRSOHvBLa/BBqaYrSZSwQJxYtmqbLv+TRGAg+vGDwnGt2tD9gm5FGg/mZLBRFHj4f4PmHOXk4ziQuEr47zAqpok=
Message-ID: <45383F6F.6090102@gmail.com>
Date: Fri, 20 Oct 2006 12:15:59 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: "Berck E. Nash" <flyboy@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2 AHCI lengthy pause on detection
References: <453663DB.5060908@gmail.com>
In-Reply-To: <453663DB.5060908@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------050009050003050106060003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050009050003050106060003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Berck E. Nash wrote:
> AHCI pauses heartily on during detection boot, but eventually proceeds. 
>  This problem currently exists with 2.6.19-rc2-mm1, but did not exist in 
> 2.6.17.3.  I realize that's a huge gap, and if you'd like me to narrow 
> it down, I'll be glad to try.

Can you try the attached patch?  And please post the result of hdparm -I 
/dev/sdX.

-- 
tejun

--------------050009050003050106060003
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2592912..8215139 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -278,8 +278,7 @@ static const struct ata_port_info ahci_p
 	{
 		.sht		= &ahci_sht,
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_SKIP_D2H_BSY,
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,

--------------050009050003050106060003--

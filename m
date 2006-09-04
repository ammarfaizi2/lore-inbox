Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWIDCmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWIDCmu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 22:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWIDCmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 22:42:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:48598 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751313AbWIDCmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 22:42:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=iIDQx8s/oWkCI6hAqYQGU2gtHlsC9QqJaLY1souaBMW/EPjOm7YAzbMGg3/f5ON0ZzDYghLbLeTGsEaXMhvbyNt6eF51JIU36w9IriyUDWe8rl83fpjydC57RocGfC9ZQmPCXP0dpDLU5qIhOvp7ZOmgYTyiPUFHH2t1TdJ9mus=
Message-ID: <44FB929B.7080405@gmail.com>
Date: Mon, 04 Sep 2006 04:42:35 +0200
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: jamagallon@ono.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Lost DVD-RW [Was Re: 2.6.18-rc5-mm1]
References: <20060901015818.42767813.akpm@osdl.org>	<20060904013443.797ba40b@werewolf.auna.net> <20060903181226.58f9ea80.akpm@osdl.org>
In-Reply-To: <20060903181226.58f9ea80.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030908000506060006030804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030908000506060006030804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton wrote:
> On Mon, 4 Sep 2006 01:34:43 +0200
> "J.A. Magallón" <jamagallon@ono.com> wrote:
> 
>> On Fri, 1 Sep 2006 01:58:18 -0700, Andrew Morton <akpm@osdl.org> wrote:
>>
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
>>>
>> Err, my burner got lost this summer ;).
>> This is really not a bug of _this_ kernel, because I noticed it dissapeared
>> with the previous release also, just before going on vacation... But as it
>> did not come back with this relase, I report it here.
>>
>> Last kernel that I have tried that worked was 2.6.18-rc2-mm1. With this
>> relase, it is gone still. dmesg for both kernels is below.
>> The only thing I hace noticed is the different IRQ assignment between
>> them.
>>
>> Any ideas ? TIA.
>>
>> dmesg for rc2-mm1:
>> scsi0 : ata_piix
>> ata1.00: ATAPI, max UDMA/33
>> ata1.01: ATAPI, max MWDMA0, CDB intr
>> ata1.00: configured for UDMA/33
>> ata1.01: configured for PIO3
>>   Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111
>>   Type:   CD-ROM                             ANSI SCSI revision: 05
>>   Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G
>>   Type:   Direct-Access                      ANSI SCSI revision: 05
>>
>> dmesg for rc5-mm1:
>> ata1.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)

Hmmm... Strange.

The related code hasn't changed much between rc2-mm1 and rc5-mm1.  We're 
talking about 2.6.18-rc2-mm1 and 2.6.18-rc5-mm1, right?

Can you try the attached patch and report what the kernel says?


-- 
tejun

--------------030908000506060006030804
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1c93154..af2fc6f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1276,6 +1276,8 @@ int ata_dev_read_id(struct ata_device *d
 	swap_buf_le16(id, ATA_ID_WORDS);
 
 	/* sanity check */
+	ata_dev_printk(dev, KERN_INFO, "XXX class=%d is_ata=%d is_cfa=%d\n",
+		       class, ata_id_is_ata(id), ata_id_is_cfa(id));
 	if ((class == ATA_DEV_ATA) != (ata_id_is_ata(id) | ata_id_is_cfa(id))) {
 		rc = -EINVAL;
 		reason = "device reports illegal type";

--------------030908000506060006030804--

-- 
VGER BF report: H 6.08475e-08

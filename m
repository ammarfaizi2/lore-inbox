Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVBXQDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVBXQDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVBXQBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 11:01:34 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:25281 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262393AbVBXP7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:59:33 -0500
Message-ID: <421DF9DE.2080407@mesatop.com>
Date: Thu, 24 Feb 2005 08:59:26 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Steven Cole <elenstev@mesatop.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
References: <20050223014233.6710fd73.akpm@osdl.org> <421CB161.7060900@mesatop.com> <20050223121759.5cb270ee.akpm@osdl.org> <421CFF5E.4030402@mesatop.com> <20050224004444.GI3163@waste.org>
In-Reply-To: <20050224004444.GI3163@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Wed, Feb 23, 2005 at 03:10:38PM -0700, Steven Cole wrote:
> 
>>Andrew Morton wrote:
>>
>>>Steven Cole <elenstev@mesatop.com> wrote:
>>
>>>>I am having trouble getting recent -mm kernels to boot on my test box.
>>>>For 2.6.11-rc3-mm2 and 2.6.11-rc4-mm1 I get the following:
>>>>
>>>>VFS: Cannot open root device "301" or unknown-block(3,1)
>>>>Please append a correct "root=" boot option
>>>>Kernel panic - not syncing: VFS: Unable to mount root fs on 
>>>>unknown-block(3,1)
>>>>
>>
>>[snipped]
>>
>>>Please set CONFIG_BASE_FULL=y.  Check that this causes CONFIG_BASE_SMALL=0,
>>>then retest.
>>
>>Yes, that worked.  2.6.11-rc4-mm1 now boots OK, but hdb1 seems to be 
>>missing.
> 
> 
> Can you retry CONFIG_BASE_FULL=n with Andrew's patch?
> 
> You may need to boot back into a sane kernel for LILO to operate properly.
> 
> --- 25/drivers/ide/ide-probe.c~ide_init_disk-fix	Wed Feb 23 16:24:44 2005
> +++ 25-akpm/drivers/ide/ide-probe.c	Wed Feb 23 16:24:55 2005
> @@ -1269,7 +1269,7 @@ EXPORT_SYMBOL_GPL(ide_unregister_region)
>  void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif = drive->hwif;
> -	unsigned int unit = drive->select.all & (1 << 4);
> +	unsigned int unit = (drive->select.all >> 4) & 1;
>  
>  	disk->major = hwif->major;
>  	disk->first_minor = unit << PARTN_BITS;
> 

Andrew's above patch fixes the hdb->hdq insanity, but I still need
CONFIG_BASE_FULL=y.  I tried unsetting CONFIG_BASE_FULL, and again
got the "VFS: Cannot open root device" message (with akpm's patch).

Steven

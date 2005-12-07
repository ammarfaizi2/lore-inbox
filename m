Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVLGKV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVLGKV3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVLGKV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:21:29 -0500
Received: from proxy.seznam.cz ([212.80.76.5]:57860 "EHLO proxy.seznam.cz")
	by vger.kernel.org with ESMTP id S1750779AbVLGKV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:21:28 -0500
Message-ID: <4396B795.1000108@feix.cz>
Date: Wed, 07 Dec 2005 11:21:09 +0100
From: Michal Feix <michal@feix.cz>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [SCSI] SCSI block devices larger then 2TB
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

Current aic79xxx driver doesn't see SCSI devices larger, then 2TB. It 
fails with READ CAPACITY(16) command. As far as I can understand, we 
already have LBD support in kernel for some time now. So it's only the 
drivers, that need to be fixed? LSI driver is the only one I found 
working with devices over 2TB; I couldn't test any other driver, as I 
don't have the hardware. Is it really so bad, that only LSI chipset and 
maybe few others are capable of seeng such devices?

My kernel output with aic79xxx follows:

scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
heracles kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
heracles kernel:         aic7902: Ultra320 Wide Channel B, SCSI Id=7, 
PCI-X 101-133Mhz, 512 SCBs
scsi1:A:0:0: Tagged Queuing enabled.  Depth 64
  target1:0:0: Beginning Domain Validation
  target1:0:0: wide asynchronous.
  target1:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 127)
  target1:0:0: Ending Domain Validation
sde : very big device. try to use READ CAPACITY(16).
sde : READ CAPACITY(16) failed.
sde : status=0, message=00, host=5, driver=00
sde : use 0xffffffff as device size
SCSI device sde: 4294967296 512-byte hdwr sectors (2199023 MB)
SCSI device sde: drive cache: write back
sde : very big device. try to use READ CAPACITY(16).
sde : READ CAPACITY(16) failed.
sde : status=0, message=00, host=5, driver=00
sde : use 0xffffffff as device size
SCSI device sde: 4294967296 512-byte hdwr sectors (2199023 MB)
SCSI device sde: drive cache: write back
  sde: unknown partition table
Attached scsi disk sde at scsi1, channel 0, id 0, lun 0

-- 
Michal Feix

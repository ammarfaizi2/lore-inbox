Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVD1UCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVD1UCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVD1UCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:02:33 -0400
Received: from mail4.utc.com ([192.249.46.193]:36497 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S262256AbVD1UCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:02:13 -0400
Message-ID: <4271413F.70809@cybsft.com>
Date: Thu, 28 Apr 2005 15:02:07 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: 2.6.12-rc3 won't boot from aic7899
References: <4269C60C.3070700@cybsft.com> <1114716611.5022.6.camel@mulgrave>
In-Reply-To: <1114716611.5022.6.camel@mulgrave>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030005080306070106070309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030005080306070106070309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

James Bottomley wrote:
> On Fri, 2005-04-22 at 22:50 -0500, K.R. Foley wrote:
> 
>>scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>>        <Adaptec aic7899 Ultra160 SCSI adapter>
>>        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
>>
>>  Vendor: SEAGATE   Model: SX118273LC        Rev: 6679
>>  Type:   Direct-Access                      ANSI SCSI revision: 02
>>scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
>> target1:0:0: Beginning Domain Validation
>>(scsi1:A:0): 6.600MB/s transfers (16bit)
>>(scsi1:A:0:0): parity error detected in Data-in phase. SEQADDR(0x6b)
>>SCSIRATE(0x80)
> 

Hi James,

> 
> 
> I assume it just locks up after this?

Yes. You assume correctly.

> 
> It looks like the parity error isn't propagating upwards like it should.
> What did a 2.6.11 boot sequence show for this (i.e. did the internal
> aic7xxx DV configure the device narrow)?

I am attaching the relevant part of the successful boot log from 
2.6.12-rc2. I don't have a 2.6.11 boot log handy. I can boot it when I 
get home if it will help. I don't know if it is worth mentioning or not, 
but I have had to compile in the SCSI drivers since 2.6.12-rc1. Don't 
know if it's related to this or not.

One other note: I spent enough time tracing this to find that the 
message "target1:0:0: Beginning Domain Validation" seems to be generated 
by code that is in aic79xx_osm. Is this common code or should this code 
not be getting executed for aic7899 cards?

> 
> I suspect the attached patch might fix this in the core driver, if you
> could try it out.

I'll be happy to try this when I get home.

> 
> Thanks,
> 
> James
> 
<snip>

thanks,

-- 
    kr

--------------030005080306070106070309
Content-Type: text/plain;
 name="scsi-boot.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi-boot.log"

Apr 24 23:23:30 porky kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Apr 24 23:23:30 porky kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
Apr 24 23:23:30 porky kernel:         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Apr 24 23:23:30 porky kernel: 
Apr 24 23:23:30 porky kernel: (scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Apr 24 23:23:30 porky kernel:   Vendor: QUANTUM   Model: ATLAS10K2-TY092L  Rev: DA40
Apr 24 23:23:30 porky kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Apr 24 23:23:30 porky kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Apr 24 23:23:30 porky kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Apr 24 23:23:30 porky kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
Apr 24 23:23:30 porky kernel:         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
Apr 24 23:23:30 porky kernel: 
Apr 24 23:23:30 porky kernel: (scsi1:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
Apr 24 23:23:31 porky kernel:   Vendor: SEAGATE   Model: SX118273LC        Rev: 6679
Apr 24 23:23:31 porky netfs: Mounting other filesystems:  succeeded
Apr 24 23:23:31 porky kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Apr 24 23:23:31 porky kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
Apr 24 23:23:31 porky kernel: SCSI device sda: 17783239 512-byte hdwr sectors (9105 MB)
Apr 24 23:23:31 porky kernel: SCSI device sda: drive cache: write back
Apr 24 23:23:31 porky kernel: SCSI device sda: 17783239 512-byte hdwr sectors (9105 MB)
Apr 24 23:23:31 porky kernel: SCSI device sda: drive cache: write back
Apr 24 23:23:31 porky kernel:  sda: sda1 sda2 sda3
Apr 24 23:23:31 porky kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Apr 24 23:23:31 porky kernel: SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
Apr 24 23:23:31 porky kernel: SCSI device sdb: drive cache: write through
Apr 24 23:23:31 porky kernel: SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
Apr 24 18:22:56 porky rc.sysinit: -e 
Apr 24 23:23:31 porky kernel: SCSI device sdb: drive cache: write through
Apr 24 18:22:59 porky udevsend[1235]: starting udevd daemon 
Apr 24 23:23:31 porky kernel:  sdb: sdb1
Apr 24 18:22:59 porky scsi.agent[1247]: disk at /devices/pci0000:00/0000:00:1e.0/0000:04:05.0/host0/target0:0:0/0:0:0:0 
Apr 24 23:23:31 porky kernel: Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Apr 24 18:22:59 porky scsi.agent[1272]: disk at /devices/pci0000:00/0000:00:1e.0/0000:04:05.1/host1/target1:0:0/1:0:0:0 
Apr 24 23:23:31 porky kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Apr 24 18:22:59 porky udevsend[1288]: starting udevd daemon 
Apr 24 23:23:31 porky kernel: Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Apr 24 18:23:12 porky start_udev: Starting udev:  succeeded 

--------------030005080306070106070309--

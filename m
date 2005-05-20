Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVETDG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVETDG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 23:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVETDG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 23:06:26 -0400
Received: from relay00.pair.com ([209.68.1.20]:3599 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261159AbVETDGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 23:06:10 -0400
X-pair-Authenticated: 24.241.238.70
Message-ID: <428D5421.1080406@cybsft.com>
Date: Thu, 19 May 2005 22:06:09 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>, gregoire.favre@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
References: <20050516085832.GA9558@gmail.com>	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>	 <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com>	 <1116354894.4989.42.camel@mulgrave> <428C030E.8030102@cybsft.com>	 <1116476630.5867.2.camel@mulgrave>  <20050519095143.GA3972@in.ibm.com>	 <1116546970.5037.137.camel@mulgrave>  <428D37CF.5070903@cybsft.com>	 <1116551853.5037.145.camel@mulgrave>  <428D3E1C.2020802@cybsft.com>	 <1116553229.5037.155.camel@mulgrave>  <428D4371.6020809@cybsft.com> <1116556213.5037.161.camel@mulgrave>
In-Reply-To: <1116556213.5037.161.camel@mulgrave>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Thu, 2005-05-19 at 20:54 -0500, K.R. Foley wrote:
> 
>>the dt setting is 0. can't set it to 1, at least not so that you can see
>>it stay that way. tried setting period to 12.5, stays at 25. min_period
>>is set to 12.5 but doesn't seem to matter. what's next :)
> 
> 
> Well, I think it's my fault.  I naively assumed the aic7xxx core setting
> code would do the right thing with coupled parameters, which, as I read
> through it, apparently it doesn't do.
> 
> My excuse is that I can't test any of this because my fastest aic7xxx
> card is only a U2 ...
> 
> Could you try this, I think it does the correct thing with the coupled
> parameters.
> 
> Thanks,
> 
> James
> 

James,

Looks like a winner this time. If there is something else I can test,
just let me know.


May 19 21:46:43 porky kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.36
May 19 21:46:43 porky kernel:         <Adaptec aic7899 Ultra160 SCSI
adapter>
May 19 21:46:43 porky kernel:         aic7899: Ultra160 Wide Channel A,
SCSI Id=7, 32/253 SCBs
May 19 21:46:43 porky kernel:
May 19 21:46:43 porky kernel:   Vendor: QUANTUM   Model:
ATLAS10K2-TY092L  Rev: DA40
May 19 21:46:43 porky kernel:   Type:   Direct-Access
   ANSI SCSI revision: 03
May 19 21:46:43 porky kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
May 19 21:46:43 porky kernel:  target0:0:0: Beginning Domain Validation
May 19 21:46:43 porky kernel: WIDTH IS 1
May 19 21:46:43 porky kernel: (scsi0:A:0): 6.600MB/s transfers (16bit)
May 19 21:46:43 porky kernel: (scsi0:A:0): 160.000MB/s transfers
(80.000MHz DT, offset 127, 16bit)
May 19 21:46:43 porky kernel:  target0:0:0: Ending Domain Validation
May 19 21:46:43 porky kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.36
May 19 21:46:43 porky kernel:         <Adaptec aic7899 Ultra160 SCSI
adapter>
May 19 21:46:43 porky kernel:         aic7899: Ultra160 Wide Channel B,
SCSI Id=7, 32/253 SCBs
May 19 21:46:43 porky kernel:
May 19 21:46:43 porky kernel:   Vendor: SEAGATE   Model: SX118273LC
   Rev: 6679
May 19 21:46:43 porky kernel:   Type:   Direct-Access
   ANSI SCSI revision: 02
May 19 21:46:43 porky kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
May 19 21:46:43 porky kernel:  target1:0:0: Beginning Domain Validation
May 19 21:46:43 porky kernel:  target1:0:0: Domain Validation skipping
write tests
May 19 21:46:44 porky kernel: (scsi1:A:0): 20.000MB/s transfers
(20.000MHz, offset 15)
May 19 21:46:44 porky kernel:  target1:0:0: Ending Domain Validation
May 19 21:46:44 porky kernel: SCSI device sda: 17783239 512-byte hdwr
sectors (9105 MB)
May 19 21:46:44 porky kernel: SCSI device sda: drive cache: write back
May 19 21:46:44 porky kernel: SCSI device sda: 17783239 512-byte hdwr
sectors (9105 MB)
May 19 21:46:44 porky kernel: SCSI device sda: drive cache: write back
May 19 21:46:44 porky kernel:  sda: sda1 sda2 sda3
May 19 21:46:44 porky kernel: Attached scsi disk sda at scsi0, channel
0, id 0, lun 0
May 19 21:46:44 porky kernel: SCSI device sdb: 35566480 512-byte hdwr
sectors (18210 MB)
May 19 21:46:44 porky kernel: SCSI device sdb: drive cache: write through
May 19 21:46:44 porky kernel: SCSI device sdb: 35566480 512-byte hdwr
sectors (18210 MB)
May 19 21:46:44 porky kernel: SCSI device sdb: drive cache: write through
May 19 21:46:44 porky kernel:  sdb: sdb1
May 19 16:46:23 porky rc.sysinit: -e
May 19 21:46:44 porky kernel: Attached scsi disk sdb at scsi1, channel
0, id 0, lun 0
May 19 16:46:25 porky udevsend[1281]: starting udevd daemon
May 19 21:46:44 porky kernel: Attached scsi generic sg0 at scsi0,
channel 0, id 0, lun 0,  type 0
May 19 16:46:25 porky scsi.agent[1293]: disk at
/devices/pci0000:00/0000:00:1e.0/0000:04:05.0/host0/target0:0:0/0:0:0:0
May 19 21:46:44 porky kernel: Attached scsi generic sg1 at scsi1,
channel 0, id 0, lun 0,  type 0
May 19 16:46:25 porky scsi.agent[1318]: disk at
/devices/pci0000:00/0000:00:1e.0/0000:04:05.1/host1/target1:0:0/1:0:0:0


-- 
   kr

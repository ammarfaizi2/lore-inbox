Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVFNJ2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFNJ2V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 05:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVFNJ2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 05:28:21 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:53144 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261153AbVFNJ2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 05:28:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=IPRom35b/5eMV1rkIty5ws7opgexU8F4438WXWESUgeqFQemkB5TwJ+vfbUO1CyR7r/D+3D9nqQG+7GanFfVr56qiqa5e1geQ1kCqpxSDn93lpGRHeXsWW7X3IC7A0APqGsB3Qu/dmdnfG8ZCn2uD5vlt6j4mPngxmuiPDbKk6g=
Date: Tue, 14 Jun 2005 11:28:07 +0200
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ? (fixed in 2.6.12-rc6 with patches)
Message-ID: <20050614092807.GA8641@gmail.com>
References: <20050613145000.GA12057@gmail.com> <1118674783.5079.9.camel@mulgrave> <20050613183719.GA8653@gmail.com> <1118695847.5079.41.camel@mulgrave> <20050613213307.GA8534@gmail.com> <1118699191.5079.49.camel@mulgrave> <20050613215923.GA8629@gmail.com> <1118700284.5079.52.camel@mulgrave> <20050613222527.GB8629@gmail.com> <1118715622.5079.88.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118715622.5079.88.camel@mulgrave>
User-Agent: Mutt/1.5.6i
From: Gregoire Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 09:20:22PM -0500, James Bottomley wrote:

> Actually, I think the problem is that the DVD-Rom thinks it can run at
> 20 but actually can't

You are almost certainly right : setting the speed in BIOS back to 20
and I can't boot, but I can with 16 :-)

> Well ... look at it this way ... if no-one finds anything wrong with the
> patches, they'll be going straight into the kernel tree after 2.6.12, so
> I trust them as much as that ...

I will test it for a few days like right now, and I have now set all
speed back to full (except for the DVD) :

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

 target0:0:0: SC IS ffff81003fcaeac0
 target0:0:0: ULTRA2, flags 0xc33a
 target0:0:0: scsirate IS 0x2, min_period is 9, flags 0xc33a
  Vendor: IBM       Model: DDRS-39130D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
 target0:0:0: asynchronous.
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous.
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
 target0:0:0: Ending Domain Validation
...
 target0:0:15: SC IS ffff81003fcaeac0
 target0:0:15: ULTRA2, flags 0xc13a
 target0:0:15: scsirate IS 0x2, min_period is 9, flags 0xc13a
  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:15: asynchronous.
scsi0:A:15:0: Tagged Queuing enabled.  Depth 253
 target0:0:15: Beginning Domain Validation
 target0:0:15: wide asynchronous.
 target0:0:15: FAST-80 WIDE SCSI 160.0 MB/s ST (12.5 ns, offset 63)
 target0:0:15: Ending Domain Validation
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

 target1:0:0: SC IS ffff81003fcae980
 target1:0:0: scsirate IS 0x0, min_period is 12, flags 0xc158
 target1:0:1: SC IS ffff81003fcae980
 target1:0:1: scsirate IS 0x10, min_period is 15, flags 0xc159
 target1:0:1: asynchronous.
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R08
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:1: Beginning Domain Validation
 target1:0:1: Domain Validation skipping write tests
 target1:0:1: FAST-20 SCSI 16.7 MB/s ST (60 ns, offset 15)
 target1:0:1: Ending Domain Validation
 target1:0:2: SC IS ffff81003fcae980
 target1:0:2: scsirate IS 0x0, min_period is 12, flags 0xc158
 target1:0:2: asynchronous.
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:2: Beginning Domain Validation
 target1:0:2: Domain Validation skipping write tests
 target1:0:2: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 8)
 target1:0:2: Ending Domain Validation
 target1:0:3: SC IS ffff81003fcae980
 target1:0:3: scsirate IS 0x0, min_period is 12, flags 0xc158
 target1:0:3: asynchronous.
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:3: Beginning Domain Validation
 target1:0:3: Domain Validation skipping write tests
 target1:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 8)
 target1:0:3: Ending Domain Validation

Thank you very much !!!
-- 
	Gr\'egoire Favre

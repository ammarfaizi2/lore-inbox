Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbTAOAJ5>; Tue, 14 Jan 2003 19:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTAOAJ5>; Tue, 14 Jan 2003 19:09:57 -0500
Received: from magic.adaptec.com ([208.236.45.80]:12230 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S265414AbTAOAJ4>; Tue, 14 Jan 2003 19:09:56 -0500
Date: Tue, 14 Jan 2003 17:18:01 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Michael Madore <mmadore@aslab.com>, linux-kernel@vger.kernel.org
Subject: Re: Adaptec 79xx > 1GB I/O errors
Message-ID: <741380000.1042589881@aslan.btc.adaptec.com>
In-Reply-To: <3E24A5EF.2060903@aslab.com>
References: <3E24A5EF.2060903@aslab.com>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been getting the following I/O errors while stress testing a
> system with the latest Adaptec 79xx driver (1.3.0BETA2):
> 
> Jan 14 09:29:13 asl200 kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
> Jan 14 09:29:13 asl200 kernel: Info fld=0x86c552, Deferred sd08:02: sense key Hardware Error
> Jan 14 09:29:13 asl200 kernel: Additional sense indicates Internal target failure
> Jan 14 09:29:13 asl200 kernel:  I/O error: dev 08:02, sector 487312
> 
> Jan 14 10:36:37 asl200 kernel: (scsi0:A:0:0): Locking max tag count at 64
> 
> This is with kernel 2.4.19 + 2.4.19rc5aa1.  I have tested with several
> different Ultra 320 drives, with the same result.

Different U320 drives of the same make/model, or different makes and models?
The driver cannot "fake" a device returning an internal target failure
error.  I have only seen this on certain U320 Seagate drives and my
understanding is that it is a drive firmware problem exposed under high
transaction loads.

The locking max tag count diagnostic is normal.  It means that the
driver has determined the maximum queue depth of your disk.

> If I remove memory from the machine so that it only has 1GB, then
> everything is solid as a rock.

I bet there is less I/O going to the drives too.

> If I plug a zero channel raid controller into the same system (dpt_i2o),
> then I don't get any I/O error regardless of the amount of RAM.

The RAID controller will eat these messages.  Remeber that it only
*emulates* a SCSI controller.  It doesn't always act like one.

> Any thoughts?

Beat up on your driver vendor?

--
Justin


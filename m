Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135736AbRDXUTR>; Tue, 24 Apr 2001 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135737AbRDXUTH>; Tue, 24 Apr 2001 16:19:07 -0400
Received: from front7.grolier.fr ([194.158.96.57]:11660 "EHLO
	front7.grolier.fr") by vger.kernel.org with ESMTP
	id <S135736AbRDXUSy> convert rfc822-to-8bit; Tue, 24 Apr 2001 16:18:54 -0400
Date: Tue, 24 Apr 2001 19:07:30 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: "Hamilton, Eamonn" <EAMONN.HAMILTON@saic.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: sym53c875 error
In-Reply-To: <A83EBF650A2CD51189CA00508B444F7F1663B3@abz-irg-exs01.uk.saic.com>
Message-ID: <Pine.LNX.4.10.10104241846440.1580-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, Hamilton, Eamonn wrote:

> Hi Folks.
> 
> Under all of the kernels I have access to try ( 2.2.19, 2.4.X & 2.4.X-ac* ),
> when I try and write an image in XA2 format to my SCSI writer ( Yamaha
> CDR-400t ), I get a DMA overrun. When I try with a kernel patched with the
> beta symbios driver ( 2.1.9 ), it works just fine.

Interesting.

Note that sym-2.1.9 status is probably far better than beta. I just
haven't information enough to know how reliable this driver version
actually is. FYI, I use sym-2.1.x under Linux and FreeBSD since several
months. The NetBSD port is still work in progress, but the driver works
just fine for me under this O/S too.

> This is on a Debian woody system, using cdrecord 1.10 ( also 1.9 and 1.8
> with the same symptoms ) attached to a Tekram DC390F.
> 
> Transcript as follows :
> 
> cdrecord dev=0,3,0 -dummy -xa2 firmware.iso
> 
> Cdrecord 1.10a18 (i686-pc-linux-gnu) Copyright (C) 1995-2001 Jörg Schilling
> scsidev: '0,3,0'
> scsibus: 0 target: 3 lun: 0
> Linux sg driver version: 3.1.17
> Using libscg version 'schily-0.5'
> Device type    : Removable CD-ROM
> Version        : 2
> Response Format: 2
> Capabilities   :
> Vendor_info    : 'YAMAHA  '
> Identifikation : 'CDR400t         '
> Revision       : '1.0q'
> Device seems to be: Yamaha CDR-400.
> Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
> Driver flags   : SWABAUDIO
> Starting to write CD/DVD at speed 1 in dummy mode for single session.
> Last chance to quit, starting dummy write in 1 seconds.
> cdrecord: Input/output error. write_g1: scsi sendcmd: retryable error
> CDB:  2A 00 00 00 01 C2 00 00 1F 00
> status: 0x0 (GOOD STATUS)
> DMA overrun, resid: -248

Would be interesting to know how cdrecord calculates the residual. It
should probably use the return value from read()/write(). Does it ?

> cmd finished after 0.579s timeout 40s
> write track data: error after 0 bytes
> Sense Bytes: 70 00 00 00 00 00 00 0A 00 00 00 00 00 00 00 00 00 00
> 
> 
> And while that lot happens, I get
> 
> sym53c875-0-<3,*>: target did not report SYNC.

This message is not normal given the device that for sure supports 
synchronous data transfers. I will look into this problem, first.

> sym53c875-0-<3,*>: extraneous data discarded.
> sym53c875-0-<3,*>: COMMAND FAILED (89 0) @c12a3800.

This one could have been triggerred by previous errors ???.

> Standard burns work ok, it's just the xa2 stuff I have a problem with so
> far. I also tried using the old NCR driver with the same results.

If you mean that the ncr53c8xx driver gets the same error, then the cause
can be a either common bug in sym53c8xx and ncr53c8xx, or caused by a
difference between sym53c8xx/ncr53c8xx and sym-2.1.9.

The main difference that comes to mind is that sym-2 uses the new error
handling interface but sym53c8xx/ncr53c8xx use the old one. If it is the
cause, then the sg driver might get involved in the failure.

> Anybody got any ideas?

No more than the above for now.
Will let you know if I get better ones.

Regards,
  Gérard.


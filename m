Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSKZWrf>; Tue, 26 Nov 2002 17:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSKZWre>; Tue, 26 Nov 2002 17:47:34 -0500
Received: from fmr06.intel.com ([134.134.136.7]:40649 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261364AbSKZWrb>; Tue, 26 Nov 2002 17:47:31 -0500
Message-ID: <00ed01c2959e$cf4e45e0$94d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Patrick Mansfield" <patmans@us.ibm.com>,
       "Rusty Lynch" <rusty@stinkycat.com>
Cc: <groudier@free.fr>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
References: <200211250609.gAP69YS09374@stinkycat.com> <20021126142435.A1402@eng2.beaverton.ibm.com>
Subject: Re: [BUG][2.5.49 SCSI]Duplicate Proc Entries for SCSI
Date: Tue, 26 Nov 2002 14:54:43 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, forgot about that.

I only see this on my box at home (that I can't ssh to from work).  I just
now checked out my development box that has SCSI drives on it and it does
not exhibit the problem.

I will try what you suggested on the offending box after I go home tonight.

    -rustyl

----- Original Message -----
From: "Patrick Mansfield" <patmans@us.ibm.com>
To: "Rusty Lynch" <rusty@stinkycat.com>
Cc: <groudier@free.fr>; <linux-kernel@vger.kernel.org>;
<linux-scsi@vger.kernel.org>
Sent: Tuesday, November 26, 2002 2:24 PM
Subject: Re: [BUG][2.5.49 SCSI]Duplicate Proc Entries for SCSI


> Rusty -
>
> On Sun, Nov 24, 2002 at 10:09:34PM -0800, Rusty Lynch wrote:
> > On my 2.5.49 build, I am seeing duplicate entries in /proc/scsi/scsi.
> > On this system both scsi devices are both emulated (one is an Sony
> > IDE ReWritable CD drive and the other is PNY USB flash card reader using
> > the mass-storage driver.)
> >
> > Before plugging in the flash card reader, /proc/scsi/scsi looks like:
> > Attached devices:
> > Host: scsi0 Channel: 00 Id: 00 Lun: 00
> >   Vendor: SONY     Model: CD-RW CRX1611    Rev: TYS3
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> > Host: scsi0 Channel: 00 Id: 00 Lun: 01
> >   Vendor: SONY     Model: CD-RW CRX1611    Rev: TYS3
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> >
> > and after plugging in the flash card reader, /proc/scsi/scsi looks like:
> > Attached devices:
> > Host: scsi0 Channel: 00 Id: 00 Lun: 00
> >   Vendor: SONY     Model: CD-RW CRX1611    Rev: TYS3
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> > Host: scsi0 Channel: 00 Id: 00 Lun: 01
> >   Vendor: SONY     Model: CD-RW CRX1611    Rev: TYS3
> >   Type:   CD-ROM                           ANSI SCSI revision: 02
> > Host: scsi1 Channel: 00 Id: 00 Lun: 00
> >   Vendor: Datafab  Model: USB to CF + SM C Rev: 0017
> >   Type:   Direct-Access                    ANSI SCSI revision: 02
> > Host: scsi1 Channel: 00 Id: 00 Lun: 01
> >   Vendor: Datafab  Model: USB to CF + SM C Rev: 0017
> >   Type:   Direct-Access                    ANSI SCSI revision: 02
>
> Did you figure out anything? Was there anything of interest in your dmesg?
>
> I tried out 2.5.49, and all scsi devices showed up just once, both for
> the aic driver built into the kernel, and for qla driver built as a
> module, with SCSI revision 2 and 3 devices attached to the qla.
>
> Maybe it is specific to ide-scsi or the usb-scsi pseudo adapter drivers.
>
> Try turning on scsi scan logging before inserting the flash card via:
>
> echo scsi log scan 4  >/proc/scsi/scsi
>
> And send the output.
>
> My single lun scsi 2 disks display the following, showing that
> lun 1 is (correctly) not configured off of id 1 and id 2:
>
> [ junk deleted ]
> scsi scan: INQUIRY to host 2 channel 0 id 1 lun 0
> scsi scan: 1st INQUIRY successful with code 0x0
> scsi scan: 2nd INQUIRY successful with code 0x0
>   Vendor: SEAGATE   Model: ST39173F CLAR09   Rev: 351B
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> scsi scan: host 2 channel 0 id 1 lun 0 name/id: '32000002037109657'
> scsi scan: Sequential scan of host 2 channel 0 id 1
> scsi scan: INQUIRY to host 2 channel 0 id 1 lun 1
> scsi scan: 1st INQUIRY successful with code 0x0
> scsi scan: 2nd INQUIRY successful with code 0x0
> scsi scan: peripheral qualifier of 3, no device added
> scsi scan: INQUIRY to host 2 channel 0 id 2 lun 0
> scsi scan: 1st INQUIRY successful with code 0x0
> scsi scan: 2nd INQUIRY successful with code 0x0
>   Vendor: SEAGATE   Model: ST39173F CLAR09   Rev: 351B
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> scsi scan: host 2 channel 0 id 2 lun 0 name/id: '32000002037109db0'
> scsi scan: Sequential scan of host 2 channel 0 id 2
> scsi scan: INQUIRY to host 2 channel 0 id 2 lun 1
> scsi scan: 1st INQUIRY successful with code 0x0
> scsi scan: 2nd INQUIRY successful with code 0x0
> scsi scan: peripheral qualifier of 3, no device added
> [ lots of stuff deleted, as this fcp adapter goes up to id 255 ]
>
> -- Patrick Mansfield
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


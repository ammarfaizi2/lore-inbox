Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129577AbRBOK6T>; Thu, 15 Feb 2001 05:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRBOK6J>; Thu, 15 Feb 2001 05:58:09 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:15161 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129577AbRBOK5t>; Thu, 15 Feb 2001 05:57:49 -0500
Date: Thu, 15 Feb 2001 12:57:35 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Aic7xxx troubles with 2.4.1ac6
Message-ID: <20010215125735.C1147@niksula.cs.hut.fi>
In-Reply-To: <20010208135606.F2223@viasys.com> <3A8296E3.FC1EE707@redhat.com> <20010208181601.H2223@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010208181601.H2223@viasys.com>; from vherva@viasys.com on Thu, Feb 08, 2001 at 06:16:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 06:16:01PM +0200, you [Ville Herva] claimed:
> On Thu, Feb 08, 2001 at 07:53:55AM -0500, you [Doug Ledford] claimed:
> > Ville Herva wrote:
> > > 
> > > It looks like ac6 (which I believe includes the patch you posted) is
> > > still a no-go with 7892. The boot halts and it just prints this once a
> > > second:
> > > 
> > > (SCSI0:0:3:1) Synchronous at 160 Mbyte/sec offset 31
> > > (SCSI0:0:3:1) CRC error during data in phase
> > > (SCSI0:0:3:1)   CRC error in intermediate CRC packet
> > 
> > Check your cables, especially the connector on the card and the drive.  Look
> > for any possible bent pins.  The message you are seeing is *usually*, but not
> > always, a legitimate data corruption issue.  It doesn't show up under the
> > 5.2.1 driver because it limits your Quantum drive to 80MByte/s and that
> > particular speed doesn't include CRC checking.  On this driver you have to be
> > running at 160MByte/s before CRC checking is enabled.
> 
> I checked the cables. I think HP didn't supply proper 160 MB/S capable
> cables (aren't those the ones with wattlings?). When I forced the drive to
> 80MB/s from bios, not only did aic7xxx/ac6 work like charm, but the BIOS
> also found the "missing" MBR. Stupid problem ;).

Umm, I think I said that too early. I begun to have problem even during
boot; the scsi bios did recognize the drive, but the bios didn't find the
boot record. This was completely cured by forcing the drive to 80MB/s mode.
So I think the cable wasn't Ultra160 capable.

However, the 2.4.1ac6, 2.4.1ac2 and 2.19pre6 aic7xxx.c still had trouble
with the drive. I went back to 80MB/s, 40MB/s and even 20MB/s, but that
still didn't help. 2.4.1* reported time out while waiting for a command and
would go into an endless loop resetting the bus. 2.2.19pre6 said there was
an error during the data in phase, but after some coughing it booted up and
seemed to work quite alright.

NT4 booted up without and visible problems.

The HP service guy changed the motherboard (integrated scsi) the cable (to
another (80MB/s one), and the drive logics, but that didn't help.

The problems first started after the motherboard was first changed (due to
separate problem.) The new one had newer bios and scsi bios.

Anyhow, I just compiled 2.4.1ac13 with Justin Gibbs's aic7xxx, and it does
not suffer of any problem at 80MB/s.


-- v --

v@iki.fi

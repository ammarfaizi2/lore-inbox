Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135916AbREFXRU>; Sun, 6 May 2001 19:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135915AbREFXRM>; Sun, 6 May 2001 19:17:12 -0400
Received: from babylon5.babcom.com ([216.36.71.34]:4480 "EHLO
	babylon5.babcom.com") by vger.kernel.org with ESMTP
	id <S135910AbREFXRB>; Sun, 6 May 2001 19:17:01 -0400
Date: Sun, 6 May 2001 16:17:01 -0700
From: Phil Stracchino <alaric@babcom.com>
To: Linux-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: CDROM troubles -- some progress, problem remains
Message-ID: <20010506161701.A778@babylon5.babcom.com>
Mail-Followup-To: Linux-KERNEL <linux-kernel@vger.kernel.org>
In-Reply-To: <20010506030500.A26278@babylon5.babcom.com> <20010506144228.B13711@babylon5.babcom.com> <20010507000116.D506@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010507000116.D506@suse.de>; from axboe@suse.de on Mon, May 07, 2001 at 12:01:16AM +0200
X-No-Archive: Yes
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
X-Copyright: This message may not be reproduced, in part or in whole, for any commercial purpose without prior written permission.  Prior permission for securityfocus.com is implicit.
X-UCE-Policy: No unsolicited commercial email is accepted at this site.  The sending of any UCE to this domain may result in the imposition of civil liability against the sender in accordance with Cal. Bus. & Prof. Code Section 17538.45, and all senders of UCE will be permanently blocked.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 12:01:16AM +0200, Jens Axboe wrote:
> On Sun, May 06 2001, Phil Stracchino wrote:
> > On Sun, May 06, 2001 at 03:05:00AM -0700, Phil Stracchino wrote:
> > > Hey folks,
> > > I'm seeing a problem with mounting CDs using a Toshiba XM-6401TA CDROM
> > > drive attached to an Adaptec AHA1542CF controller (scsi1) on kernel 2.4.3
> > > and 2.4.4.  The behavior seems to be fairly consistent as follows:
> > > 
> > > first mount and unmount works normally, no unusual events logged
> > > second mount and unmount works normally, no unusual events logged
> > > third mount locks up the machine.  looks like a kernel panic.
> > > 
> > > Any ideas?
> > 
> > 
> > Panic is confirmed.  This time, it lived long enough to log:
> >  
> > May  6 14:05:05 babylon5 kernel: Kernel panic: scsi_free:Bad offset
> > 
> > Since it involves the CDROM, the aha1542 driver is implicated.  Why it's
> > getting a bad offset, I don't understand enough about the SCSI drivers to
> > know; all the scsi_free calls in aha1542.c look identical to me.
> >  
> > Would any Linux SCSI gurus care to let me know any diagnostic procedures
> > recommended for nailing this one?
> 
> The panic should be fixed with attached patch.


The patch does indeed seem to prevent the panic, but not the underlying
problem.  Here's the results of a series of mount/umount operations after
applying the patch:

	*** CD inserted
VFS: Disk change detected on device sr(11,0)
	*** first mount (succeeded)
ISO 9660 Extensions: RRIP_1991A
	*** second mount (succeeded)
ISO 9660 Extensions: RRIP_1991A
	*** third mount (succeeded)
ISO 9660 Extensions: RRIP_1991A
	*** fourth and subsequent mounts failed
sr: ran out of mem for scatter pad
 I/O error: dev 0b:00, sector 252
isofs_read_super: bread failed, dev=0b:00, iso_blknum=63, block=126
sr: ran out of mem for scatter pad
 I/O error: dev 0b:00, sector 0
sr: ran out of mem for scatter pad
 I/O error: dev 0b:00, sector 64
sr: ran out of mem for scatter pad
 I/O error: dev 0b:00, sector 0
	*** the last manual mount attempt
sr: ran out of mem for scatter pad
 I/O error: dev 0b:00, sector 64
	*** at this point I logged out, then logged back in as a different
	    user
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
sr: ran out of mem for scatter pad
 I/O error: dev 0b:00, sector 0
sr: ran out of mem for scatter pad
 I/O error: dev 0b:00, sector 64
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers
Warning - running *really* short on DMA buffers

The kernel is continuing to spew these warnings.  At the time of finishing
this message, there are now 51 of them.



-- 
 Linux Now!   ..........Because friends don't let friends use Microsoft.
 phil stracchino   --   the renaissance man   --   mystic zen biker geek
    Vr00m:  2000 Honda CBR929RR   --   Cage:  2000 Dodge Intrepid R/T
 Previous vr00mage:  1986 VF500F (sold), 1991 VFR750F3 (foully murdered)

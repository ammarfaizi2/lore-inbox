Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTFBGh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 02:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTFBGhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 02:37:53 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:34013 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S261956AbTFBGhl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 02:37:41 -0400
To: Oliver Neukum <oliver@neukum.org>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 with 250Gb disk and insane loads
References: <3EDA0E5D.8080404@pacbell.net>
	<200306011653.47958.oliver@neukum.org>
	<87k7c5g738.fsf@lapper.ihatent.com>
	<200306012021.41147.oliver@neukum.org>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 02 Jun 2003 08:51:03 +0200
In-Reply-To: <200306012021.41147.oliver@neukum.org>
Message-ID: <87llwl3rc8.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Oliver Neukum <oliver@neukum.org> writes:

> > > Probably the block layer as it waits for free io slots.
> > > But that doesn't tell us why the requests are not executed.
> > > Where is SCSI timeout kicking in?
> >
> > I'm not seeing any scsi timeouts in the logs.
> 
> So it seems that the driver doesn't fail utterly, but crawls along.
> Storage's debugging output should clarify the situation.
> 
> [..]
> > > Could you try on USB1.1 only?
> >
> > Stuck it in an older machine on USB 1.1 and it foudn the disk fine
> > (redhat 9, 2.4.20-13.9 kernel on that machine), and ditto result:
> >
> > 19:15:16  up 2 days, 20:23,  4 users,  load average: 6.02, 2.41, 0.89
> > 58 processes: 55 sleeping, 3 running, 0 zombie, 0 stopped
> > CPU states:   0.2% user   4.0% system   0.0% nice   0.0% iowait  95.8% idle
> > Mem:   385040k av,  380820k used,    4220k free,       0k shrd,   67368k
> > buff 224720k active,              69412k inactive
> > Swap:  521632k av,      80k used,  521552k free                  237452k
> > cached
> >
> > and generating about 2500 interrupts for the usb controller per 10
> > seconds and when i finally break it off and give it "sync" it uses
> > about two minutes with about 4500 per 10 seconds to get it all on
> > disk. On 2.4 the machine becomes more and more sluggish if I let it go
> > more than a short minute.
> 
> Which 2.4 ?
> 

This one was latest RedHat 9 kernel (yes I know, proprietary, but
ditto results on 2.4.21-rc[4|6]-ac[1|2].

Output below from 2.5.70-mm3 (USB 2.0), which leaves the machine in a
survivable state (as oposed to 2.4, which gradually climbs up a tree
and then falls down hard). After enabling debugging in USB storage it
fell over much more quickly.

> 	Regards
> 		Oliver

mvh,
A

alexh@lapper ~ $ dmesg
orage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b 9e a4 e7 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x135 Trg 0 LUN 0 L 4096 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x135 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b 9e c4 ef 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x136 Trg 0 LUN 0 L 4096 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x136 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b 9e e4 f7 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x137 Trg 0 LUN 0 L 4096 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x137 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b 9f 04 ff 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x138 Trg 0 LUN 0 L 4096 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x138 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b 9f 25 07 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x139 Trg 0 LUN 0 L 4096 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x139 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b 9f 45 0f 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x13a Trg 0 LUN 0 L 4096 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x13a R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b 9f 65 17 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x13b Trg 0 LUN 0 L 4096 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x13b R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b 9f 85 1f 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x13c Trg 0 LUN 0 L 4096 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x13c R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b 9f a5 27 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x13d Trg 0 LUN 0 L 4096 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x13d R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b 9f c5 2f 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x13e Trg 0 LUN 0 L 4096 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x13e R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b 9f e5 37 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x13f Trg 0 LUN 0 L 4096 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x13f R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b a0 15 4f 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x140 Trg 0 LUN 0 L 4096 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x140 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b a0 39 0f 00 04 00 00
usb-storage: Bulk command S 0x43425355 T 0x141 Trg 0 LUN 0 L 524288 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 524288 bytes, 128 entries
usb-storage: Status code 0; transferred 524288/524288
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x141 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b a0 3d 0f 00 04 00 00
usb-storage: Bulk command S 0x43425355 T 0x142 Trg 0 LUN 0 L 524288 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 524288 bytes, 128 entries
usb-storage: Status code 0; transferred 524288/524288
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x142 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b a0 41 0f 00 04 00 00
usb-storage: Bulk command S 0x43425355 T 0x143 Trg 0 LUN 0 L 524288 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 524288 bytes, 128 entries
usb-storage: Status code 0; transferred 524288/524288
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x143 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 1b a0 45 0f 00 04 00 00
usb-storage: Bulk command S 0x43425355 T 0x144 Trg 0 LUN 0 L 524288 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 524288 bytes, 128 entries
usb-storage: Status code 0; transferred 524288/524288
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: usb_storage_command_abort called
usb-storage: usb_stor_stop_transport called
usb-storage: -- cancelling URB
usb-storage: Status code -104; transferred 0/13
usb-storage: -- transfer cancelled
usb-storage: Bulk status result = 3
usb-storage: -- command was aborted
usb-storage: Bulk reset requested


- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+2vPTCQ1pa+gRoggRApiuAJ4nu4+/eSgQ5TRKwasBCp+0hUW3NgCfc4kQ
w6a0BReU5/srQE62zgdLDEI=
=tGSl
-----END PGP SIGNATURE-----

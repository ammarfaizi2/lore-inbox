Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTFBREX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTFBREX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:04:23 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:37860 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S263547AbTFBRED
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:04:03 -0400
To: David Brownell <david-b@pacbell.net>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 with 250Gb disk and insane loads
References: <3EDA0E5D.8080404@pacbell.net>
	<200306011653.47958.oliver@neukum.org>
	<87k7c5g738.fsf@lapper.ihatent.com>
	<200306012021.41147.oliver@neukum.org>
	<87llwkpoex.fsf@lapper.ihatent.com> <3EDB85B5.5040209@pacbell.net>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 02 Jun 2003 19:17:34 +0200
In-Reply-To: <3EDB85B5.5040209@pacbell.net>
Message-ID: <87brxgpff5.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Brownell <david-b@pacbell.net> writes:

> Alexander Hoogerhuis wrote:
> > I had a private reply form a guy that had three of these running
> > reliably on 2.4.21-pre6, and he noted he'd never done cd->disk
> > transfers, but across the net. So I did the same.
> > Results are that it survived a lot longer, I managed to get about
> > 700Mb across at about 8Mb/s (line speed 100mbit half duplex) before it
> > fell over with this:
> > ...
> > usb-storage: Command WRITE_10 (10 bytes)
> > usb-storage:  2a 00 18 f0 34 47 00 04 00 00
> > usb-storage: Bulk command S 0x43425355 T 0xc43 Trg 0 LUN 0 L 524288 F 0 CL 10
> > usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
> > usb-storage: Status code 0; transferred 31/31
> > usb-storage: -- transfer complete
> > usb-storage: Bulk command transfer result=0
> 
> 
> > usb-storage: usb_stor_bulk_transfer_sglist: xfer 524288 bytes, 128 entries
> > usb-storage: Status code 0; transferred 524288/524288
> > usb-storage: -- transfer complete
> > usb-storage: Bulk data transfer result 0x0
> 
> That's two successive operations on the OUT endpoint
> (two IRQs:  request, then 128 pages) both of which
> worked fine, followed by one on the IN endpoint:
> 
> 
> > usb-storage: Attempting to get CSW...
> > usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
> > usb-storage: usb_storage_command_abort called
> > usb-storage: usb_stor_stop_transport called
> > usb-storage: -- cancelling URB
> > usb-storage: Status code -104; transferred 0/13
> > usb-storage: -- transfer cancelled
> > usb-storage: Bulk status result = 3
> > usb-storage: -- command was aborted
> > ...
> 
> Interesting.  So basically, the failure mode you saw
> was that after all the data was (evidently) transferred
> OK, usb-storage aborted (for some reason) its fetch
> for the transfer status ... and then trouble.
> 
> Why did usb-storage abort that IN transfer?  If we
> knew that, we'd have a good clue as to what's going
> wrong.
> 

I'll be happy to do whatever is neccesary to answer that, but I have
no clue off-hand how to get at what the problem is.

> 
> > Load only got up to about 3-4 before it fell over.
> > Apart from that, it seems the speed at which it falls over is
> > depening
> > on two factors: with/without debugging and speed at which data arrives
> > for the drive.
> 
> Not unrelated.  Turning on usb-storage debug slows down the
> rate at which data is handed to the drive.
> 

True, but I was thinking of it keeling over faster with debugging than
without. 

> - Dave
> 

- -A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+24arCQ1pa+gRoggRAgzNAKDICQ+jU3ck4RV4w1dTBt8LgyHCSwCdGVpJ
86HgVilIQpKHdv2uWNhXmo0=
=Xtnx
-----END PGP SIGNATURE-----

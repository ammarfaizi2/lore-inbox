Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbRFQUA4>; Sun, 17 Jun 2001 16:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbRFQUAr>; Sun, 17 Jun 2001 16:00:47 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:18019 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S262719AbRFQUA3>;
	Sun, 17 Jun 2001 16:00:29 -0400
Message-ID: <20010617220032.A21156@win.tue.nl>
Date: Sun, 17 Jun 2001 22:00:32 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: "David Flynn" <Dave@keston.u-net.com>,
        "linux kernel mailinglist" <linux-kernel@vger.kernel.org>
Subject: Re: [slightly OT] IDE problems ? or just a dead disk ?
In-Reply-To: <00f501c0f74e$defac4e0$1901a8c0@node0.idium.eu.org> <017601c0f75d$454c6e70$1901a8c0@node0.idium.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <017601c0f75d$454c6e70$1901a8c0@node0.idium.eu.org>; from David Flynn on Sun, Jun 17, 2001 at 07:42:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2001 at 07:42:33PM +0100, David Flynn wrote:

> ive done the badblock test, and compiled a list of 2302 bad blocks on this
> disk ... however, when running mke2fs -l badblocfile /dev/hdc1
> 
> i got this interesting errormessage for every one of the bad blocks :
> 
> Bad block 1006290 out of range; ignored.
> 
> mke2fs said my disk was my disk would be 132480 inodes, 264592 blocks in
> size ...
> 
> some bits in proc (well this capacity one i dont know what it measures)
> 
> root:/root# cat /proc/ide/hdc/capacity
> 2116800

Your disk has 2116800 sectors of size 512, that is, 1083801600 bytes
(slightly over 1 GB).

> root:/root# cat /proc/ide/hdc/geometry
> physical     2100/16/63
> logical      525/64/63
> 
> is there a geometry problem ?

Nothing wrong here.

> whats causing bad blocks to give apparently
> excessivly large bad blocks ...?

2116800 sectors of size 512 is the same as 1058400 blocks of size 1024.
Nothing is wrong with block 1006290 being mentioned.

Note that hdc1 is a partition on hdc, not all of hdc.

> > kernel: end_request: I/O error, dev 16:00 (hdc), sector 2116604
> > kernel: hdc: read_intr: status=0x59 { DriveReady SeekComplete DataRequest
> > Error }
> > kernel: hdc: read_intr: error=0x40 { UncorrectableError },

At first sight this is just a rotten disk.
But since this is very close to the end of the disk, you might
investigate some details. (Some ZIP disks can be used as big floppy
and as removable disk, that is, without or with partition table,
and differ a little in size depending on what you do.
Don't know whether something similar could apply in your case.)

Of interest:
(i) the output of dmesg | grep hdc
(ii) the first sector that fails (is it this 2116604?)

Andries

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269538AbRGaXpD>; Tue, 31 Jul 2001 19:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269539AbRGaXot>; Tue, 31 Jul 2001 19:44:49 -0400
Received: from weta.f00f.org ([203.167.249.89]:21390 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269538AbRGaXoc>;
	Tue, 31 Jul 2001 19:44:32 -0400
Date: Wed, 1 Aug 2001 11:45:13 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Dan Hollis <goemon@anime.net>
Cc: Jussi Laako <jlaako@pp.htv.fi>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010801114513.B8839@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.30.0107311526360.13810-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0107311526360.13810-100000@anime.net>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 03:32:39PM -0700, Dan Hollis wrote:

    How about an idea I proposed a while back, 'integrity loopback'?

    A loopback device which writes a CRC with each block and checks
    the CRC when read back.

    So if you have a flaky DMA controller, bad cables, etc you will
    know instantly. It would at least help catch the 'silent
    corruption' cases.

It still doesn't help with block-reordering, the fs needs some way to
communication write-barriers or relative block write ordering to the
lower-levels.

To implement the device, I would hack loopback to take no only the
loopback file, but also another 'checksum' file of 160-bits or
whatever for each 4096 (or whatever) block.  This file might initially
be of zero-length, in which case the bind is responsible for
checksumming the blocks and writing the checksums out on attach.

I say 160-bits (or whatever) so you can use something like SHA1 for
the checksums, this way you can use a small application to resync the
entire fs at the block level over a network without having to read
every block (ie. you compared checksums and then xmit the blocks).
The latter is something I needed a while ago.



  --cw

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265554AbRF1Gnn>; Thu, 28 Jun 2001 02:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265571AbRF1Gnd>; Thu, 28 Jun 2001 02:43:33 -0400
Received: from c009-h017.c009.snv.cp.net ([209.228.34.130]:62623 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S265554AbRF1GnP>;
	Thu, 28 Jun 2001 02:43:15 -0400
X-Sent: 28 Jun 2001 06:43:09 GMT
Date: Wed, 27 Jun 2001 23:42:43 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How to change DVD-ROM speed?
In-Reply-To: <20010627200554.I17905@suse.de>
Message-ID: <Pine.LNX.4.33.0106272312580.613-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2001, Jens Axboe wrote:

> On Wed, Jun 27 2001, Jeffrey W. Baker wrote:
> >
> > I will be happy to :)  Should I hang conditional code off the existing
> > ioctl (CDROM_SELECT_SPEED, ide_cdrom_select_speed) or use a new one?
>
> Excellent. I'd say use the same ioctl if you can, but default to using
> SET_STREAMING for DVD drives.

Hrmm, ah, hrmm.  Perhaps I need a little help with this one :)

Just for testing, I modified cdrom_select_speed in ide-cd.c to use SET
STREAMING.  Working from the Fuji spec, I created a 28-byte buffer, set
the starting lba to 0, the ending lba to 0xffffffff, the read speed to
0x000000ff, and the read time to 0x000000ff, expecting a resulting speed
of 1KB/ms or 1000KB/s[1].  I assign the buffer to pc.buffer and send it on
its way to cdrom_queue_packet_command().

The result is:

CDROM_SELECT_SPEED failed: Input/output error
hdc: status timeout: status 0x80 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete

Am I barking up the wrong tree?   Do I need to use a different function,
or a generic command instead of a packet command?

Regards,
Jeffrey

[1] Interesting that there appears to be enough room in the spec for a
drive transferring 2^32 * 1000 KB/s.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281912AbRLFSNy>; Thu, 6 Dec 2001 13:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281915AbRLFSNo>; Thu, 6 Dec 2001 13:13:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51217 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281912AbRLFSNd>; Thu, 6 Dec 2001 13:13:33 -0500
Date: Thu, 6 Dec 2001 10:07:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <E16C2qa-0002RR-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112060958450.10625-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Dec 2001, Alan Cox wrote:
>
> > Timeouts for different commands were so different that people ended up
> > making most timeouts so long that they no longer made sense for other
> > commands etc.
>
> Thats per _target_ not host. Which needs to be common code.

It hasn't traditionally been "common code". The old SCSI layer has various
fixed timeouts, many of them on the order of 2-5 minutes, and none of them
target-specific.

Some of them are effectively turned off - the format timeout was increased
to 2 hours to make sure that it basically never triggers.

But never fear, we'll have some common routines for error handling.  But
they will be library routines, NOT the current crap.

> Those devices aren't SCSI controllers, and they don't want to appear as one.

Ehh.. IDE disks take SCSI commands, and do most error recovery entirely in
disk firmware. There is very little you can do about most errors there.

Don't think "SCSI" as in SCSI controllers. Think SCSI as in "fairly
generic packet protocol that somehow infiltrated most things".

> Which is another thing - can you make the internal dev_t 32 or 64bits now.
> You can have 65536 volumes on an S/390 so even with perfectly distributed
> devfs allocated device identifiers - we don't have enough.

It's called "struct block_device" and "struct genhd". The pointers will
have as many bits as pointers have on the architecture. Low-level drivers
will not even see anything else eventually, there will be no "numbers".

		Linus


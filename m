Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261202AbREUMRZ>; Mon, 21 May 2001 08:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261219AbREUMRP>; Mon, 21 May 2001 08:17:15 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:26824 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261202AbREUMRI>; Mon, 21 May 2001 08:17:08 -0400
Message-ID: <3B090645.9D54574F@uow.edu.au>
Date: Mon, 21 May 2001 22:12:53 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Vojta <vojta@ipex.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c905C-TX [Fast Etherlink] problem ...
In-Reply-To: <20010521090946.D769@ipex.cz> <3B08C15E.264AE074@uow.edu.au>,
		<3B08C15E.264AE074@uow.edu.au> <20010521140443.C8397@ipex.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Vojta wrote:
> 
> > This is a `transamit reclaim' error.  It is almost always
> > caused by this host being in half-duplex mode, and another
> > host on the network being in full-duplex mode.
> 
> Hi,
>   I tried to force this to be in fullduplex mode by options=0x204 (0x200 + 0x4)
> and it works fine now.

mm..  It _should_ autonegotiate.  Perhaps the device at
the other end is old or not very good.

> Please, can you send me some points to the documentation
> where I can read more info about 'transamit reclaim' error and why this
> happens, etc ...

http://www.scyld.com/network/vortex.html is the official
place.  It doesn't tell you much.

vortex.txt has a pointer to 3com's documentation. Heavy
going.

When the NIC is running in full-duplex mode it *assumes*
that once (by default) 128 bytes of a frame have gone
onto the wire, the remainder of the frame will be sent
without any collisions.  This assumption allows it to reuse
part on the on-board memory - it transfers more data from
the host into the place where the currently-transmitting
frame used to reside.

If another host then comes along and generates a collision
this late into the frame, the NIC detects it but cannot
back off and retransmit the frame as it would normally do.
Because the frame's memory has been "reclaimed".  All it
can do is raise an interrupt and complain.

-

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129606AbRBLUkQ>; Mon, 12 Feb 2001 15:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129688AbRBLUkF>; Mon, 12 Feb 2001 15:40:05 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:34187 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129606AbRBLUjx>; Mon, 12 Feb 2001 15:39:53 -0500
Date: Mon, 12 Feb 2001 20:39:19 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <969b4m$sbp$1@cesium.transmeta.com>
Message-ID: <Pine.SOL.4.21.0102122025320.22949-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Feb 2001, H. Peter Anvin wrote:

> Followup to:  <Pine.LNX.4.10.10102120849580.3761-100000@main.cyclades.com>
> By author:    Ivan Passos <lists@cyclades.com>
> In newsgroup: linux.dev.kernel
> > 
> > Since I still want to add support for speeds up to 115200, the other two
> > questions are still up (see below):
> > 
> > > - If not, do I need to change just LILO to do that, or do I need to change
> > >   the kernel as well (I don't think I'd need to do that too, as the serial 
> > >   console kernel code does support up to 115.2Kbps, but it doesn't hurt to 
> > >   ask ... ;) ??
> > > - Does another bootloader (e.g. GRUB) support serial speeds higher than
> > >   9600bps?? If so, which one(s)??
> > 
> > I'd really appreciate any help.
> > 
> 
> SYSLINUX supports up to 57600 (it doesn't support 115200 because it
> stores the number in a 16-bit register) but seriously... why the heck
> does this matter?  It isn't booting the kernel off the serial line,
> you know.  A console at 38400 is really quite sufficient... if you
> need something more than that, you probably should be logging in via
> the network.
> 
> I have toyed a few times about having a simple Ethernet- or UDP-based
> console protocol (TCP is too heavyweight, sorry) where a machine would
> seek out a console server on the network.  Anyone has any ideas about
> it?

Excellent plan: data centre sysadmins the world over will worship your
name if it works...

What exactly do you have in mind: a bidirectional connection you could
use to control everything from LILO/Grub onwards? Should be feasible,
anyway.

I'd go with UDP for this, rather than raw Ethernet. Use DHCP to get the IP
address(es) to connect to as console hosts? (That or a command line
option...)

The first thing is the kernel: just wrap around printk so as soon as eth0
is up, you set up a session and start sending packets.


I'll do a server to receive these sessions - simple text (no vt100 etc),
one window per session - and work on the protocol spec. Anyone willing
to do the client end of things - lilo, grub, kernel, etc??


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/

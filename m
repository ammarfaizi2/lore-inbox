Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266957AbSL3MuZ>; Mon, 30 Dec 2002 07:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbSL3MuZ>; Mon, 30 Dec 2002 07:50:25 -0500
Received: from pool-151-196-172-2.balt.east.verizon.net ([151.196.172.2]:37615
	"EHLO beohost.scyld.com") by vger.kernel.org with ESMTP
	id <S266957AbSL3MuU>; Mon, 30 Dec 2002 07:50:20 -0500
Date: Mon, 30 Dec 2002 07:59:00 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Deian Chepishev <deian@blue-edge.bg>
cc: andrewm@uow.edu.au, <netdev@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <vortex@scyld.com>
Subject: Re: 3Com PCI 3c905C Tornado  problems (no network sometimes)
In-Reply-To: <002d01c2affa$0e76d9b0$0b00050a@deian>
Message-ID: <Pine.LNX.4.44.0212300742240.29812-100000@beohost.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2002, Deian Chepishev wrote:

> for about a year and a half i have problems with network cards 3Com PCI
> 3c905C Tornado
...
> Log entries while loading driver 3c90x are:
> 
> Dec 19 16:03:35 oboroten kernel: 3c59x: Donald Becker and others.
> www.scyld.com/network/vortex.html
> Dec 19 16:03:35 oboroten kernel: 01:03.0:     at 0xc000. Vers LK1.1.18-ac

Are there other messages?  Something has apparently removed the
important log message of that identified the board and the current
transceiver setting.

> ... (the switch is 3COM office connect DualSpeedSwitch 16).

Which model?  What era?  A few of the early 3Com switches did have
autonegotiation timing flaws.  Most are managed switches, and the proper
work-around is to set them to forced 100baseTx half duplex operation.

> In order to fix the problem i must unplug the power cord(there is no other
> way to copletely stop powering the computer) wait a few seconds plug it

This is because of the Wake-On-LAN capability of the board.  It
continues link beat in soft-power-off mode.  Depending on the
motherboard (if standby-power is supplied through the PCI connector),
you might be able to change the behavior by disconnecting the WOL
cable.  But that's not a solution.

> again and start the computer from the button and check to see if the led is
> blinking if yes reapeat this action as much times as is necessary for the
> led to stop blinking. The interesting part is that if the NIC is blinking
> and i load windows the things are working just fine i think that windows
> driver has some initialisation (the led stops blinking) which the linux
> driver does not have but these are just suppositions.

The Windows driver likely resets the transceiver.  The 3c59x driver
avoids doing this.  Rapidly resetting the link results in bad behavior
from some switches, and some Linux configurations results in rapid
restarts of the driver.

> Notice that i have some lines in the messages log "working situation" which
> looks like this:
> 
> ping -f some.host
> Dec 30 12:52:01 oboroten kernel: eth0: vortex_error(), status=0xe081

You have the debug/message level turned up past the default, and the
driver is reporting that statistics overflowed.  Check the error counts
in /proc/net/dev.  This is likely unrelated.

> i have running 4 machines with the same HW configuration and the problem is
> reproducable on all of them. I have noticed this problem since kernel 2.4.2
> and it is here by now.

Try the driver release from
   http://www.scyld.com/network/vortex.html
      ftp://ftp.scyld.com/pub/network/test/3c59x.c

> I have this problem often when we have power failure and my boss is not very
> happy the servers to be down when i am not in the office after power
> failure.
> I have executed and the diagnostic programs mii-diag and vortex-diag their
> logs are attached to the mail too.

Does 'mii-diag --reset' result in a working link?

-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Scyld Beowulf cluster system
Annapolis MD 21403			410-990-9993


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318366AbSHKUwG>; Sun, 11 Aug 2002 16:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318365AbSHKUwF>; Sun, 11 Aug 2002 16:52:05 -0400
Received: from esperi.demon.co.uk ([194.222.138.8]:20754 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP
	id <S318366AbSHKUwE>; Sun, 11 Aug 2002 16:52:04 -0400
Date: Sun, 11 Aug 2002 21:55:25 +0100 (BST)
From: Kieran <kieran@esperi.demon.co.uk>
X-X-Sender: kieran@amaterasu.srvr.nix
To: linux-kernel@vger.kernel.org
Subject: Ultrasparc 1 network freeze
Message-ID: <Pine.LNX.4.43.0208112110500.391-100000@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got an ultra 1 with on-board HME that I'm trying to install linux
on via the serial console.

I'm network boot-strapping via the debian install described on
http://www.debian.org/releases/stable/sparc/install.en.html#contents
using files downloaded from
debian/dists/woody/main/disks-sparc/3.0.23-2002-05-21/sun4u

The result is
$ uname -a
Linux godot 2.4.18 #2 Thu Apr 11 14:37:17 EDT 2002 sparc64 unknown

and there are no modules currently installed. The network device is
attached to a 100mbit hub.  All machines on this hub have mtu set
to 576.

Because of screw-ups, I've downloaded significant amounts of debian a
couple of times in the last 3 days over dial-up, and this has worked
flawlessly.  However, a couple of times, I've seen a network freeze
(while the serial console has continued to work...) after local network
activity.

Once, this was an ftp of a gentoo stage 1 bootstrap image from a box on
the same subnet, and on other occasions, shell commands run via openssh
with priv-sep with significant output (like "find") run concurrently
with downloads have also cause a freeze.

The resulting freeze leaves a box which doesn't respond to pings, and
cannot ping other hosts.  "ifconfig eth down" then "up" does not resolve
the problem.

The following is the cut'n'paste of the last such freeze, which occured
while I was running part of a gentoo bootstrap on the serial console:

<snip earlier stuff>
>>> Downloading
http://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/binutils-manpages-2.11.92.0.12.3.tar.bz2
--19:34:34--
http://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/binutils-manpages-2.11.92.0.12.3.tar.bz2
           =>
`/usr/portage/distfiles/binutils-manpages-2.11.92.0.12.3.tar.bz2'
Resolving www.ibiblio.org... NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, resetting
eth0: Happy Status 03030000 TX[000003ff:00000101]
failed: Host not found.

>>> Downloading
http://www.ibiblio.org/gentoo/distfiles/binutils-manpages-2.11.92.0.12.3.tar.bz2
--19:35:14--
http://www.ibiblio.org/gentoo/distfiles/binutils-manpages-2.11.92.0.12.3.tar.bz2
           =>
`/usr/portage/distfiles/binutils-manpages-2.11.92.0.12.3.tar.bz2'
Resolving www.ibiblio.org... eth0: Link is up using internal transceiver
at 100Mb/s, Half Duplex.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, resetting
eth0: Happy Status 03010000 TX[000003ff:00000101]
eth0: Link is up using internal transceiver at 100Mb/s, Half Duplex.
failed: Host not found.
!!! Couldn't download binutils-manpages-2.11.92.0.12.3.tar.bz2.
Aborting.
!!! emerge aborting on
/usr/portage/sys-devel/binutils/binutils-2.11.92.0.12.3-r2.ebuild .
godot:/usr/portage/scripts# NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, resetting
eth0: Happy Status 03010000 TX[000003ff:00000101]
eth0: Link is up using internal transceiver at 100Mb/s, Half Duplex.

<end quote>

Reboot seems to cure the problem (via break on the console and then
issuing a boot command at the prom monitor), until further stress is
applied.

Any ideas would be welcome.

Regards

Kieran Barry


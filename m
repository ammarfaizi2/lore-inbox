Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267593AbSLSJzO>; Thu, 19 Dec 2002 04:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbSLSJzO>; Thu, 19 Dec 2002 04:55:14 -0500
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:44814 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S267593AbSLSJzN>; Thu, 19 Dec 2002 04:55:13 -0500
Subject: parport_serial link order bug, NetMos support
To: linux-kernel@vger.kernel.org
Date: Thu, 19 Dec 2002 11:03:12 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E18OxWK-0004w8-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been trying (for quite a long time now, starting around the
time when 2.4.19 was released) to submit the following patches into
the 2.4.x kernel:

http://www.amelek.gda.pl/linux-patches/2.4.20-pre9/00_parport_serial
http://www.amelek.gda.pl/linux-patches/2.4.20-pre9/01_netmos

(generated for 2.4.20-pre9, but apply cleanly to 2.4.20-final too,
00_parport_serial needs to be applied before 01_netmos).

The first patch fixes a bug with CONFIG_PARPORT_SERIAL=y (moves the
parport_serial driver - must be initialised after serial).  This
bug has been fixed in 2.5.x some time ago, by moving the serial
driver to its own directory - a change that looks too intrusive for
2.4.x, moving parport_serial instead looks much safer.  This patch
is quite big, but most of it is just moving parport_serial.c from
drivers/parport/ to drivers/char/ without changing a single line.
Now parport_serial is after serial, but before any drivers that
need parport already initialised: lp, block (paride), net (plip).

The second patch adds support for NetMos PCI I/O cards, based on
a >1 year old 2.5.x patch by Tim Waugh.  I've been using a few
NM9835-based cards in production use, no problems so far (in 3
machines, one of them is my server with two permanent 115.2k PPP
connections, which have seen quite a few gigabytes of traffic).

Now that 2.4.21-pre2 is out, I'd like to ask - are there any good
reasons why these patches are not going in?  There has been some
discussion, but no conclusion either way (not accepted, and not
rejected).  Are there any known problems, like some NM9835 chips
burn and explode when run under Linux and I've just been lucky? ;)

Please, I would really appreciate to see these patches in 2.4.21.

Thanks,
Marek


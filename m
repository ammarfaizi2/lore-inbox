Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbTFUVsh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 17:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbTFUVsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 17:48:37 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:6664 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP id S265375AbTFUVsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 17:48:36 -0400
Date: Sun, 22 Jun 2003 00:01:44 +0200
To: marcelo@conectiva.com.br
Cc: twaugh@redhat.com, linux-kernel@vger.kernel.org, linux-parport@torque.net
Subject: [patch] 2.4.21 parport_serial link order fix, NetMos support
Message-ID: <20030621220144.GA528@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

that's me again, trying to submit this since 2.4.19 or so, with no
success so far.  Please consider for 2.4.22 if it ever happens...

I've been successfully using a few low cost PCI multi-IO cards (only
"made in China" on the PCB, "STLab" on the box) based on the NetMos
NM9835 chip (1 parallel port, 2 serial ports), for a few months now.
Patches (now updated for 2.4.21) are available here:

http://www.amelek.gda.pl/linux-patches/2.4.21/00_parport_serial
http://www.amelek.gda.pl/linux-patches/2.4.21/01_netmos

00_parport_serial fixes a link order bug (parport_serial didn't work
at all when compiled into the kernel, only as a module).  The patch
file is big, but most of it just moves drivers/parport/parport_serial.c
to drivers/char/ without changing a single line.  This way the driver
is initialised after serial, but still before any other drivers which
need the parport subsystem, such as: lp, paride, plip, ...

01_netmos (must be applied after 00_parport_serial) adds support for
the NetMos PCI parallel port and multi-IO chips.  This is based on an
old (2001) patch by Tim Waugh, without significant changes.

Apparently, some people had system lockups with NetMos cards when
trying to use the parport IRQ.  This patch does not do this -
polling mode works, and is better than nothing.  Anyway, I've also
added a config option (CONFIG_PARPORT_PC_NETMOS, conditional on
CONFIG_EXPERIMENTAL), with Documentation/Configure.help description.
Hopefully this will help to get the patch accepted into the kernel.

Thanks,
Marek


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261990AbTCLUqU>; Wed, 12 Mar 2003 15:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261992AbTCLUqU>; Wed, 12 Mar 2003 15:46:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:525 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261990AbTCLUqR>; Wed, 12 Mar 2003 15:46:17 -0500
Date: Wed, 12 Mar 2003 20:56:59 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [CFT] PCMCIA patches
Message-ID: <20030312205659.C27656@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm about to send a set of 6 PCMCIA patches, which I'd like people to
test.  They're against base current 2.5.64 BK (as of this morning GMT,)
but they apply with some offset to plain .64.

The patch numbering starts at 2 - the first set (which was 1a to 1h)
was ARM stuff, which Linus has already accepted.

pcmcia-2.diff

  get_io_map and get_mem_map PCMCIA socket methods are never called
  by the PCMCIA core code.  They are therefore dead code, and can be
  removed.

pcmcia-3.diff

  Remove the bus_* abstractions.

pcmcia-4.diff

  Cardbus uses socket->cb_config to detect when the cardbus card has
  been initialised.  Since cb_config will eventually die, we need a
  solution - introduce the SOCKET_CARDBUS_CONFIG flag, which is set
  once we have initialised the cardbus socket.

pcmcia-5.diff

  Add an element of locking to the resource manager - don't allow
  the PCMCIA resource lists to be changed while the pcmcia code is
  scanning them.

pcmcia-6.diff

  Remove the dependence of the PCMCIA layer on CONFIG_ISA - introduce
  CONFIG_PCMCIA_PROBE to determine whether we need the resource
  handling code.  This prevents oopsen on SA11x0 and similar platforms
  which use statically mapped, non-windowed sockets.

pcmcia-7.diff

  Remove support for the old PCMCIA cardbus clients - all cardbus
  drivers should be converted to be full-class PCI citizens.


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


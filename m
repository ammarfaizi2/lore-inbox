Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317203AbSEXRdx>; Fri, 24 May 2002 13:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317211AbSEXRdv>; Fri, 24 May 2002 13:33:51 -0400
Received: from sark.cc.gatech.edu ([130.207.7.23]:46322 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S317203AbSEXRds>; Fri, 24 May 2002 13:33:48 -0400
Date: Fri, 24 May 2002 13:33:45 -0400
From: Josh Fryman <fryman@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: problem: io_remap address exhaustion?
Message-Id: <20020524133345.67181ee2.fryman@cc.gatech.edu>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

this may be a dumb question, but we're encountering a bit of difficulty with
two PCI cards we have in a system here.

we've got a P4 with 512MB of RAM.  this P4 has two PCI cards, which are 
identical, each of which has 256MB of RAM.  we're working on a driver to
talk to the devices and present their entire memory space to the user
via "io_remap()" but it seems to be exhausting the memory space...

eg, if we try to do the remap on the first card, it works fine.  the second
card fails.  if we drop the SDRAM size from 256M to 128M, we can map both
cards fine.  however, we note the starting addresses look like so:

May 24 13:23:33 ilab2 kernel: ixp1200: I21555  CSRs:  phys(0xfe4ff000) virt(0xe98ed000) size(4 KB)
May 24 13:23:33 ilab2 kernel: ixp1200: IXP1200 CSRs:  phys(0xdff00000) virt(0xe992b000) size(1 MB)
May 24 13:23:33 ilab2 kernel: ixp1200: IXP1200 SDRAM: phys(0xc0000000) virt(0xe9a2c000) size(256 MB)
May 24 13:23:33 ilab2 kernel: ixp1200: Hooked & enabled master IRQ(20) handler
May 24 13:23:33 ilab2 kernel: ixp1200: ixp0: Probing/setting up IXP1200 ethernet interface!
May 24 13:23:33 ilab2 kernel: ixp1200: ixp_map_one: Failed to ioremap_nocache() IXP1200's SDRAM memory region!
May 24 13:23:33 ilab2 kernel: ixp1200: Found and initialized 1 IXP1200 board.

is there some place to lower the virtual memory address being used here?  we're
clearly wrapping the address which is causing the failure, but i'm hesitant to
poke in the VM extensively trying to hack a horrible fix for this...

thanks for any pointers (to code or documentation),

josh

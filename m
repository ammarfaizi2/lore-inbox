Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbTFCLCC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 07:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbTFCLCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 07:02:02 -0400
Received: from fe6.rdc-kc.rr.com ([24.94.163.53]:26127 "EHLO mail6.kc.rr.com")
	by vger.kernel.org with ESMTP id S264953AbTFCLCB (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Tue, 3 Jun 2003 07:02:01 -0400
Date: Tue, 3 Jun 2003 06:15:19 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.redhat.com>
Cc: andre@linux-ide.org, marcelo@conectiva.com.br
Subject: lost interrupts with 2.4.1-rc6 and i875p chipset
Message-ID: <20030603111519.GA23228@glitch.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.redhat.com>,
	andre@linux-ide.org, marcelo@conectiva.com.br
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently installed Debian on a new i875P chipset machine, and I'm
seeing frequent "hdX: lost interrupt" messages at the console under
2.4.21-rc6.  The IDE system appears to stall for 5 seconds or so
whenever this occurs (I assume that a reset/resync is occurring), but
then seems to recover.  It's pretty easy to reproduce... any
significant disk activity will trigger the problem.  In particular,
running fsck or copying files off a cdrom will expose the problem
within seconds.

This issue does not occur under 2.4.20.  Both kernels were compiled
using gcc 2.95.4, and no non-kernel modules are in use in either case
(no nvidia module, for instance).  I'd be happy to provide additional
information, if someone can point out what would be helpful.


root@glitch[~]# lspci -i ~adric/pci.ids 
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02)
00:1f.2 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev a2)
02:02.0 Multimedia audio controller: Creative Labs [SB Live! Value] EMU10k1X
02:02.1 Input device controller: Creative Labs [SB Live! Value] Input device controller
02:08.0 Ethernet controller: Intel Corp.: Unknown device 1050 (rev 02)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWCHVfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWCHVfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWCHVfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:35:09 -0500
Received: from mail-new.archive.org ([207.241.227.188]:16799 "EHLO
	mail-new.archive.org") by vger.kernel.org with ESMTP
	id S932575AbWCHVfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:35:07 -0500
Date: Wed, 8 Mar 2006 13:35:04 -0800 (PST)
From: Joerg Bashir <brak@archive.org>
To: <linux-kernel@vger.kernel.org>
Subject: via-rhine.c PXE revisited
Message-ID: <Pine.LNX.4.33.0603081324040.16839-100000@homeserver.archive.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm PXE booting a few hundred VIA Epia M based boards with 2.6.x.

While there is a fix for the PXEROM it requires rolling your own VIA BIOS 
to incorporate it.  VIA has not released a BIOS update for this board 
since late 2004, and our vendor is not receiving any linux love from VIA 
about this issue.

Therefore, it's still necessary to comment out line 1968 in 
drivers/net/via-rhine.c (from 2.6.16-rc5 for example)

        /* Hit power state D3 (sleep) */
        /* iowrite8(ioread8(ioaddr + StickyHW) | 0x03, ioaddr + StickyHW); 
*/

        /* TODO: Check use of pci_enable_wake() */

Previously on the LKML the issue with setting this option was breaking 
WOL on other versions of this hardware.

Is it a feasible request a config option to address this issue?  

It's quite obviously a firmware bug in the PXEROM as Alan Cox clearly 
pointed out last time around.  See http://lkml.org/lkml/2004/11/11/151

I know it's a lame request in order to avoid patching a kernel every time 
it comes out instead of being able to do make oldconfig and have it just 
work...  but I thought I'd ask.

Thanks,
Joerg

Here is lspci from those boxen...

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8623 [Apollo CLE266]
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
0000:00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 74)
0000:01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8623 
[Apollo CLE266] integrated CastleRock graphics (rev 03)



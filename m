Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263693AbTCVQo0>; Sat, 22 Mar 2003 11:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263697AbTCVQo0>; Sat, 22 Mar 2003 11:44:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39688 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263693AbTCVQoY>; Sat, 22 Mar 2003 11:44:24 -0500
Date: Sat, 22 Mar 2003 16:55:25 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [BK PULL] PCI patches
Message-ID: <20030322165525.D8712@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull bk://bk.arm.linux.org.uk/linux-2.5-pci

to include the latest PCI changes from Ivan Kokshaysky/myself.  This will
update the following files:

 arch/i386/pci/common.c  |   15 +++
 drivers/pci/pci.c       |   48 ++++-----
 drivers/pci/setup-bus.c |  235 ++++++++++++++++++++++++++++++++++++++++--------
 drivers/pci/setup-res.c |    6 -
 4 files changed, 239 insertions, 65 deletions

through these ChangeSets:

<ink@ru.rmk.(none)> (03/03/22 1.1133)
	[PCI] Fix incorrect PCI cache line size assumptions.
	
	Fix incorrect PCI cache line size assumptions on i386 and thus
	avoid potential memory corruption with Memory Write-and-Invalidate.

<ink@ru.rmk.(none)> (03/03/22 1.1132)
	[PCI] Make setup-bus.c aware of cardbus bridges.
	
	Comments from rmk:
	
	Make setup-bus.c properly aware of cardbus bridges.  We treat the
	bus behind a cardbus bridge more or less like any other bus, except
	we don't explicitly descend below.  We do, however, explicitly
	reserve IO and memory space as we have done in the past.  Memory
	space is doubed to 32MB as a measure to allow the Mobility
	cardbus-pci stuff to work.  The amount of space reserved is now
	specified by a couple of #defines at the top of the file.
	
	This allows pci_bus_assign_resources() and pci_bus_size_bridges()
	to be called for both root buses as well as cardbus secondary buses.
	
	Comments from Ivan follows:
	
	This patch combines your(rmk) cardbus changes (formerly pci-11)
	and my "arbitrary resource layout" stuff. This + current bk works
	on nautilus.
	
	Most interesting feature: this can be used on partially
	allocated PCI tree. For instance, i386 PCI code has always been
	absolutely helpless wrt incorrectly initialized p2p bridges.
	Now it can just call pci_assign_unassigned_resources() in the
	end of PCI init and it would fix following problems:
	- completely uninitialized bridge windows (with base and limit 0);
	- erroneously "closed" windows;
	- windows overlapping with something else.

<ink@undisclosed.(none)> (03/03/22 1.1131)
	[PCI] Don't call pci_update_resource() for bridge resources.
	  
	Minor cleanup: don't call pci_update_resource() for bridges,
	get rid of bogus "trying to set non-standard region" messages thus.


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


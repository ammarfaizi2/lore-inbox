Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVBXUWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVBXUWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 15:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVBXUWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 15:22:42 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:22596 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S262466AbVBXUWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 15:22:33 -0500
Date: Thu, 24 Feb 2005 14:22:19 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: tripperda@nvidia.com
Subject: 64-bit pci bar on a 32-bit kernel
Message-ID: <20050224202218.GK4801@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 24 Feb 2005 20:22:32.0306 (UTC) FILETIME=[91D2A520:01C51AAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we've gotten a customer report of a problem whereby our framebuffer is
not visible through the kernel. the kernel data structures in struct
pci_dev have bar1 (our framebuffer) set to 0, and the bar does not
appear in /proc/pci.

after a little investigation, it appears that the bios allocated a
64-bit bar in pci config space. our gpu claims 64-bit support in pci
config space and the cpu is an em64t. but the customer is running a
32-bit kernel on the em64t, which is a reasonable thing to do. it
turns out the pci driver does not like 64-bit bars on a 32-bit kernel
and prints out the following messages during boot:

PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=5
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
PCI: Unable to handle 64-bit address space for
PCI: Unable to handle 64-bit address space for
PCI: Unable to handle 64-bit address for device 03:00.0
PCI: Unable to handle 64-bit address space for

Is this an expected problem? Is there any reason why the 32-bit kernel
couldn't handle 64-bit bars?

here's what pci config space for our gpu looks like:

00: de 10 ce 00 07 01 10 00 a2 00 00 03 10 00 00 00
10: 00 00 00 de 0c 00 00 f8 0f 00 00 00 04 00 00 dd
20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 43 02
30: 00 00 ee df 60 00 00 00 00 00 00 00 0a 01 00 00

Thanks,
Terence


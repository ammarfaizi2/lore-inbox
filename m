Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267375AbTAOXFs>; Wed, 15 Jan 2003 18:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267377AbTAOXFs>; Wed, 15 Jan 2003 18:05:48 -0500
Received: from [63.170.40.3] ([63.170.40.3]:51399 "EHLO epexch01.qlogic.org")
	by vger.kernel.org with ESMTP id <S267375AbTAOXFr>;
	Wed, 15 Jan 2003 18:05:47 -0500
Date: Wed, 15 Jan 2003 17:23:24 -0600 (CST)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
X-X-Sender: <breti@localhost.localdomain>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Forcing PCI-PCI bridge to have memory resources
Message-ID: <Pine.LNX.4.33.0301151709360.18997-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Jan 2003 23:15:04.0311 (UTC) FILETIME=[EF9C0070:01C2BCEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working with Linux version 2.4.18-xfs with hotswap support.

I'm trying to make a PCI-PCI bridge always have a minimum of 1MB of
memory address space allocated to it. I know that the BIOS we are
using always (correctly, by spec) sets a bridge with no devices behind 
it to disable the memory window. It does this by setting the 
MEM_LIMIT < MEM_BASE.

I've been going through the sources in drivers/pci, trying to figure
out how things are set up. At the time of the pci scan, the resources
are usually initialized (in bci_read_breidge_bases) by doing a read of 
the bridge registers and setting the resource values appropropriately.

For the disabled bridges, the resources are copied from the parent
which in this case results in 0 being set in flags, start and end.

It looks like I will want to call pci_assign_resource(dev, 1); in
order to give it a memory window, but I'm not sure how to initialize
the resources so they are assigned correctly.

Our situation is similiar to what a hotswap CPCI system should encounter
when a hotswap device is inserted behind a previously empty PCI-PCI bridge.

Any help people can give would be greatly appreciated.

-Bret

-- 
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Driver, St 13, Eden Prairie, MN 55346


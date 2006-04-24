Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWDXFyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWDXFyc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 01:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWDXFyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 01:54:32 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:48297 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750819AbWDXFyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 01:54:31 -0400
Date: Mon, 24 Apr 2006 06:54:28 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Reppert <arashi@sacredchao.net>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
In-Reply-To: <20060423222122.498a3dd2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604240652380.31142@skynet.skynet.ie>
References: <1145851361.3375.20.camel@minerva> <20060423222122.498a3dd2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I've been running 2.6.12-rc2-mm3 for a long time.  Recently I upgraded
>> a bunch of OS packages (Debian unstable), so I thought I may as well
>> upgrade the kernel, too.  I've got a dual-head setup driven by a Radeon
>> 9200 and a Radeon 7000.  When I booted 2.6.17-rc2, X never came up; I
>> got "RADEON: Cannot read V_BIOS" and "RADEON: VIdeo BIOS not detected
>> in PCI space!" for the RADEON 7000, and it eventually gets in a loop of
>> spitting out "RADEON: Idle timed out, resetting engine ... " messages
>> in Xorg.log.  Doing a diff of working and broken logs uncovered that the
>> Radeon 7000's PCI ROM resource area had moved from ff8c000 to c6900000.
>> Once I removed the Radeon 7000 screen from the Xorg config, X came up fine
>> on the one head.  Adding stupid amounts of printks to the PCI subsystem in
>> .17-rc2 uncovered that at some point, the ROM area is discovered to be
>> at ff8c0000, but is later reallocated to c6900000.
>>

welcome to X have a nice day :-)

X is horribly horribly broken in this area, if you remove the 
pci_enable_device from drivers/char/drm/drm_stub.c

and restart everything does it still happen?

The problem is that X uses the fact that the pci bars are disabled to 
decide whether to POST the card using the BIOS, however the card isn't 
actually posted but pci_enable_device enables the BARs...

however not doing pci_enable_device causes interrupts to not work on the 
cards in a lot of circumstances..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG


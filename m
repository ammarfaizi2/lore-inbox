Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946647AbWKJN5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946647AbWKJN5c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 08:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946656AbWKJN5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 08:57:32 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:7296 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946647AbWKJN5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 08:57:31 -0500
Message-ID: <455484F0.3000506@garzik.org>
Date: Fri, 10 Nov 2006 08:56:00 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Adrian Bunk <bunk@stusta.de>, Jeff Chua <jeff.chua.linux@gmail.com>,
       Matthew Wilcox <matthew@wil.cx>, Andi Kleen <ak@suse.de>,
       Aaron Durbin <adurbin@google.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [discuss] Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0611080056480.12828@silvia.corp.fedex.com> <20061107171143.GU27140@parisc-linux.org> <200611080839.46670.ak@suse.de> <20061108122237.GF27140@parisc-linux.org> <Pine.LNX.4.64.0611080803280.3667@g5.osdl.org> <20061108172650.GC4729@stusta.de> <Pine.LNX.4.64.0611080932320.3667@g5.osdl.org> <Pine.LNX.4.64.0611080951040.3667@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611080951040.3667@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> We really should stop using MMCONFIG entirely, until we have a 
> per-southbridge true knowledge of what the real decoding is. The BIOS 
> tables for this are simply too damn unreliable.


FWIW:  MMCONFIG is required for PCI domain support (or "PCI segments" as 
ACPI calls them).  Only a few mass market OEM boxes exist that need this 
-- and they are all pretty new (Opteron multi-core) -- but more are coming.

I have a patch in -mm that works for this.  Without the patch, my 
sata_mv card and the machine's built-in MPT-Fusion do not appear at all 
in PCI bus scans (nor do the associated hard drives) on this production 
HP box.  So far these machines are rare, /usually/ with a BIOS switch to 
turn off PCI domains.

This says nothing about BIOS table reliability, of course.  I agree that 
MMCONFIG probing is highly unreliable at present.  Whitelisting "<2007" 
systems like Andi proposed may be the only option in some cases.

	Jeff



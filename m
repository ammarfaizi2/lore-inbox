Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSLMR3c>; Fri, 13 Dec 2002 12:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265187AbSLMR3c>; Fri, 13 Dec 2002 12:29:32 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:59016 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261581AbSLMR3a>;
	Fri, 13 Dec 2002 12:29:30 -0500
Date: Fri, 13 Dec 2002 17:36:56 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Petr Konecny <pekon@informatics.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions)
Message-ID: <20021213173656.GC1633@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Valdis.Kletnieks@vt.edu, Petr Konecny <pekon@informatics.muni.cz>,
	linux-kernel@vger.kernel.org
References: <200212131345.gBDDjw27002677@turing-police.cc.vt.edu> <200212131633.gBDGX0617899@anxur.fi.muni.cz> <200212131718.gBDHIw27008173@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212131718.gBDHIw27008173@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 12:18:58PM -0500, Valdis.Kletnieks@vt.edu wrote:
 > On Fri, 13 Dec 2002 17:33:00 +0100, Petr Konecny <pekon@informatics.muni.cz>  said:
 > > > I see why the if/continue was added - you don't want to be
 > > > calling device_register()/pci_insert_device() if
 > > > pci_enable_device() loses.  I don't see why 2.5.50 moved the
 > > > code up after pci_setup_device(). There's an outside chance
 > > > that the concept of moving the call was correct, but that it
 > > > should have been moved to between the calls to
 > > > pci_assign_resource() and pci_readb().  If that's the case,
 > > > then you're correct as well....
 > > I can confirm that this indeed works. I moved the two lines before
 > > pci_readb and the card works (every character you now read went through
 > > it). Who shall submit a patch to Linus ?
 > 
 > The problem is this from the 2.5.50 Changelog that Linus posted:
 > 
 > Dave Jones <davej@suse.de>:
 > ...
 >   o make cardbus PCI enable earlier
 > 
 > I'm willing to submit a patch, but I think Dave has to make the call whether
 > it should be backed out entirely, or moved after pci_assign_resource().
 > I certainly don't understand the code *or* PCI well enough to decide between
 > those two option...

It's my understanding that pci_enable_device() *must* be called
before we fiddle with dev->resource, dev->irq and the like.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

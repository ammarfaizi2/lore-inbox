Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270644AbUJUCE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270644AbUJUCE7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 22:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270737AbUJUCED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 22:04:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56501 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270644AbUJUCAG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 22:00:06 -0400
Message-ID: <41771813.8090204@pobox.com>
Date: Wed, 20 Oct 2004 21:59:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Linus Torvalds <torvalds@osdl.org>, John Cherry <cherry@osdl.org>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Linux v2.6.9... (compile stats)
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net> <20041019161834.GA23821@one-eyed-alien.net> <1098310286.3381.5.camel@cherrybomb.pdx.osdl.net> <20041020224106.GM23987@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0410201710370.2317@ppc970.osdl.org> <41770307.5060304@pobox.com> <20041021015522.GH23987@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041021015522.GH23987@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Oct 20, 2004 at 08:29:59PM -0400, Jeff Garzik wrote:
> 
>>I still merging stuff, so won't get around to it for another day or so :)
>>
>>I certainly don't mind anyone stealing the task from me, but the effort 
>>is larger than the other iomap conversions.  The patch above hits all 
>>the easily-picked fruit, leaving the stuff that requires a modicum of 
>>effort:
>>
>>* map/unmap N PCI bars (N >= 4, per controller)
>>* map/unmap 2 ISA I/O regions (0x170, 0x1f0)
>>* accurately handle the odd situation where IDE driver steals 0x170 
>>while libata steals 0x1f0 (or vice versa), a.k.a. the reason for 
>>quirk_intel_ide_combined() and the ____request_resource nastiness
>>
>>Currently the code is set up to handle:
>>* N PIO ports
>>	or
>>* a single MMIO address that contains all the registers the driver needs
>>(mmio_base)
> 
> 
> Hmm...  It misses a bunch of easy stuff, actually (tons of casts to void *
> from what used to be unsigned long and is void __iomem * with your patch).

feel free to send a delta :)


> I don't see where you handle PIO stuff, though - no ioport_map() _or_
> pci_iomap() in sight.

Correct, that part doesn't exist yet.  grep in the above quoted text for 
"* map/unap" for the to-do list.

The mapping of the PIO PCI BARs requires independently mapping at least 
5 (but varies from controller to controller) IO port ranges, and 
tracking those mappings in a coherent manner.

	Jeff



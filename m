Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270508AbUJUAm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270508AbUJUAm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270452AbUJUAeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:34:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8879 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270503AbUJUAaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:30:14 -0400
Message-ID: <41770307.5060304@pobox.com>
Date: Wed, 20 Oct 2004 20:29:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John Cherry <cherry@osdl.org>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Linux v2.6.9... (compile stats)
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net> <20041019161834.GA23821@one-eyed-alien.net> <1098310286.3381.5.camel@cherrybomb.pdx.osdl.net> <20041020224106.GM23987@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0410201710370.2317@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410201710370.2317@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 20 Oct 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
>>>   drivers/scsi/pcmcia: 3 warnings, 0 errors
>>>   drivers/scsi: 148 warnings, 0 errors
>>
>>Mostly dealt with, but I'm still messing with SATA parts.
> 
> 
> Jeff had SATA patches - it needs to use the new iomap interfaces, and then
> it's much cleaner. I tested that his patches worked for me several weeks
> ago, but nor all architectures had the iomap interface, so I assume Jeff
> wasn't very eager to push it out.
> 
> Anyway, Al, talk to Jeff. Jeff?


Current patch is at
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/patch.iomap.bz2

I still merging stuff, so won't get around to it for another day or so :)

I certainly don't mind anyone stealing the task from me, but the effort 
is larger than the other iomap conversions.  The patch above hits all 
the easily-picked fruit, leaving the stuff that requires a modicum of 
effort:

* map/unmap N PCI bars (N >= 4, per controller)
* map/unmap 2 ISA I/O regions (0x170, 0x1f0)
* accurately handle the odd situation where IDE driver steals 0x170 
while libata steals 0x1f0 (or vice versa), a.k.a. the reason for 
quirk_intel_ide_combined() and the ____request_resource nastiness

Currently the code is set up to handle:
* N PIO ports
	or
* a single MMIO address that contains all the registers the driver needs
(mmio_base)



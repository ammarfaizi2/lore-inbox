Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVDPW5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVDPW5o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 18:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVDPW5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 18:57:43 -0400
Received: from mail1.skjellin.no ([80.239.42.67]:2692 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S261180AbVDPW5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 18:57:37 -0400
Message-ID: <4261985C.5030008@tomt.net>
Date: Sun, 17 Apr 2005 00:57:32 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Matt M. Valites" <mval@axium.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Poor  I/O Performance with MegaRaid SATA 150-4; bug or feature?
References: <42614CAF.50606@axium.net>
In-Reply-To: <42614CAF.50606@axium.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt M. Valites wrote:
> Hail List,
> 
> I've been banging my head against this for a few days, and I wanted to
> see if anyone here could lend a hand.
> 
> I have the following configuration:
> P4 3.x Ghz
> 2GB Ram;
> 2 x 36GB WD Raptors; in a RAID1 (sda)
> 2 x 74GB WD Raptor (those 10K RPM SATA drives) in a RAID1(sdb)
> Two free PCI-X slots, one of which occupied by a LSI MegaRaid SATA 150-4.
> 
> The problem is I/O on either one of these RAID devices seems to
> be less than half what I'm expecting.   The file system used in my testing is
> XFS, and I'm running kernel 2.6.11.6.
> 
> The test I'm doing is a simple:
> # time dd if=/dev/zero of=./crap.file bs=1024 count=209715
> Which results in a runtime of about ~53s, in the best case, with all the
> scary write cache enabled.    I've tried with deadline, and
> anticipatory.  I've also tried several kernels, namely a recent 2.4, so
> I could test megaraid and megaraid2, similar results.
> 
> On my desktop box, with one of these drives connected via SATA, i get
> ~25s, also XFS.  (2.6.11-gentoo-r6 x86_64).
> 
> Is this an expected result?  I'm seeing much higher numbers posted around the
> 'Net.  Most of those results are from Windows boxes.
> 
> I've uploaded my kernel config, lspci -v, and two opreports of a bonnie++ run
> to: http://www.muixa.com/lkml/

I also have one of those cards, at home. I've come to the conclusion 
that they're just too old. No NCQ and such other fancy features (for 
gods sake, the controllers on the card are sil 3112's!). It's probably 
not even PCI-X native.

The only thing that can bring its performance reseanably up to speed is 
using write-back instead of write-through on the array. Also try 
enabling the write-cache on the drives (all doable in the cards bios 
config, not sure if this is what you meant with "with all the scary 
write cache enabled"). Doing this is on the other hand not very good for 
your data integrity, not good at all.

If only NCQ/TCQ was in, it would have a chance of having decent 
performance using write-through. A cool experiment would be setting up 
the drives as invidual drives on the card, and use md software raid over it.

Next time I'll probably just use md software raid over a 3ware 9xxx 
(JBOD-mode) or AHCI controller. I'm feeling quite uneasy about vendor 
lock in nowadays. Groan.

-- 
Cheers,
André Tomt

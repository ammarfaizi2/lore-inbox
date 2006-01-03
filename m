Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWACSsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWACSsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWACSsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:48:47 -0500
Received: from [81.2.110.250] ([81.2.110.250]:31676 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932476AbWACSsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:48:46 -0500
Subject: Re: [git patches] 2.6.x libata updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0601031035x89bd6cbw1e1efb3f7a93bb41@mail.gmail.com>
References: <20060103164319.GA402@havoc.gtf.org>
	 <58cb370e0601030851w62fc917bibe0fd5069b2f3e44@mail.gmail.com>
	 <1136309555.22598.10.camel@localhost.localdomain>
	 <43BAB7D4.4050204@pobox.com>
	 <58cb370e0601031035x89bd6cbw1e1efb3f7a93bb41@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Jan 2006 18:50:29 +0000
Message-Id: <1136314229.22598.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-03 at 19:35 +0100, Bartlomiej Zolnierkiewicz wrote:
> > Not really.  If there's no support in mainline, I'm ok with pushing them
> > upstream...  provided that they have been tested and verified to work on
> > at least one machine?  :)
> 
> All chipsets are supported by piix.c driver but:

No they are not. The drivers claim the PCI identifiers but that is not
the same thing as working.

> * we depend on BIOS to program correct PIO timings and set drives
>   (mpiix chipset)

It doesn't work except for PIO0. I've tested it on a thinkpad.

> * PIO tuning code is buggy and needs fixing (oldpiix chipsets)

It crashes. I've tested it.

> I don't think that this alone justify adding new drivers instead of fixing
> old one as both issues can be fixed quite easily by almost cut'n'pasting
> new tuning code from Alan's drivers and adding it to piix.c.

Hardly. The existing PIIX drivers in drivers/ide/pci are *very* buggy.
Some of the bugs are careless but alarming like scribbles to wrong PCI
registers and easily fixed. Others like the mishandling of fifos are
corruptors that thankfully aren't biting writable media. The handling of
pre SITRE capable chipsets in the current driver is broken to the point
it needs a rewrite that quite frankly I don't think can be done without
fixing the locking in the core code.

Please spend your effort improving the ide/pci drivers rather than
trying to block their future replacement with better technology. I've
posted detailed summaries of flaws in several chipsets but no fixes have
appeared.

Alan


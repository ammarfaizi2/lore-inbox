Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422693AbWAMOVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422693AbWAMOVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 09:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWAMOVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 09:21:33 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6021 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422690AbWAMOVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 09:21:32 -0500
Subject: Re: Fwd: ide-cd turning off DMA when verifying DVD-R
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
       Ondrej Zary <linux@rainbow-software.org>,
       Robert Hancock <hancockr@shaw.ca>,
       Volker Kuhlmann <list0570@paradise.net.nz>, Jens Axboe <axboe@suse.de>,
       linux-ide <linux-ide@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e0601130533n5842cb5fufc5058f9a1acc606@mail.gmail.com>
References: <5ujmU-1UQ-665@gated-at.bofh.it> <5uoqr-Qq-7@gated-at.bofh.it>
	 <43C72F41.5060207@shaw.ca> <20060113083009.GE12338@paradise.net.nz>
	 <58cb370e0601130119g5c62b749r1bc5da59a0d4a56c@mail.gmail.com>
	 <58cb370e0601130121s2f6c0a26jda00ff64df197342@mail.gmail.com>
	 <20060113093818.GA22984@sci.fi>
	 <58cb370e0601130149g32323b4axbf0ac55f83ac9148@mail.gmail.com>
	 <20060113112510.GA23264@sci.fi>
	 <58cb370e0601130533n5842cb5fufc5058f9a1acc606@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Jan 2006 14:24:25 +0000
Message-Id: <1137162265.4419.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-13 at 14:33 +0100, Bartlomiej Zolnierkiewicz wrote:
> The patch was NACK-ed by Alan Cox and I agree with him (this should be
> done differently).  This __ide_dma_off() chunk looks sensible but does it fix
> the issue?  I was under impression that after a reset drive looses its DMA
> xfer mode and needs to be reprogrammed (ATA spec has the answer).

Yes and the behaviour is determined by hdparm -k/-K. Its all a bit
random after a CRC error however as the recovery code does a polling
speed change and the locking versus timers/irq's is totally broken.

I did some minimal fixes in the older -ac patches but even with all the
other locking cleanup I did back then this one remained. Essentially the
old IDE layer needs to switch from polled speed changes in task context
to issuing speed changes as state machine sequences.

Thats non trivial

Alan


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285630AbRLRGeo>; Tue, 18 Dec 2001 01:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285629AbRLRGee>; Tue, 18 Dec 2001 01:34:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29957 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285630AbRLRGeX>;
	Tue, 18 Dec 2001 01:34:23 -0500
Message-ID: <3C1EE36C.AB4B9F7F@mandrakesoft.com>
Date: Tue, 18 Dec 2001 01:34:20 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112172153410.2416-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Jeff, you've worked on the sb code at some point - does it really do
> 32-byte sound fragments? Why? That sounds truly insane if I really parsed
> that code correctly. That's thousands of separate DMA transfers
> and interrupts per second..

I do not see a hardware minimum fragment size in the HW docs...  The
default hardware reset frag size is 2048 bytes.  So, yes, 32 bytes is
pretty small for today's rate.

But... I wonder if the fault lies more with the application setting a
too-small fragment size and the driver actually allows it to do so, or,
the code following this comment in reorganize_buffers in
drivers/sound/audio.c needs to be revisited:
   /* Compute the fragment size using the default algorithm */

Remember this code is from ancient times...  probably written way before
44 Khz was common at all.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

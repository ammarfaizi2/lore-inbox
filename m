Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313313AbSDGNeq>; Sun, 7 Apr 2002 09:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313318AbSDGNep>; Sun, 7 Apr 2002 09:34:45 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:3080 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313313AbSDGNeo>; Sun, 7 Apr 2002 09:34:44 -0400
Date: Sun, 7 Apr 2002 14:34:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.8-pre2
Message-ID: <20020407143437.F30048@flint.arm.linux.org.uk>
In-Reply-To: <20020407112716.A30048@flint.arm.linux.org.uk> <Pine.GSO.4.21.0204071239310.2567-100000@lisianthus.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 12:42:45PM +0200, Geert Uytterhoeven wrote:
> On Sun, 7 Apr 2002, Russell King wrote:
> > On Sun, Apr 07, 2002 at 12:17:28PM +0200, Geert Uytterhoeven wrote:
> > > Please either add resource management code to anakinfb and clps711xfb,
> > > or apply the patch below.
> > 
> > They're not ISA nor PCI - in fact, they're specific system-on-a-chip
> > framebuffers.  I therefore don't see the point of your patch.
> 
> Even then, please don't add them to the section marked with the comment
> `Chipset specific drivers that use resource management'. My patch just moves
> their initialization to the section marked with the comment `Chipset specific
> drivers that don't use resource management (yet)'. So it's still valid.

Ok, I agree the clps711x can be moved.  As for Anakin, that's up to the
anakin people to sort out - I've mailed them directly.  There's a bunch
of other stuff in there as well that needs to be fixed up.

> > (Oh, and a bugbear - people go running around adding checks for the
> > return value of request_region and friends on embedded devices where
> > there can't be the possibility of a clash waste memory needlessly.)
> 
> Perhaps you want to modularize the driver later? Resource management also
> prevents you from insmoding two drivers for the same hardware.

Point 1: You can't perform resource management on the System RAM since
 they're already claimed.
Point 2: You can't perform resource management on bits in a control
 register that performs many other random functions; resource management
 is byte based not bit based.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


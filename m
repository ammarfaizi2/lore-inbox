Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264142AbRFNWuI>; Thu, 14 Jun 2001 18:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264146AbRFNWt6>; Thu, 14 Jun 2001 18:49:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56244 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264142AbRFNWtv>;
	Thu, 14 Jun 2001 18:49:51 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.16268.239882.904451@pizda.ninka.net>
Date: Thu, 14 Jun 2001 15:49:48 -0700 (PDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <20010614222901.13715@smtp.wanadoo.fr>
In-Reply-To: <15145.14057.67940.752173@pizda.ninka.net>
	<20010614222901.13715@smtp.wanadoo.fr>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt writes:
 > Well... that would work for VGA itself (note that this semaphore
 > you are talking about should be shared some way with the /proc
 > interface so XFree can be properly sync'ed as well).

Once XFree takes ownership of the VC it has control of all the
graphics cards in the system.  It does this before it does any poking
around.

 > But I still think it may be useful to generalize the idea to 
 > all kind of legacy IO & PIOs. I definitely agree that VGA is a kind
 > of special case, mostly because of the necessary exclusion on
 > the VGA IO response.

I don't think this is the way to go.

First, what would you use it for?  Let's check some examples:

1) "legacy serial on Super I/O"

   This is best handled by a asm/serial.h mechanism, something akin
   to how asm/floppy.h works.  Let the platform say how to get at
   the ports.

   Wait, there already is a asm/serial.h that does just this :-)

2) "floppy"

   See asm/floppy.h :-)

3) "PS/2 keyboard and mouse"

   I believe there is an asm/keyboard.h for the keyboard side of this.
   Yes, and it has macros for the register accesses.

4) "legacy keyboard beeper"

   Make an asm/kbdbeep.h or something.

Add whatever else you might be interested that things tend to
inb/outb.

And if your concern is having multiple of these in your system, the
only ones that make sense are floppy and serial and those are handled
just fine by the asm/serial.h mechanism.

This way of doing this allows 16550's, floppies, etc. to be handled on
any bus whatsoever.

I mean, besides this and VGA what is left and even matters?

Later,
David S. Miller
davem@redhat.com


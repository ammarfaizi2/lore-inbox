Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129867AbQKWSv5>; Thu, 23 Nov 2000 13:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129097AbQKWSvr>; Thu, 23 Nov 2000 13:51:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19470 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129568AbQKWSvk>;
        Thu, 23 Nov 2000 13:51:40 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011230753.eAN7rOt14124@flint.arm.linux.org.uk>
Subject: Re: silly [< >] and other excess
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Thu, 23 Nov 2000 07:53:24 +0000 (GMT)
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <200011230254.eAN2sm9158656@saturn.cs.uml.edu> from "Albert D. Cahalan" at Nov 22, 2000 09:54:48 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:
> > they are not only references to
> > kernel functions, but also kernel data and read only data within
> > the kernel text segment.
> 
> 1. this is harmless
> 2. this is useful (you might get a variable's name)

Wrong.  Op-codes on this machine are organised such that bits 31-28
indicate the "condition" that the instruction executes.  All 16
combinations are meaningful.  This means that any 32-bit value can
appear to be an instruction OR data.  It takes human intellect to
decide which it is.  No machine can tell you that.

> Nope. You get the unmolested oops and some symbol data.
> If there isn't any symbol for 0x424a5149, so what? It is
> no big deal to look up a few opcodes in the symbol table
> by accident.

But there could well be a symbol for 0xc0023004, but it also
corresponds to the instruction:

	andgt   r3, r2, r4

"Perform a logical AND operation between r2 and r4 and place the result
 in r3 if the condition codes indicate the `Greater Than' condition"

In addition, the kernel may not be compiled to run at address 0xC.......
but at address 0x6....... or maybe even 0xe.......  Guess what 0xE means
in the high nibble of the op-code?  "Always", or "Unconditional".

> That would be trading one design flaw for another.
> 
> The hard part of klogd/ksymoops is decoding the code bytes AFAIK.
> The rest is a just a cross between grep and ps -- you search and
> you do symbol lookups. I could throw it together in a few hours,
> minus the disassembly part.

As far as I am concerned, you are the people who propose to break
something, and therefore you are the people who should provide the
effort to fix what you will be breaking when the brokenness is
highlighted.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

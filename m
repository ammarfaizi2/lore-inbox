Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130606AbQK2KRT>; Wed, 29 Nov 2000 05:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130866AbQK2KRJ>; Wed, 29 Nov 2000 05:17:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53514 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S130606AbQK2KQz>;
        Wed, 29 Nov 2000 05:16:55 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011290725.eAT7PpC03867@flint.arm.linux.org.uk>
Subject: Re: [PATCH] removal of "static foo = 0"
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Wed, 29 Nov 2000 07:25:51 +0000 (GMT)
Cc: aeb@veritas.com (Andries Brouwer), linux-kernel@vger.kernel.org
In-Reply-To: <200011290146.eAT1khL116131@saturn.cs.uml.edu> from "Albert D. Cahalan" at Nov 28, 2000 08:46:43 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:
> Oh, bullshit. We break the C standard left and right already.
> This is the kernel, and the kernel can initialize BSS any damn
> way it feels like initializing it. The kernel isn't ever going
> to be standard C.
> 
> Choosing an initializer that tends to catch unintended reliance
> on zeroed data would be good. Too bad it is too late to fix.

Its not me talking bullshit here, its you.  It is totally reasonable
to rely on:

  static int foo;

to be zero.  If it is not, that is a bug in the C startup code.  No
two ways about it.  If someone then says "I want to initialise the
BSS to some magic value to catch this reliance" then we are breaking
a lot of peoples expectations.  (Least Surprise theory)

To say again, relying on foo to be zero is not a bug.

If you set the BSS to something non-zero, we already know that a lot
will break.  But it will break because someone has broken the BSS
initialisation code, not because it is relying on something that is
expected to be standard.  By setting the BSS to something non-zero,
you're not telling anyone anything new.  About the only response
will be "fix the BSS initialisation".

If you want to try this, then that is up to you.  Don't let us
stop you.  However, don't expect people to accept patches to
"fix" your self-created problem.

I look forward to your complaints about the disk subsystems,
keyboard, console, and so forth apparantly being broken.
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

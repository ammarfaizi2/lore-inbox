Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129632AbQK0X2o>; Mon, 27 Nov 2000 18:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129639AbQK0X2e>; Mon, 27 Nov 2000 18:28:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48389 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129632AbQK0X2V>;
        Mon, 27 Nov 2000 18:28:21 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011272257.eARMvw302186@flint.arm.linux.org.uk>
Subject: Re: [PATCH] removal of "static foo = 0"
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Mon, 27 Nov 2000 22:57:57 +0000 (GMT)
Cc: aeb@veritas.com (Andries Brouwer), linux-kernel@vger.kernel.org
In-Reply-To: <200011272033.eARKXgr497038@saturn.cs.uml.edu> from "Albert D. Cahalan" at Nov 27, 2000 03:33:42 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:
> It is too late to fix things now. It would have been good to
> have the compiler put explicitly zeroed data in a segment that
> isn't shared with non-zero or uninitialized data, so that the
> uninitialized data could be set to 0xfff00fff to catch bugs.
> It would take much effort over many years to make that work.

Oh dear, here's that misconception again.

static int a;

isn't a bug.  It is not "uninitialised data".  It is defined to be
zero.  Setting the BSS of any C program to contain non-zero data will
break it.  Fact.  The only bug you'll find is the fact that you're
breaking the C standard.

There is only two places where you come across uninitialised data:

1. memory obtained from outside text, data, bss limit of the program
   (ie, malloced memory)
2. if you use auto variables which may be allocated on the stack

All variables declared at top-level are initialised.  No questions
asked.  And its not a bug to rely on such a fact.
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

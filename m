Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130664AbQKYMfU>; Sat, 25 Nov 2000 07:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129437AbQKYMfL>; Sat, 25 Nov 2000 07:35:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19721 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129183AbQKYMez>;
        Sat, 25 Nov 2000 07:34:55 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011251201.eAPC1nR19046@flint.arm.linux.org.uk>
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
To: jamagallon@able.es
Date: Sat, 25 Nov 2000 12:01:48 +0000 (GMT)
Cc: rusty@linuxcare.com.au (Rusty Russell), linux-kernel@vger.kernel.org
In-Reply-To: <20001125001351.A1342@werewolf.able.es> from "J . A . Magallon" at Nov 25, 2000 12:13:51 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J . A . Magallon writes:
> ANSI rules for C say that uninitialized vars get a 0, but you can't trust
> on the ANSI behaviour of a compiler.

It has nothing to do with the compiler, but everything to do with the
C startup code.  In the Linux kernel, we have complete control over the
C startup code - it is in arch/*/kernel/head.S.

The only way a compiler can break this is if it creates a new section
.bss_im_not_going_to_allow_anyone_to_initialise_this and places all
the variables in there.  Hardly likely, don't you think?

The initialisation of .bss is a run-time issue, NOT a compiler issue.
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

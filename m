Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129437AbQKYMfU>; Sat, 25 Nov 2000 07:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130604AbQKYMfK>; Sat, 25 Nov 2000 07:35:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20233 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129437AbQKYMe5>;
        Sat, 25 Nov 2000 07:34:57 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011251150.eAPBoLQ19031@flint.arm.linux.org.uk>
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
To: rusty@linuxcare.com.au (Rusty Russell)
Date: Sat, 25 Nov 2000 11:50:20 +0000 (GMT)
Cc: tigran@veritas.com (Tigran Aivazian), linux-kernel@vger.kernel.org
In-Reply-To: <20001123110203.EB8A8813D@halfway.linuxcare.com.au> from "Rusty Russell" at Nov 23, 2000 10:01:53 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:
> What irritates about these monkey-see-monkey-do patches is that if I
> initialize a variable to NULL, it's because my code actually relies on
> it; I don't want that information eliminated.

What information is lost?  Unless you're working on a really strange
machine which does not zero bss, the following means the same from the
codes point of view:

static int foo = 0;
static int foo;

Both are initialised to zero by the time the code sees them for the
first time.  Therefore there is no difference to the code in its reliance
on whether foo is zero.  foo will be zero in both cases.

Also, any good programmer worth their skin should know this, and should
realise it.  Therefore, there is no information loss about what value
that variable is expected to hold at initialisation time.

The only difference is the size on disk; if we go around setting every
bss variable to zero, the kernel/module data size will unnecessarily
huge.

We already argue about the extra couple of bytes that xx change to the
kernel/a module would cost.  With these change, we save kilo-bytes in
disk space (which is important on some systems).
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129742AbQK2CRX>; Tue, 28 Nov 2000 21:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129933AbQK2CRN>; Tue, 28 Nov 2000 21:17:13 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:47108 "EHLO saturn.cs.uml.edu")
        by vger.kernel.org with ESMTP id <S129742AbQK2CRF>;
        Tue, 28 Nov 2000 21:17:05 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011290146.eAT1khL116131@saturn.cs.uml.edu>
Subject: Re: [PATCH] removal of "static foo = 0"
To: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 28 Nov 2000 20:46:43 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), aeb@veritas.com (Andries Brouwer),
        linux-kernel@vger.kernel.org
In-Reply-To: <200011272257.eARMvw302186@flint.arm.linux.org.uk> from "Russell King" at Nov 27, 2000 10:57:57 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> Albert D. Cahalan writes:

>> It is too late to fix things now. It would have been good to
>> have the compiler put explicitly zeroed data in a segment that
>> isn't shared with non-zero or uninitialized data, so that the
>> uninitialized data could be set to 0xfff00fff to catch bugs.
>> It would take much effort over many years to make that work.
>
> Oh dear, here's that misconception again.
>
> static int a;
>
> isn't a bug.

Alone, it is not.

> It is not "uninitialised data".  It is defined to be
> zero.  Setting the BSS of any C program to contain non-zero data will
> break it.  Fact.  The only bug you'll find is the fact that you're
> breaking the C standard.

Oh, bullshit. We break the C standard left and right already.
This is the kernel, and the kernel can initialize BSS any damn
way it feels like initializing it. The kernel isn't ever going
to be standard C.

Choosing an initializer that tends to catch unintended reliance
on zeroed data would be good. Too bad it is too late to fix.

> All variables declared at top-level are initialised.  No questions
> asked.  And its not a bug to rely on such a fact.

Go back and read the rest of this thread. Examples have been
provided (not by me) of such code leading to latter mistakes.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129529AbQKWDZL>; Wed, 22 Nov 2000 22:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132406AbQKWDZD>; Wed, 22 Nov 2000 22:25:03 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:32012 "EHLO saturn.cs.uml.edu")
        by vger.kernel.org with ESMTP id <S129529AbQKWDYw>;
        Wed, 22 Nov 2000 22:24:52 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011230254.eAN2sm9158656@saturn.cs.uml.edu>
Subject: Re: silly [< >] and other excess
To: rmk@arm.linux.org.uk (Russell King)
Date: Wed, 22 Nov 2000 21:54:48 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
In-Reply-To: <200011230010.AAA02797@raistlin.arm.linux.org.uk> from "Russell King" at Nov 23, 2000 12:10:03 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> Albert D. Cahalan writes:

>> All these numbers get looked up.
>
> These numbers should NOT get looked up - if they are, then very
> useful information will be lost;

WOAH, STOP!!!  You say "lost"???

Under NO circumstances should klogd or ksymoops mangle the
original oops. The raw oops data MUST be completely preserved.
It is a serious bug that this is not what currently happens.

> they are not only references to
> kernel functions, but also kernel data and read only data within
> the kernel text segment.

1. this is harmless
2. this is useful (you might get a variable's name)

> The result will be a totally undeciperal
> garbage.

Nope. You get the unmolested oops and some symbol data.
If there isn't any symbol for 0x424a5149, so what? It is
no big deal to look up a few opcodes in the symbol table
by accident.

> Again, care to put the effort into klogd/ksymoops to handle the
> architecture special cases?

That would be trading one design flaw for another.

The hard part of klogd/ksymoops is decoding the code bytes AFAIK.
The rest is a just a cross between grep and ps -- you search and
you do symbol lookups. I could throw it together in a few hours,
minus the disassembly part.

Hey, anybody ever think about splitting the kernel message buffer
to be per-CPU or keeping interrupt context separate from process
context? Not that I've looked at it, but locking might be reduced.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

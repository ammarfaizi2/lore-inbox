Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154692AbPKLRet>; Fri, 12 Nov 1999 12:34:49 -0500
Received: by vger.rutgers.edu id <S154458AbPKLRed>; Fri, 12 Nov 1999 12:34:33 -0500
Received: from dukat.scot.redhat.com ([195.89.149.246]:1456 "EHLO dukat.scot.redhat.com") by vger.rutgers.edu with ESMTP id <S154273AbPKLReT>; Fri, 12 Nov 1999 12:34:19 -0500
From: "Stephen C. Tweedie" <sct@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14380.20335.320349.368261@dukat.scot.redhat.com>
Date: Fri, 12 Nov 1999 17:33:35 +0000 (GMT)
To: Ingo Molnar <mingo@chiara.csoma.elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.rutgers.edu, "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <number6@the-village.bc.nu>
Subject: Re: [patch] zoned-2.3.27-E0
In-Reply-To: <Pine.LNX.4.10.9911121502120.7240-200000@chiara.csoma.elte.hu>
References: <Pine.LNX.4.10.9911121502120.7240-200000@chiara.csoma.elte.hu>
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

On Fri, 12 Nov 1999 15:02:31 +0100 (CET), Ingo Molnar
<mingo@chiara.csoma.elte.hu> said:

> Stephen noticed that 2.3.27 doesnt boot on <=16MB boxes due to the zoned
> allocator changes. The attached patch should fix this. Unfortunately i
> found no way to prevent introducing the runtime 'nr_zones' variable.

A quick special-case check on zones known to be empty would allow you to
maintain performance even if you have zones which will never have any
pages in them on a given machine.

You need this anyway --- Alan pointed out that it is a significant hit
on benchmarks if, during normal running, one zone fills up and you start
falling back routinely to a lower zone.

--Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

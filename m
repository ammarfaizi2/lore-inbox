Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313179AbSERPjD>; Sat, 18 May 2002 11:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313184AbSERPjC>; Sat, 18 May 2002 11:39:02 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:54796 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S313179AbSERPjB>; Sat, 18 May 2002 11:39:01 -0400
Date: Sat, 18 May 2002 17:38:57 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Marcus Alanen <marcus@infa.abo.fi>
Cc: szepe@pinerecords.com, Russell King <rmk@arm.linux.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Subject: Re: Linux-2.5.16
Message-ID: <20020518153856.GA8171@merlin.emma.line.org>
Mail-Followup-To: Marcus Alanen <marcus@infa.abo.fi>,
	szepe@pinerecords.com, Russell King <rmk@arm.linux.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0205180051100.3170-100000@penguin.transmeta.com> <20020518092121.A30509@flint.arm.linux.org.uk> <20020518092121.A30509@flint.arm.linux.org.uk> <20020518095125.GC10134@louise.pinerecords.com> <200205181128.OAA26251@infa.abo.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2002, Marcus Alanen wrote:

> I guess it still is "$_ =~ s/\[?PATCH\]?\s*//i;", which means
> that it still is broken. There certainly are several solutions,
> what do people think of "s/\[?[^\]]*PATCH\]?\W*//i;" ?
> (Maybe a ^ at the beginning?) 

Don't guess, look:

    # kill "PATCH" tag
    s/^\s*\[PATCH\]//;
    s/^\s*PATCH//;
    s/^\s*[-:]+\s*//;
    # strip trailing colon
    s/:\s*$//;
    # kill leading and trailing whitespace for consistent indentation
    s/^\s+//; s/\s+$//;

So it should not harm "[ARM PATCH]".

What we would want is only remove the tag when we have symmetric square
brackets. What we also want is simplicity to allow for easy maintenance
and, last but not least, simple, anchored regexps for speed.

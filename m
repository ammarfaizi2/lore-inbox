Return-Path: <linux-kernel-owner+w=401wt.eu-S932629AbXAJGZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbXAJGZr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 01:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbXAJGZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 01:25:47 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:32950 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932629AbXAJGZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 01:25:46 -0500
X-Originating-Ip: 74.109.98.176
Date: Wed, 10 Jan 2007 01:20:31 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: macros:  "do-while" versus "({ })" and a compile-time error
In-Reply-To: <Pine.LNX.4.61.0701091415200.12545@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0701100116420.10133@localhost.localdomain>
References: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain>
 <45A3D1DF.4020205@s5r6.in-berlin.de> <Pine.LNX.4.61.0701091415200.12545@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007, linux-os (Dick Johnson) wrote:

>
> On Tue, 9 Jan 2007, Stefan Richter wrote:
>
> > Robert P. J. Day wrote:
> >>   just to stir the pot a bit regarding the discussion of the two
> >> different ways to define macros,
> >
> > You mean function-like macros, right?
> >
> >> i've just noticed that the "({ })"
> >> notation is not universally acceptable.  i've seen examples where
> >> using that notation causes gcc to produce:
> >>
> >>   error: braced-group within expression allowed only inside a function
> >
> > And function calls and macros which expand to "do { expr; } while (0)"
> > won't work anywhere outside of functions either.
> >
> >> i wasn't aware that there were limits on this notation.  can someone
> >> clarify this?  under what circumstances *can't* you use that notation?
> >> thanks.
> >
> > The limitations are certainly highly compiler-specific.
>
> I don't think so. You certainly couldn't write working 'C' code like
> this:
>
>  	do { a = 1; } while(0);
>
> This _needs_ to be inside a function. In fact any runtime operations
> need to be inside functions. It's only in assembly that you could
> 'roll your own' code like:
>
> main:
>  	ret 0
>
>
> Most of these errors come about as a result of changes where a macro
> used to define a constant. Later on, it was no longer a constant in
> code that didn't actually get compiled during the testing.

just FYI, the reason i brought this up in the first place is that i
noticed that the ALIGN() macro in kernel.h didn't verify that the
alignment value was a power of 2, so i thought -- hmmm, i wonder if
there are any invocations where that's not true, so i (temporarily)
rewrote ALIGN to incorporate that check, and the build blew up
including include/net/neighbour.h, which contains the out-of-function
declaration:

struct neighbour
{
        ...
        unsigned char           ha[ALIGN(MAX_ADDR_LEN, sizeof(unsigned long))];
        ...

so it's not a big deal, it was just me goofing around and breaking
things.

rday

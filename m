Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160036-215>; Tue, 16 Mar 1999 23:02:37 -0500
Received: by vger.rutgers.edu id <160149-215>; Tue, 16 Mar 1999 23:02:21 -0500
Received: from feral.com ([192.67.166.1]:12359 "EHLO feral.com" ident: "mjacob") by vger.rutgers.edu with ESMTP id <157471-212>; Tue, 16 Mar 1999 22:58:39 -0500
Date: Tue, 16 Mar 1999 19:58:26 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: David Hinds <dhinds@zen.stanford.edu>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: Ideas for abstracting driver IO from bus implementation?
In-Reply-To: <19990316194144.45898@zen.stanford.edu>
Message-ID: <Pine.LNX.4.04.9903161949380.12815-100000@feral-gw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


>Solaris has an equivalent sort of abstraction layer, where you make a DDI
>call to indirectly access any device register.  I'm wondering if such an
>abstraction layer would be of any use for other types of Linux drivers,
>and if so, how I should design my API to make it as broadly useful as
>possible.

And as Larry McVoy will tell you- he thought that for the Solaris DDI/DKI
we went *way* overboard on this. It isn't even just the indirect register
access, but the whole notion of hierarchies of busses and their
interrelations for both CPU access to devices and DMA accesses to memory
and/or other devices. This really went to town, and cost performance
bigtime. I suspect that if this were done now though the performance could
have been mostly bought back changes in compiler technology since then.

*BSD has a rather nice intermediate approach to this. It doesn't require a
tree hierarchy for devices (which has the the nice property of giving a
digraph for bursts and widths), nor does it really treat DMA precisely
within the same framework, but does encapsulate relatively nicely the
notion that any particular device should be accessed via some sort of
bus_space_WIDTH type of function/macro. Linux sort of has this already in
that each platform has it's own {in,out}foo functions- but that's a bit
limited as you point out (it requires there be no more than one system IO
bustype).

To answer your question above- yes, I could see it being of general use-
it might make drivers a bit easier to share with really wierd
architectures if the access abstraction is simple but strong.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUKEPhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUKEPhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 10:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbUKEPhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 10:37:11 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:45576 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261647AbUKEPgv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 10:36:51 -0500
To: "Clayton Weaver" <cgweav@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: support of older compilers
References: <20041104193349.9DE511F50B1@ws1-2.us4.outblaze.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: if SIGINT doesn't work, try a tranquilizer.
Date: Fri, 05 Nov 2004 15:36:43 +0000
In-Reply-To: <20041104193349.9DE511F50B1@ws1-2.us4.outblaze.com> (Clayton
 Weaver's message of "4 Nov 2004 20:03:05 -0000")
Message-ID: <87is8k71f8.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Nov 2004, Clayton Weaver stated:
> I found that none of the gcc 3.x versions could
> correctly compile a construct like this
> (independent of runtime glibc version):
> 
> file1.h:
> 
> /* header boilerplate to avoid multiple #includes of
>    the same file */
> 
> #define STR1  "string 1"
> 
> file2.c:
> 
> #include "file1.h"
> 
> const char * str2 = "whatever"STR1"stuff this\n\
> string has in it"STR1" and so on ad infinitum\n\
> "STR1"yada yada"; 
> 
> /* this was actually about 40 lines, maybe more,
>    with maybe 10 instances of "../"STR1"..." */
> 
> All of the gcc-3.x versions would bail with
> an error trying to compile that str2 definition
> in file2.c.

And do I see any bug reports from you in GCC bugzilla?  I do not (not
under the name `Clayton Weaver', anyway).

Further, the code you provide works in all the GCC-3.x versions I've got
here.

If you don't even *report* the bug, how can you expect it to get fixed?

> They didn't always fail on literal string
> concatenation (IIRC some short ones compiled
> ok), but they consistently failed to concatenate
> literal strings correctly for some source
> files that gcc-2.95.3 would compile correctly
> every time.

The preprocessor was totally rewritten between GCC-2.95.x and GCC-3.x: a
number of things that were valid in 2.95.x but invalid under ISO C were
made to not work in 3.x (for example, the compiler warns about attempts
to concatenate two things with ## that aren't preprocessing tokens, and
eventually this was made a hard error, IIRC).

This is, of course, not a bug.

I can find no mention of string concatenation bugs against the new
preprocessor relating to anything other than token pasting (and all of
those bugs are people trying to token-paste things that aren't tokens,
generally strings).

> (The glibc trees had distributor patches, so I filed
> the bug report via their support

What? You found a compiler bug, so you reported it as a bug against
glibc?

> In sum: for production code it doesn't matter
> what all a new C compiler version can do that
> the old one could not if it won't compile
> quite ordinary standard C correctly.

... especially if the people who see the problems don't report them and
don't provide reproducible testcases.

> It would be good to have bugs fixed in the new compilers,

It would be good if people would report bugs in the new compilers. :)

>                                                           because they
> obviously have some advantages (I noticed that gcc-3.4.x seemed quite
> a bit faster than 2.95.3 when compiling glibc,

It is quite a bit slower :(

-- 
`Preliminary analysis reveal there are few impact craters on Titan. This
 suggests Cassini has an active surface constantly being resurfaced.'
              --- BBC News Online introduces a new planetary body

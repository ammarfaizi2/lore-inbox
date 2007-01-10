Return-Path: <linux-kernel-owner+w=401wt.eu-S965127AbXAJVts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbXAJVts (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbXAJVts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:49:48 -0500
Received: from smtp.ono.com ([62.42.230.12]:56422 "EHLO resmaa02.ono.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965127AbXAJVtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:49:47 -0500
Date: Wed, 10 Jan 2007 22:49:22 +0100
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: macros:  "do-while" versus "({ })" and a compile-time error
Message-ID: <20070110224922.2de6a641@werewolf-wl>
In-Reply-To: <Pine.LNX.4.61.0701100715330.16104@chaos.analogic.com>
References: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain>
	<45A3D1DF.4020205@s5r6.in-berlin.de>
	<Pine.LNX.4.61.0701091415200.12545@chaos.analogic.com>
	<Pine.LNX.4.64.0701100116420.10133@localhost.localdomain>
	<Pine.LNX.4.61.0701100715330.16104@chaos.analogic.com>
X-Mailer: Claws Mail 2.7.0cvs4 (GTK+ 2.10.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2007 07:16:55 -0500, "linux-os \(Dick Johnson\)" <linux-os@analogic.com> wrote:

> 
> On Wed, 10 Jan 2007, Robert P. J. Day wrote:
> 
> > On Tue, 9 Jan 2007, linux-os (Dick Johnson) wrote:
> >
> >>
> >> On Tue, 9 Jan 2007, Stefan Richter wrote:
> >>
> >>> Robert P. J. Day wrote:
> >>>>   just to stir the pot a bit regarding the discussion of the two
> >>>> different ways to define macros,
> >>>
> >>> You mean function-like macros, right?
> >>>
> >>>> i've just noticed that the "({ })"
> >>>> notation is not universally acceptable.  i've seen examples where
> >>>> using that notation causes gcc to produce:
> >>>>
> >>>>   error: braced-group within expression allowed only inside a function
> >>>
> >>> And function calls and macros which expand to "do { expr; } while (0)"
> >>> won't work anywhere outside of functions either.
> >>>
> >>>> i wasn't aware that there were limits on this notation.  can someone
> >>>> clarify this?  under what circumstances *can't* you use that notation?
> >>>> thanks.
> >>>
> >>> The limitations are certainly highly compiler-specific.
> >>
> >> I don't think so. You certainly couldn't write working 'C' code like
> >> this:
> >>
> >>  	do { a = 1; } while(0);
> >>
> >> This _needs_ to be inside a function. In fact any runtime operations
> >> need to be inside functions. It's only in assembly that you could
> >> 'roll your own' code like:
> >>
> >> main:
> >>  	ret 0
> >>
> >>
> >> Most of these errors come about as a result of changes where a macro
> >> used to define a constant. Later on, it was no longer a constant in
> >> code that didn't actually get compiled during the testing.
> >
> > just FYI, the reason i brought this up in the first place is that i
> > noticed that the ALIGN() macro in kernel.h didn't verify that the
> > alignment value was a power of 2, so i thought -- hmmm, i wonder if
> > there are any invocations where that's not true, so i (temporarily)
> > rewrote ALIGN to incorporate that check, and the build blew up
> > including include/net/neighbour.h, which contains the out-of-function
> > declaration:
> >
> > struct neighbour
> > {
> >        ...
> >        unsigned char           ha[ALIGN(MAX_ADDR_LEN, sizeof(unsigned long))];
> >        ...
> >
> > so it's not a big deal, it was just me goofing around and breaking
> > things.
> >
> > rday
> 
> 
> Hmmm, in that case you would be trying to put code inside a structure!
> Neat --if you could do it!
> 

The ({ }) is a block expression, ie, it allows declaring variables and
executing code. Its a gcc extension trying to resemble what other languages
like ML have:

ML:
f = let
      y = x*x
    in
      2*y + sin(y)
    end

GNU C:
f = ({ int y = x*x;
       2*y + sin(y); })

So you can put it on every place you could also put a { } block or declare a
variable. {} is a compund command and ({ }) is a compund expression
(or block expression, do not know which is the good name in engelish).

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.1 (Cooker) for i586
Linux 2.6.19-jam03 (gcc 4.1.2 20061110 (prerelease) (4.1.2-0.20061110.1mdv2007.1)) #1 SMP PREEMPT

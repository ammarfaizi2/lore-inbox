Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTJTKZy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 06:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTJTKZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 06:25:54 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:35473
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262525AbTJTKZ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 06:25:26 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Date: Mon, 20 Oct 2003 04:41:57 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200310180018.21818.rob@landley.net> <200310181538.35301.rob@landley.net> <20031020083135.GB14519@wohnheim.fh-wedel.de>
In-Reply-To: <20031020083135.GB14519@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310200441.57879.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 October 2003 03:31, Jörn Engel wrote:
> On Sat, 18 October 2003 15:38:35 -0500, Rob Landley wrote:
> > The decompression-side ones, yes.  (Modulo different command line
> > arguments, and that I didn't implement the "small mode" that's slower but
> > uses less memory.  That would probably only add a couple hundred bytes,
> > and I could make it a compile time option, but I just haven't gotten
> > around to it yet. If somebody wants to send me a patch... :)
>
> Does anyone really need the "small mode"?  If not, I consider it a
> feature to not support it. :)

The "fast mode" walks a 4 megabyte array (okay, 900k*4=3.6 megabytes) in a way 
that makes the cpu cache break down and cry, and actually brings dram bank 
switching latency into the picture.  (It's about the worst case scenario for 
memory access; fetching whole cache lines for randomly ordered 4 byte 
reads...)  Anything that doesn't do that seems like it's at least worth a 
look, but it's not a high priority just now...;)

Any future uber-xeon that has a 4 megabyte L2 cache is going to do bunzip 
_really_ fast. :)

> > > Not pretty with 80 columns, but it looks good at first glance.
> >
> > Manuel Novoa submitted a patch that sped things up over 10% (seriously
> > cool, that's why we're faster than the original), but broke the 80 column
> > thing (mostly a couple return statements that need to be on the next
> > line).
> >
> > I'm happy to take a patch to clean it up. :)
>
> Today is rainy.  Why not? ;)

It turns out Manuel Novoa is busy beating the source code to death with a 
profiler, which is why I'm waiting on the bzip-kernel patch.  He's sped it up 
another 10% or so since last time (extracting the kernel tarball took 22 
seconds in the original, and he's got it down under 18 now), but hasn't 
checked the result into busybox's CVS yet.  (He's still tweaking.)

No rush.  The kernel patch is on hold pending delivery of Manuel's updated 
bunzip code.  The ball's in his court at the moment.

> > > And surely more fun to work on than the zlib-inspired code from Julian.
> >
> > That was the original reason for doing this, yes. :)
>
> You don't - by any chance - plan the same thing for the compression
> side, do you?  I still have vague plans to improve the algorithm a bit,
> so a clean codebase would be nice to have.

That's what I'm working on now.  Yesterday, I glued all the bits necessary to 
bzip compress stdin to stdout into one 95k kilobyte c file (which compiled to 
a ~50k executable).  So far this evening I've trimmed that down to 79k of 
source and 48k of executable, and I'm still at the "crapectomy" stage.  Not 
actually doing serious reorganization type cleanup yet, just taking a scalpel 
(okay, vi) and removing bits that shouldn't BE there.  (The line "typedef 
BZFILE void;" should not occur in any program anywhere ever.  It just 
shouldn't.  "#define BZ_API(func) func" and "#define BZ_EXTERN extern" aren't 
really a good sign either, although they were the result of making the code 
compile on windows.  Unwinding this kind of thing is very time consuming.)

Not really relevant to the kernel, though.  Ask on the busybox list if you 
want to know more. :)

> > Eric Anderson pointed me to the new home of the kernel bunzip patch,
> > which is at "http://shepard.kicks-ass.net/~cc/", and I'll take a stab at
> > porting it to 2.6.0-test8 as the mood strikes me. :)
>
> Cool!  Maybe I should update my patches again.  They are definitely
> 2.7 material, but if people want to play with that stuff...
>
> Jörn

Which patches are you referring to?

I'm going to take the shepard patch and make a 2.6 version with the new bunzip 
code as soon as Manuel gets tired of making it faster.  But he hasn't yet, 
and I've got plenty of other things to do in the meantime...

Rob

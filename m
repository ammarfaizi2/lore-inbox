Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbTDYWjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 18:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTDYWjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 18:39:17 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:10090 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263928AbTDYWjO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 18:39:14 -0400
Date: Fri, 25 Apr 2003 18:48:41 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re:  Re:  Swap Compression
To: linux-kernel@vger.kernel.org
Message-id: <200304251848410590.00DEC185@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, I had to mail it 3 times.  Lst time I figured it out.

As for the performance hit, the original idea of that very tiny format was
to pack 6502 programs into 4k of code.  The expansion phase is very
tight and very efficient, and on a ... anything... it will provide no problem.
The swap-on-ram as long as it's not like 200 MB uncompressed SOR and
1 MB RAM will I think work great in the decompression phase.

Compression will take a little overhead.  I think if you use a boyer-moore
fast string search algo for binary strings (yes you can do this), you can
quickly compress the data.  It may be like.. just a guess... 10-30 times
more overhead than the decompression phase.  So use it on at least a
10-30 mhz processor.  If I ever write the code, it won't be kernel; just the
compression/decompression program (userspace).  Take the code and
stuff it into the kernel if I do.  I'll at the point of the algo coming in to
existence make another estimate.

The real power in this is Swap on RAM, but setting that as having precidence
over swap on disk (normal swaps) would decrease disk swap usage by
supplying more RAM in RAM.  And of course swapping RAM to RAM is
a lot faster.  I'm looking at this for PDA's but yes I will be running this on
my desktop the day we see it.

Well, I could work on the compression code, mebbe I can put the tarball up
here.  If I do I'd expect someone to add the code to swap to work with it--in
kernel 2.4 at the very least (port it to dev kernel later!).  As a separate module.
We don't want code that could be mean in the real swap driver. :)

--Bluefox Icy

---- ORIGINAL MESSAGE ----

List:     linux-kernel
Subject:  Re: Swap Compression
From:     =?iso-8859-1?Q?J=F6rn?= Engel <joern () wohnheim ! fh-wedel ! de>
Date:     2003-04-25 21:14:05
[Download message RAW]

On Fri, 25 April 2003 16:48:15 -0400, rmoser wrote:
> 
> Sorry if this is HTML mailed.  I don't know how to control those settings

It is not, but if you could limit lines to <80 characters, that would
be nice.

> COMPRESSED SWAP
> 
> This is mainly for things like linux on iPaq (handhelds.org) and
> people who like to play (me :), but how about compressed swap and
> RAM as swap?  To be plausable, we need a very fast compression
> algorithm.  I'd say use the following back pointer algorithm (this
> is headerless and I coded a decompressor in 6502 assembly in about
> 315 bytes) and 100k block sizes (compress streams of data until they
> are 100k in size, then stop.  Include the cap at the end in the
> 100k).
> 
> [...]
> 
> CONCLUSION
> 
> I think compressed swap and swap-on-ram with compression would be a
> great idea, especially for embedded systems.  High-performance
> systems that can handle the compression/decompression without
> blinking would especially benefit, as the swap-on-ram feature would
> give an almost seamless RAM increase.  Low-performance systems would
> take a performance hit, but embedded devices would still benefit
> from the swap-on-ram with compression RAM boost, considering they
> can probably handle the algorithm.  I am looking forward to seeing
> this implimented in 2.4 and 2.5/2.6 if it is adopted.

Nice idea. This might even benefit normal pc style boxes, if the
performance loss through compression is overcompensated by io gains
(less data transferred).

The tiny problem I see is that most people here have tons of whacky
ideas themselves but lack the time to actually implement them. If you
really want to get it done, do it yourself. It doesn't have to be
perfect, if it works in principle and appears to be promising, you
will likely receive enough help to finish it. But you have to get
there first.

At least, that is how it usually works. Feel free to prove me wrong.

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


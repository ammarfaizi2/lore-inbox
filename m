Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbTJTE3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 00:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbTJTE3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 00:29:17 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:27399 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262260AbTJTE2y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 00:28:54 -0400
Date: Mon, 20 Oct 2003 06:28:37 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Rob Landley <rob@landley.net>
Cc: Willy Tarreau <willy@w.ods.org>, Michael Buesch <mbuesch@freenet.de>,
       Nick Piggin <piggin@cyberone.com.au>, Daniel Egger <degger@fhm.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Message-ID: <20031020042837.GA4994@alpha.home.local>
References: <200310180018.21818.rob@landley.net> <200310191245.55961.mbuesch@freenet.de> <20031019210453.GE16761@alpha.home.local> <200310191900.47300.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310191900.47300.rob@landley.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 07:00:47PM -0500, Rob Landley wrote:
> upx is upx-1.22.  
> 
> So you're talking about something that compresses LESS well than gzip.  Why?

I'm not talking about something that compresses LESS than gzip, I'm talking
about something I almost always use to recompress my kernels and reduce their
size by 20% over gzip, and decompress way faster.

It's upx-1.90 (which is able to decompress/recompress bzimage). OK it's still
a development version, but it has already saved me megs of flash.

I don't know how the tests above were done. But what I know for sure is that
there are excessive open source zealots who would only download the OSS
version of UPX which uses the UCL library while the closed source version
uses the NRV one which is a jewel.

And you know what ? when I put a complete distro on a 8MB flash, my primary
concern is to save as much space as possible, and my ability to read the
compressor sources only comes next.

BTW, I don't remember every upx argument, but I'm sure I got best numbers
with '--best --crp-ms=100000'.

> And no, gzip -9 does not add anything to decompression time, only
> compression time.

Where did you get this interesting idea ? every decompressor needs
decompression time. You need the compressed kernel to be in memory, then you
decompress it, then you boot it. On my old 386sx which was still my home
firewall 6 months ago, the kernel would take 2-3 seconds to decompress with
gzip while it was almost unnoticeable with upx (which did it in place, BTW).

Now don't get me wrong, I'm not advertising for upx. But bzip2 was proposed
and will always be criticized because of its decompression time and cost in
terms of memory. So I simply suggested to take a look at other solutions
which seem interesting. An UPX-based implementation seems interesting to me
only if the decompression code is free and can be put in the kernel. Otherwise
it is not. If the numbers above come from the UCL lib, then we at least know
that this one doesn't interest us for this matter. Some people would also
suggest taking a look at other compression algorithms which can be of
interest, but I don't know their sources status (open/close).

> I can make bunzip work in-place if you'd like

That's very important for low-memory systems.

Regards,
Willy


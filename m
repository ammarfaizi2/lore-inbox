Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281525AbRKUAXb>; Tue, 20 Nov 2001 19:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281527AbRKUAXN>; Tue, 20 Nov 2001 19:23:13 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:64707 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281525AbRKUAXK>;
	Tue, 20 Nov 2001 19:23:10 -0500
Date: Tue, 20 Nov 2001 19:23:07 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more fun with procfs (netfilter)
In-Reply-To: <20011121001418.C2472@kushida.jlokier.co.uk>
Message-ID: <Pine.GSO.4.21.0111201920030.23604-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Nov 2001, Jamie Lokier wrote:

> Alexander Viro wrote:
> > - IOW, awk (both gawk and mawk) loses everything past the first 4Kb.
> > And yes, it's a real-world example (there was more than $5 and it was
> > followed by sed(1), but that doesn't affect the result - lost lines).
> 
> Does this break fopen/fscanf as well then?  There are programs which use
> fscanf to read this info.

I suspect that unless you do something stupid with setvbuf() you should be
OK - glibc uses sufficiently large buffers for stdio and doesn't try to
cram as much as possible into them (that's what kills awk - it ends up
doing read(2) again and agian trying to fill the buffer and eventually
tail of the buffer becomes too small; then it gets 0 from read(2) and
decides that it was an EOF).


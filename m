Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUBPSuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 13:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265748AbUBPSuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 13:50:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:28595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265740AbUBPSuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 13:50:03 -0500
Date: Mon, 16 Feb 2004 10:49:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc Lehmann <pcg@schmorp.de>
cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <20040216183616.GA16491@schmorp.de>
Message-ID: <Pine.LNX.4.58.0402161040310.30742@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402150006.23177.robin.rosenberg.lists@dewire.com>
 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
 <200402150107.26277.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Feb 2004, Marc Lehmann wrote:
> 
> > In short: the kernel talks bytestreams, and that implies that if you want 
> > to talk to the kernel, you HAVE TO USE UTF-8.
> 
> This is not the problem at all. It's perfectly easy to write
> applications that talk UTF-8 and just UTF-8 with the kernel.
> 
> The problem is that the kernel does not use UTF-8, i.e. applications in
> the current linux model have to deal with the fact that the kernel
> happily breaks the assumed protocol of using UTF-8 by delivering illegal
> byte sequences to applications.

You didn't read what I said.

READ MY POSTING. You even quoted it, but you didn't understand it.

I'm saying that "the kernel talks bytestreams".

I have never claimed that the kernel really talk s UTF-8, and indeed, I 
would say that such a kernel would be terminally and horribly broken. 

The kernel is _agnostic_ in what it does. As it should be. It doesn't 
really care AT ALL what you feed it, as long as it is a byte-stream.

Now, that implies that if you want to have extended characters, then YOU 
HAVE TO USE UTF-8.

That's what I'm saying. I am _not_ saying that the kernel uses UTF-8. The 
kernel doesn't care one way or the other. As far as the kernel is 
concerened, you could uuencode all the stuff, and the kernel wouldn't 
think you're crazy. The kernel _only_ cares about byte streams. And that 
is as it should be.

> There is no way for applications to handle UTF-8 and illegal-utf8 in
> a sane way, so most apps will either eat the illegal bytes, skip the
> filename, or crash (the latter case is clearly a bug in the app, thr
> former cases aren't).

What you're complaining about are bad user applications. It has _zero_ to 
do with the kernel.

> Fixing the VFS to actually enforce what linus claims (2filenames are
> utf-8") is a very good idea, imho.

No. Read my claim again. You obviously do not understand it AT ALL. 

What you suggest would be a horribly idiotic and bad idea. The kernel 
doesn't set policy. The kernel says "this is what I can do, you set 
policy".

And UTF-8 just happens to be the only sane policy for encoding complex 
characters into a byte stream. But it is not the only policy.

Another sane policy is to say "byte streams are latin1". It's not an
acceptable policy for encoding _complex_ characters, but it is a policy.
And it's a perfectly sane one.

In short: filenames are byte streams. Nothing more. They don't even have a 
"character set". They literally are just a series of bytes.

And when I say that you have to talk to the kernel using UTF-8, I'm only 
claiming that it is the only sane way to encode extended characters in a 
byte stream. Nothing more.

		Linus

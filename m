Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264706AbTD0Rjg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 13:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264708AbTD0Rjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 13:39:35 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:472 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264706AbTD0Rjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 13:39:32 -0400
Date: Sun, 27 Apr 2003 19:51:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: rmoser <mlmoser@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re:  Swap Compression
Message-ID: <20030427175147.GA5174@wohnheim.fh-wedel.de>
References: <200304251848410590.00DEC185@smtp.comcast.net> <20030426091747.GD23757@wohnheim.fh-wedel.de> <200304261148590300.00CE9372@smtp.comcast.net> <20030426160920.GC21015@wohnheim.fh-wedel.de> <200304262224040410.031419FD@smtp.comcast.net> <20030427090418.GB6961@wohnheim.fh-wedel.de> <200304271324370750.01655617@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304271324370750.01655617@smtp.comcast.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 April 2003 13:24:37 -0400, rmoser wrote:
> >int fox_compress(unsigned char *input, unsigned char *output,
> >		uint32_t inlen, uint32_t *outlen);
> >
> >int fox_decompress(unsigned char *input, unsigned char *output,
> >		uint32_t inlen, uint32_t *outlen);
> 
> Ey? uint32_t*?  I assume that's a mistake....

Nope. outlen is changed, you need a pointer here.

> Anyhow, this wasn't what
> I was asking.  What I was asking was about how to determine how much
> data to send to compress it.  Read the message again, the whole thing
> this time.

I did. But modularity is the key here. The whole idea may be great or
plain bullshit, depending on the benchmarks. Which one it is depends
on the compression algorithm used, among other things. Maybe your
compression algo is better for some machines, zlib for others, etc.

Why should someone decide on an algorithm before measuring?

> >Then the mm code can pick any useful size for compression.
> 
> Eh?  I rather the code alloc space itself and do all its own handling.  That
> way you don't have to second-guess the buffer size for decompressed
> data if you don't do all-at-once decompression (i.e. decompressing x86
> segments, all-at-once would be to decompress the whole compressed
> block of N size to 64k, where partial would be to pull in N/n at a time and
> decompress in n sets of N/n, which would give varying sized output).

Segments are old, stupid and x86 only. What you want is a number of
pages, maybe just one at a time. Always compress chunks of the same
size and you don't have to guess the decompressed size.

> Another thing is that the code isn't made to strictly stick to compressing
> or decompressing a whole input all at once; you may break down the
> input into smaller pieces.  Therefore it does need to think about how much
> it's gonna actually tell you to pull off when you inquire about the size to
> remove from the stream (for compression at least), because you might
> break it if you pull too much data off midway through compression.  The
> advantage of this method is in when you're A) Compressing files, and
> B) trying to do this kind of thing on EXTREMELY low RAM systems,
> where you can't afford to pass whole buffers back and forth.  (Think 4 meg)

a) Even with 4M, two pages of 4k each don't hurt that much. If they
do, the whole compression trick doesn't pay off at all.
b) Compression ratios usually suck with small buffers.

> You do actually understand the code, right?  I have this weird habit of
> making code and doing such obfuscating comments that people go
> "WTF is this?" when they see it.  Then again, you're probably about
> 12 classes past me in C programming, so maybe it's just my logic that's
> flawed. :)

I didn't look that far yet. What you could do, is read through
/usr/src/linux/Documentation/CodingStyle. It is just so much nicer
(and faster) to read and sticking to it usually produces better code.

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth

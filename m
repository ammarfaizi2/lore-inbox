Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315217AbSD2WNu>; Mon, 29 Apr 2002 18:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSD2WNt>; Mon, 29 Apr 2002 18:13:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28681 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315217AbSD2WNt>; Mon, 29 Apr 2002 18:13:49 -0400
To: linux-kernel@vger.kernel.org
From: Daniel Quinlan <quinlan@transmeta.com>
Subject: Re: [RFC/FYI] cramfs 6/6 - boot/root stuff
Date: 29 Apr 2002 15:13:05 -0700
Organization: Transmeta Corporation
Message-ID: <6yy9f6rw5q.fsf@transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0204291553570.25892-100000@ado-2.axis.se>
X-Trace: palladium.transmeta.com 1020118389 16901 127.0.0.1 (29 Apr 2002 22:13:09 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 29 Apr 2002 22:13:09 GMT
Original-Sender: quinlan@transmeta.com
X-Newsreader: Gnus v5.7/Emacs 20.7
Cache-Post-Path: palladium.transmeta.com!unknown@sodium.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Adolfsson <johan.adolfsson@axis.com> writes:

> <ugly hack warning>
> 6. (RFC/FYI) In our tree we have a hack that allows us
>    to append the cramfs image to the kernel image and use it to boot from.
> [...]
> Any hints of other approaches?

It seems much cleaner to use the padding option to put some boot code
in the first 512 bytes of the cramfs image which you can use to jump
to anywhere in the image.

What we did for x86 was to put boot code in the first 512 bytes (the
"-p" option to mkcramfs), then jump to 512 bytes after the superblock
start (offset 1024) which was where we put the kernel (put there via the
"-i" option to mkcramfs, just a normal kernel image padded at the
beginning by 436 bytes so it would start at offset 1024).

We could have just jumped to offset 588 instead of 1024 and not padded
the kernel, but we used even numbers for some (aesthetic?) reason that I
can't recall.

Dan

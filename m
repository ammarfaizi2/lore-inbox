Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318323AbSGYFXK>; Thu, 25 Jul 2002 01:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318324AbSGYFXK>; Thu, 25 Jul 2002 01:23:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53010 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318323AbSGYFXJ>; Thu, 25 Jul 2002 01:23:09 -0400
Date: Wed, 24 Jul 2002 22:27:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matt_Domsch@Dell.com
cc: viro@math.psu.edu, <Andries.Brouwer@cwi.nl>,
       <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.28 and partitions
In-Reply-To: <F44891A593A6DE4B99FDCB7CC537BBBBB8394A@AUSXMPS308.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.44.0207242222410.1231-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Jul 2002 Matt_Domsch@Dell.com wrote:
>
> The promise of 64-bit block addresses eventually was a huge part of why I
> worked on the GPT code in the kernel, partx, parted, etc.  I could really
> use it today, and it'll be a solid requirement less than a year from now.

Note that there is one place where 64 bits is simply _too_ expensive, and
that's the page cache. In particular, the "index" in "struct page". We
want to make "struct page" _smaller_, not larger.

Right now that means that 16TB really is a hard limit for at least some
device access on a 32-bit machine with a 4kB page-size (yes, you could
make a filesystem that is bigger, but you very fundamentally cannot make
individual files larger than 16TB).

The block device layer also cannot write to the 16TB+ region using the
page cache (but it should be possible to do it using raw device access
with a 64-bit sector_t, so you can initialize the filesystem).

			Linus


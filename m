Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269862AbRHDVCa>; Sat, 4 Aug 2001 17:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269866AbRHDVCW>; Sat, 4 Aug 2001 17:02:22 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:63243 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269862AbRHDVCG>; Sat, 4 Aug 2001 17:02:06 -0400
Message-ID: <3B6C6423.2BFA3CFA@zip.com.au>
Date: Sat, 04 Aug 2001 14:07:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic 
 change patch)
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com>, <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org> <3B6B4B21.B68F4F87@zip.com.au>, <3B6B4B21.B68F4F87@zip.com.au> <20010804131904.E18108@weta.f00f.org> <3B6B53A9.A9923E21@zip.com.au>,
		<3B6B53A9.A9923E21@zip.com.au> <20010804060423.I16516@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> 
> aren't we already at the point that ext3 fsync() flushes
> the corresponding dirents?

_any_ synchronous operation on ext3 has flushed _everything_
by the time it returns to the caller.  Every last little bit
is on disk.

This applies to fsync() against any file/dir, write() on an
O_SYNC file, any metadata operation or write() against a `chattr +S'
object, any metadata operation or write() against a `mount -o sync'
filesystem and msync().

The only exception is pageout of mmap'ed files - you'll need to
run msync() to guarantee that these are crashproofed.

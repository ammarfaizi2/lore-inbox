Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278507AbRJPC6Q>; Mon, 15 Oct 2001 22:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278506AbRJPC6G>; Mon, 15 Oct 2001 22:58:06 -0400
Received: from zok.sgi.com ([204.94.215.101]:64927 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S278507AbRJPC55>;
	Mon, 15 Oct 2001 22:57:57 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.13-pre3 arm/i386/mips/mips64/s390/s390x/sh die() deadlock 
In-Reply-To: Your message of "Mon, 15 Oct 2001 19:36:02 MST."
             <Pine.LNX.4.33.0110151934060.4179-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Oct 2001 12:58:21 +1000
Message-ID: <18966.1003201101@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001 19:36:02 -0700 (PDT), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>On Tue, 16 Oct 2001, Keith Owens wrote:
>>
>> Any die() routine that uses die_lock to avoid multiple cpu reentrancy
>> will deadlock on recursive die() errors.
>
>Well, I have to say that I personally have always considered the "die"
>lock to not be about multiple CPU re-entrancy, but _exactly_ to stop
>infinite oops reports if an oops itself oopses.
>
>I much prefer a dead machine with a partially visible oops over a oops
>where the original oops has scrolled away due to recursive faults.

AFAIK, Andrew Morton was considering concurrent calls to die() when he
added die_lock.  There had been bug reports where both cpus were trying
to dump registers at the same time so the output was interleaved and
unreadable, die_lock prevented that.

IMHO it is unrealistic to expect that all code inside die() will never
fail.  Any unexpected kernel corruption could cause the register or
backtrace dump to fail.  The patch gets the best of both worlds.  It
protects against recursive errors and against concurrent calls to
die().


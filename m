Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSESDF5>; Sat, 18 May 2002 23:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSESDF4>; Sat, 18 May 2002 23:05:56 -0400
Received: from bitmover.com ([192.132.92.2]:65190 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314083AbSESDF4>;
	Sat, 18 May 2002 23:05:56 -0400
Date: Sat, 18 May 2002 20:05:40 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020518200540.N8794@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk
In-Reply-To: <E179GA4-0004ZT-00@wagner.rustcorp.com.au> <Pine.LNX.4.44.0205181958140.30454-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2002 at 08:01:48PM -0700, Linus Torvalds wrote:
> On Sun, 19 May 2002, Rusty Russell wrote:
> >
> > Huh?  No, you ask for 2000 bytes into a buffer that can only take 1000
> > bytes without hitting an unmapped page, returning EFAULT or giving a
> > SIGSEGV is perfectly acceptable.
> 
> Bzzt, wrong answer.

Linus is absolutely right.  The correct semantics are to return the number
of bytes read, if they are greater than zero, and on the next read return
the error.  This has been a corner case in read for a long time in various
Unix versions, and Linus has it right.  I went through this back at Sun
and we explored all the different ways, and the bottom line is that you
first ACK that you moved some data and then you NAK on the next read.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

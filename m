Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279785AbRJ0Gft>; Sat, 27 Oct 2001 02:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279786AbRJ0Gff>; Sat, 27 Oct 2001 02:35:35 -0400
Received: from zero.tech9.net ([209.61.188.187]:61450 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279785AbRJ0GfY>;
	Sat, 27 Oct 2001 02:35:24 -0400
Subject: Re: [PATCH] random.c bugfix
From: Robert Love <rml@tech9.net>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>
In-Reply-To: <20011027002142.D23590@turbolinux.com>
In-Reply-To: <m15xL0J-007qTxC@smtp.web.de> 
	<20011027002142.D23590@turbolinux.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.25.15.53 (Preview Release)
Date: 27 Oct 2001 02:35:55 -0400
Message-Id: <1004164556.3274.14.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-27 at 02:21, Andreas Dilger wrote:
> OK, my bad.  At least the random variable-name cleanups let you SEE where
> we are supposed to be using word sizes and byte sizes.  Even you were
> confused about it ;-)

I went over your original patch good; I am surprised I missed this. :/
Nonetheless, only with the new cleanups could anyone spot this.

> Well, this is a matter of taste.  With my code, it is correct regardless
> of how tmp is declared, while with your code you assume tmp is TMP_BUF_SIZE
> words, and that it is declared with a 4-byte type.  Both ways are resolved
> at compile time, so using "sizeof(tmp)/4" or "sizeof(tmp)*8" doesn't add
> any run-time overhead.

I think I prefer your sizeof() method, if for nothing else but that we
can keep it consistent -- we can always take the sizeof a variable and
not everything has its size in a define.

Furthermore, sizeof(tmp) certainly means "size of the variable temp"
while TMP_BUF_SIZE could be the size of anything related to tmp -- the
buffer it points to (if it were a pointer), a buffer in it (if it were a
struct), etc.  Since it all compiles to the same, it is not a huge
issue.  Just my two bits...

> I don't have a strong opinion either way, if Linus and/or Alan have a
> preference to do it one way or the other.

...but I'm not Alan or Linus ;)

	Robert Love


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSGQOge>; Wed, 17 Jul 2002 10:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSGQOgd>; Wed, 17 Jul 2002 10:36:33 -0400
Received: from ns.suse.de ([213.95.15.193]:35594 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315120AbSGQOgc>;
	Wed, 17 Jul 2002 10:36:32 -0400
To: Elladan <elladan@eskimo.com>
Cc: Stevie O <stevie@qrpff.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Zack Weinberg <zack@codesourcery.com>, linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs
 benchmarks)
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
	<20020716232225.GH358@codesourcery.com>
	<1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
	<5.1.0.14.2.20020717001624.00ab8c00@whisper.qrpff.net>
	<20020717043853.GA31493@eskimo.com>
X-Yow: Just imagine you're entering a state-of-the-art CAR WASH!!
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 17 Jul 2002 16:39:28 +0200
In-Reply-To: <20020717043853.GA31493@eskimo.com> (Elladan's message of "Tue,
 16 Jul 2002 21:38:53 -0700")
Message-ID: <je65zel8pr.fsf@sykes.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elladan <elladan@eskimo.com> writes:

|> On Wed, Jul 17, 2002 at 12:17:40AM -0400, Stevie O wrote:
|> > At 07:22 PM 7/16/2002 -0700, Elladan wrote:
|> > >  1. Thread 1 performs close() on a file descriptor.  close fails.
|> > >  2. Thread 2 performs open().
|> > >* 3. Thread 1 performs close() again, just to make sure.
|> > >
|> > >
|> > >open() may return any file descriptor not currently in use.
|> > 
|> > I'm confused here... the only way close() can fail is if the file
|> > descriptor is invalid (EBADF); wouldn't it be rather stupid to close()
|> > a known-to-be-bad descriptor?
|> 
|> Well, obviously, if that's the case.  However, the man page for close(2)
|> doesn't agree (see below).  close() is allowed to return EBADF, EINTR,
|> or EIO.
|> 
|> The question is, does the OS standard guarantee that the fd is closed,
|> even if close() returns EINTR or EIO?  Just going by the normal usage of
|> EINTR, one might think otherwise.  It doesn't appear to be documented
|> one way or another.

POSIX says the state of the file descriptor when close fails (with errno
!= EBADF) is unspecified, which means:

    The value or behavior may vary among implementations that conform to
    IEEE Std 1003.1-2001. An application should not rely on the existence
    or validity of the value or behavior. An application that relies on
    any particular value or behavior cannot be assured to be portable
    across conforming implementations.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

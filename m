Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSEUUky>; Tue, 21 May 2002 16:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316602AbSEUUkP>; Tue, 21 May 2002 16:40:15 -0400
Received: from [195.39.17.254] ([195.39.17.254]:2202 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316598AbSEUUi6>;
	Tue, 21 May 2002 16:38:58 -0400
Date: Thu, 16 May 2002 23:53:36 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020516235335.C116@toy.ucw.cz>
In-Reply-To: <E179HQd-0000j7-00@wagner.rustcorp.com.au> <Pine.LNX.4.44.0205182030160.31341-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Um, what about delivering a SIGSEGV?  So, copy_to/from_user always
> > returns 0, but a signal is delivered.
> 
> That doesn't help. It's against some stupid SUS rule, I'm afraid.
> 
> (And THAT is a stupid rule, I 100% agree with. It means that some things
> return -EFAULT, and other things do SIGSEGV, and the only difference is
> whether something is a system call or is implemented as a library thing.
> UNIX should always just have segfaulted, but there you are..)

I thought POSIX made it explicit that you may SIGSEGV or EFAULT at your
option. If that SUS rule is stupid, we should just drop it.

Performance advantage from MMX-copy-to-user is probably well worth it.

Ouch, and your read example. Imagine you do read (fd, buf, 12000), and first
page of buf is there, second is not and third is [could happen in your GC
case]. What if copy-to-user decides to first write byte 11045 of buffer, 
then byte 17, then byte 4875 (and fault)? I think kernel *has* right to 
do that. What will it use as return value?

I think such GC library is seriously broken.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


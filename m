Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316611AbSEUVRd>; Tue, 21 May 2002 17:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316607AbSEUVRb>; Tue, 21 May 2002 17:17:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2057 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316611AbSEUVRY>; Tue, 21 May 2002 17:17:24 -0400
Date: Tue, 21 May 2002 23:17:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020521211727.GG22878@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020516235335.C116@toy.ucw.cz> <Pine.LNX.4.33.0205211340080.3073-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I thought POSIX made it explicit that you may SIGSEGV or EFAULT at your
> > option. If that SUS rule is stupid, we should just drop it.
> > 
> > Performance advantage from MMX-copy-to-user is probably well worth it.
> 
> Stop this STUPID "it speeds things up" argument.
> 
> It's not TRUE.
> 
> We still have to do exactly the same things we do right now, because even
> if we SIGSEGV we still have to return the right number of bytes
> read/written. 
> 
> SIGSEGV doesn't mean that the system call wouldn't complete. It removes 
> _none_ of the kernel fixup handling, because the SIGSEGV won't be 
> delivered until we return to user mode anyway. So please stop mixing these 
> two issues up.

If you pass bad pointer to memcpy(), you don't expect any reasonable
return value, right?

So if you pass bad pointer to read(), why would you expect "number of
bytes read" return? Its true that kernel can't simply not return
anything, but giving SIGSEGV and returning -EFAULT seems pretty
reasonable to me. If they really want to, they might extract number of
bytes read from address SIGSEGV occured at [but that's dirty hack, and
people will hopefully realise that and not rely on it].
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.

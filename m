Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267594AbTBKLGr>; Tue, 11 Feb 2003 06:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbTBKLGb>; Tue, 11 Feb 2003 06:06:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2055 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267594AbTBKLGS>; Tue, 11 Feb 2003 06:06:18 -0500
Date: Tue, 11 Feb 2003 12:16:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: Fix random memory corruption during suspend-to-RAM resume
Message-ID: <20030211111601.GA11817@atrey.karlin.mff.cuni.cz>
References: <20030209203141.GA2223@elf.ucw.cz> <Pine.LNX.4.44.0302100934240.7698-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302100934240.7698-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We really want to use wakeup_stack as stack, not as pointer to
> > stack... Please apply,
> 
> Hmm.. The stack grows downwards, are you sure you don't really mean
> 
> 	mov $(wakeup_end-wakeup_code),%sp
> 
> (because wakeup_end is the end of the wakeup_stack area..)

Yes, I'm sure:

        .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
wakeup_stack:
        .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        .long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

Okay, I might want to kill the second set of longs ;-).

I need to substract wakeup_code because code is being relocated in
quite a strange way.

							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.

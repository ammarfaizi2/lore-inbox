Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267597AbSLSWIJ>; Thu, 19 Dec 2002 17:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbSLSWHc>; Thu, 19 Dec 2002 17:07:32 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9476 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267076AbSLSWGP>;
	Thu, 19 Dec 2002 17:06:15 -0500
Date: Thu, 19 Dec 2002 00:51:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021218235124.GB705@elf.ucw.cz>
References: <Pine.LNX.4.44.0212161832420.12062-100000@home.transmeta.com> <Pine.LNX.4.44.0212162140500.1644-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212162140500.1644-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > (Modulo the missing syscall page I already mentioned and potential bugs
> > in the code itself, of course ;)
> 
> Ok, I did the vsyscall page too, and tried to make it do the right thing
> (but I didn't bother to test it on a non-SEP machine).
> 
> I'm pushing the changes out right now, but basically it boils down to the
> fact that with these changes, user space can instead of doing an
> 
> 	int $0x80
> 
> instruction for a system call just do a
> 
> 	call 0xfffff000
> 
> instead. The vsyscall page will be set up to use sysenter if the CPU
> supports it, and if it doesn't, it will just do the old "int $0x80"
> instead (and it could use the AMD syscall instruction if it wants to).
> User mode shouldn't know or care, the calling convention is the same as it
> ever was.

Perhaps it makes sense to define that gettimeofday is done by

	call 0xfffff100,

NOW? So we can add vsyscalls later?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSLOWWB>; Sun, 15 Dec 2002 17:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSLOWWB>; Sun, 15 Dec 2002 17:22:01 -0500
Received: from [195.39.17.254] ([195.39.17.254]:12804 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263105AbSLOWWA>;
	Sun, 15 Dec 2002 17:22:00 -0500
Date: Sun, 15 Dec 2002 23:01:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, terje.eggestad@scali.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021215220132.GB6347@elf.ucw.cz>
References: <200212150406.gBF469M482759@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212150406.gBF469M482759@saturn.cs.uml.edu>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > As far as I know, though, the SYSENTER patch didn't deal with several of
> > the corner cases introduced by the generally weird SYSENTER instruction
> > (such as the fact that V86 tasks can execute it despite the fact there
> > is in general no way to resume execution of the V86 task afterwards.)
> >
> > In practice this means that vsyscalls is pretty much the only sensible
> > way to do this.  Also note that INT 80h will need to be supported
> > indefinitely.
> >
> > Personally, I wonder if it's worth the trouble, when x86-64 takes care
> > of the issue anyway :)
> 
> There is another way:
> 
> Have apps enter kernel mode via Intel's purposely undefined
> instruction, plus a few bytes of padding and identification.
> Require that this not cross a page boundry. When it faults,
> write the SYSENTER, INT 0x80, or SYSCALL as needed. Leave
> the page marked clean so it doesn't need to hit swap; if it
> gets paged in again it gets patched again.

Thats *very* dirty hack. vsyscalls seem cleaner than that.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbTAQQSf>; Fri, 17 Jan 2003 11:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbTAQQSf>; Fri, 17 Jan 2003 11:18:35 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:52644 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267602AbTAQQSb>; Fri, 17 Jan 2003 11:18:31 -0500
Date: Fri, 17 Jan 2003 10:24:42 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Russell King <rmk@arm.linux.org.uk>, Mikael Pettersson <mikpe@csd.uu.se>,
       <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
In-Reply-To: <m1adhzg3fp.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0301171019220.15056-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 2003, Eric W. Biederman wrote:

> > Well:
> > 
> >         __start___ksymtab = .;                                          \
> >         __ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {         \
> >                 *(__ksymtab)                                            \
> >         }                                                               \
> >         __stop___ksymtab = .;                                           \
> > 
> > breaks on some ARM binutils (from a couple of years ago.)  The most
> > reliable way we've found in with ARM binutils is to place the symbols
> > inside the section - this appears to work 100% every single time and
> > I've never had any reports of failure (whereas I did with the symbols
> > outside as above.)
> 
> That has been roughly my experience on x86 as well with the exception
> of bss sections.  For bss sections placing the symbols inside the section
> itself has been deadly.

Can both of you guys elaborate on what "break" means here, I'm trying to 
better understand what's going on. One thing is rather obvious, and that's 
what causing the current breakage with RH8 binutils:

If "." isn't properly aligned, __kstart___ksymtab will point to an address
which is before the actual start of the section, since that gets aligned 
to its requirements. Was that the ARM problem?

Now, what's different for __bss, i.e. what goes wrong there?

Related issue: The linker will actually automatically emit
__{start,stop}_SECTION symbols when SECTION is a C symbol (i.e.  
letters,numbers,_), so things should actually work without explicitly
defining those symbols. They do on i386 with my binutils, but I assume
there's some reason why we don't just rely on that?

--Kai



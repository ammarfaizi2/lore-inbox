Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbTB0WKm>; Thu, 27 Feb 2003 17:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbTB0WKm>; Thu, 27 Feb 2003 17:10:42 -0500
Received: from oumail.zero.ou.edu ([129.15.0.75]:17558 "EHLO c3p0.ou.edu")
	by vger.kernel.org with ESMTP id <S267120AbTB0WKl>;
	Thu, 27 Feb 2003 17:10:41 -0500
Date: Thu, 27 Feb 2003 16:20:56 -0600
From: Steve Kenton <skenton@ou.edu>
Subject: Re: pointer to .subsection and .previous usage in kernel?
To: lkml <linux-kernel@vger.kernel.org>
Message-id: <3E5E8F47.635B41D0@ou.edu>
Organization: The University Of Oklahoma
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (X11; U; SunOS 5.8 sun4u)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I was following up on some pointers from Jeff Dike on the
User Mode Linux home page about possibly running UML in a windows environment.
Jeff says that SMP has worked in the past and will again in the future
so I'm pretty sure that spinlocks will be needed ...

As a first pass to see where the problems were located I tried to build a
'host' kernel for i386 using the cygwin tool chain.  That version of gcc produces
i386pe format output instead of elf which triggered the problem with .subsection
not being a recognized gas directive.  I understand that .subsections force
things to be closely located within a section when there is no other logical
association and that they are not visible to the the linker which only deals with
sections.  They only reason *I *can see for this is to improve cache hits but
I'm just guessing, hence the question.

FYI, by hacking out the .subsection/.previous directive I was able to build a
vmlinux for 2.5.59 using the cygwin tool chain under windows.  Obviously it is
not useful as is, but there seem to be relatively few syntax and toolchain
problems to deal with.  Hopefully the hard part of an actual UML port to windows
can be snarfed from the LINE project.  Again based on a pointer from Jeff Dike.

Anyway, I'm just trying to get up to speed and was wondering *WHY* things are
done that way.  Most of the in-line and asm stuff still looks like voodoo to me.
The .subsection/.previous just looks like a little blacker magic than normal.

Steve
 
>If you are writing code under cygwin, you should not be encountering
>spin-locks and kernel-specific things. Perhaps you are including
>>the wrong header files? You should never do:
>
>        #include <linux/xxx.h>
>        #include <asm/xxx.h>
>
>... unless you are writing modules. And you don't do that in cygwin.
>
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
>Why is the government concerned about the lunatic fringe? Think about it.

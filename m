Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268399AbUJQTGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268399AbUJQTGh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268435AbUJQTGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:06:36 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:36586 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268399AbUJQTGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:06:13 -0400
Date: Sun, 17 Oct 2004 21:06:12 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dan Kegel <dank@kegel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>
Subject: Re: Building on case-insensitive systems and systems where -shared doesn't work well
Message-ID: <20041017190612.GB27637@mail.13thfloor.at>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
	bertrand marquis <bertrand.marquis@sysgo.com>
References: <4164DAC9.8080701@kegel.com> <20041016210024.GB8306@mars.ravnborg.org> <20041016200627.A20488@flint.arm.linux.org.uk> <20041016212440.GA8765@mars.ravnborg.org> <20041016204001.B20488@flint.arm.linux.org.uk> <20041016220427.GE8765@mars.ravnborg.org> <20041017165718.GB23525@mail.13thfloor.at> <4172A0ED.9040906@kegel.com> <20041017182929.GA27637@mail.13thfloor.at> <4172B01B.5080404@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4172B01B.5080404@kegel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 10:47:07AM -0700, Dan Kegel wrote:
> Herbert Poetzl wrote:
> >>The only .s/.S ambiguities that need resolving are intermediate files,
> >>so fixing them should only require changing a few Makefile rules.
> >>Let's wait and see what the patch looks like before we
> >>argue about it; maybe it will be simple to make everybody
> >>happy here (well, except those who hate the idea of
> >>letting anyone compile Linux kernels on Cgywin or MacOSX).
> >
> >fair enough, but Mac OS X doesn't require this (UFS
> >is case sensititve, and probably no linux guy/gal uses 
> >HFS+), so IMHO it's 'just' Cygwin* folks here ...
> 
> MacOSX uses HFS+ by default.  As a result, 99% of
> people using MacOSX are going to use HFS+.  

> I'm a serious Linux developer, but if I owned a Mac,
> I'd probably leave it set to HFS+, since I like
> to keep my systems vanilla (it makes it easier to
> pick up my stuff and use it on someone else's machine).

> Thus it's not just Cygwin that's affected; this is
> a real issue for MacOSX as commonly configured.

hmm, well, probably the result of a halfhearted attempt
to satisfy both, the OpenStep and the MacOS Classic
developers ... but that doesn't belong here ...

just as fact:

# gcc --version

gcc (GCC) 3.3 20030304 (Apple Computer, Inc. build 1666)
Copyright (C) 2002 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# man gcc

      file.s
           Assembler code.  Apple's version of GCC runs the preprocessor on
           these files as well as those ending in .S.

      file.S
           Assembler code which must be preprocessed.

# uname -a
Darwin anson 7.5.0 Darwin Kernel Version 7.5.0: Thu Aug  5 19:26:16 PDT 2004; root:xnu/xnu-517.7.21.obj~3/RELEASE_PPC  Power Macintosh powerp

ONTOPIC:

why not move the intermediate files into a separate
subdirectory which can easily be removed on cleanup?

of course, gcc could also be changed to use different
extensions than .s and .S for those files ...

best,
Herbert

> - Dan
> 
> -- 
> Trying to get a job as a c++ developer?  See 
> http://kegel.com/academy/getting-hired.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

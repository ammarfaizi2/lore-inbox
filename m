Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbTAFT2Q>; Mon, 6 Jan 2003 14:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbTAFT2Q>; Mon, 6 Jan 2003 14:28:16 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:55049 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267104AbTAFT2O>;
	Mon, 6 Jan 2003 14:28:14 -0500
Date: Mon, 6 Jan 2003 20:36:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] Documentation/kbuild/makefiles.txt
Message-ID: <20030106193651.GA1320@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20030105215137.GA3659@mars.ravnborg.org> <Pine.LNX.4.33L2.0301051619210.13623-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301051619210.13623-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 09:04:14AM -0800, Randy.Dunlap wrote:
> 
> Can you add a section about building non-kernel-tree drivers etc.?
> I.e., building from source files that are not resident in the
> kernel tree?
> 
> And do you have a section on building in $objtree with
> $srctree != $objtree?  I didn't see it.  Or is this not the right
> document for that topic?

I plan to write a small kernel compile HOWTO. There I will cover
both usage scenarios.
It is supposed to obsolete commands.txt as of today.

makefiles.txt will cover only how to write Makefiles and what they
can be used to do. I kept chapter two because it was a good
definition of the target group.
But I agree with you that the information you requests are missing.

Btw. my patch to build the kernel in a separate directory is
not yet ready for inclusion. oprofile and xfs causes me trouble,
they refuse to do things in the normal way.
Also the lack of consistency when including files annoy me.
I hope to get some feedback from Kai on this soon.

> | 	Rules.make compiles all the $(obj-y) files.  It then calls
> Where is Rules.make nowadays?

[Above is a left-over from the old document, will be updated].

Rules.make vanished when Kai did the spilt into scripts/Makefile.build,
scripts/Makefile.lib, scripts/Makefile.clean etc.
It started with me submitting a patch that made "make clean" descend
down in all directories. That was way too slow, and Kai made the split
speeding up "make clean" a lot.

The concept is that make is called with:
make -f scripts/Makefile.build obj=path/to/makefile
Then Makefile.build includes $(obj)/Makefile.
Therefore the individual Makefiles no longer need to include any
file, and Rules.make became obsolete.

IIRC this concept was originally described some time ago at
kbuild-devel.

> |    arch/$(ARCH)/Makefile.
> Example?  arch/i386/Makefile in 2.5.54 doesn't contain "head-y".

I have a pending patch introducing head-y for all architectures.
If it is rejected I will update the text.

> | 	Append or modify as required pr. architecture.
>                                      per (?)
Abbrevation came form the wrong language ;-)

> | 	will be displayed with "make KBUILD_VERBOSE=0".
> It would be nice to have a shorthand notation for this, like -s
> means "silent".
I have KBUILD_VERBOSE=0 in my .bashrc, but I see your point.

> HTH.

Helps a lot, thanks indeed!
All corrections applied.

	Sam

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTA0RuW>; Mon, 27 Jan 2003 12:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTA0RuW>; Mon, 27 Jan 2003 12:50:22 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:15336 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S267260AbTA0RuV>; Mon, 27 Jan 2003 12:50:21 -0500
Date: Mon, 27 Jan 2003 09:59:18 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Christian Zander <zander@minion.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030127175917.GO20972@ca-server1.us.oracle.com>
References: <20030126215714.GA394@kugai> <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 03:46:30PM -0600, Kai Germaschewski wrote:
> it have added -DKBUILD_BASENAME and -DKBUILD_MODNAME, which are required 
> by the new module code. And, how did they avoid subtle breakage like not 
> giving the same switches on the command line? (This list goes on...)

	As opposed to the kernel forcing subtle breakage by specifying
options that break said module?  Don't say that doesn't happen (just
like the kernel has to add/remove compiler switches to make some of its
code work).

> Okay, you have a point here, there's still a bug. vermagic.o will be 
> rebuilt when the version changes or any of the recorded config options 
> change, but it doesn't pick up changes in the compiler version, if the 
> new gcc has the same name.

	IOW, you not only need a kernel source tree (built, no less,
taking up space) but it needs to be writable!

> o One thing I do not understand at all: What is the problem with using
>   the internal build system? It makes maintainance of external modules
>   much easier than keeping track of what happens in the kernel and
>   patching a private solution all the time.

	Well, the Red Hat kernel tree is designed to allow you to build
against there UP, SMP, and large memory kernels from one tree.  In your
example, you require three(!) fully built kernel trees lying around, each
with a different configuration.  That's a lot of space.
	Granted, Red Hat (as our example) can do what they have to do,
since the generic kernel isn't responsible for whatever Red Hat does.
However, even without their setup, in 2.4 all I have to do is keep
around version.h and autoconf.h and I can usually do the right thing
with one completely clean kernel tree.

Joel

-- 

"And yet I fight,
 And yet I fight this battle all alone.
 No one to cry to;
 No place to call home."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

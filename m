Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbTAZRmO>; Sun, 26 Jan 2003 12:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbTAZRmO>; Sun, 26 Jan 2003 12:42:14 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:49352 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266865AbTAZRmN>; Sun, 26 Jan 2003 12:42:13 -0500
Date: Sun, 26 Jan 2003 11:51:22 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Christian Zander <zander@minion.de>
cc: Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
In-Reply-To: <20030126132923.GB396@kugai>
Message-ID: <Pine.LNX.4.44.0301261144430.15538-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2003, Christian Zander wrote:

> Of course, this only holds true for external projects using kbuild to
> build the modules; other build systems would not only require that a
> complete, configured kernel source tree be installed, they would also
> rely on that source tree to be uncleaned since they have no knowledge
> of how init/vermagic.o is to be built (and shouldn't make assumptions,
> not considering possible legal/licensing implications). This I really
> do consider an unnecessary, burdensome prerequisite.

Well, what I'm trying to say is that external build system will always 
break one way or other. Since they're external, they're naturally out of 
reach for me to influence, so there's really nothing I can do it but 
telling people to using the internal system instead.

> Somebody downloaded Linux 2.5.59, configured it and built it using a
> pre-3.0 version of gcc, e.g. gcc 2.95. The user had plenty of disk
> space and decided, based on past experiences, that leaving the source
> tree uncleaned is least likely to cause problems, should he/she ever
> be intersted in building third-party modules. For some time, the user
> placed no interest in external modules and used his/her system quite
> happily; with the release of a new, improved version of a driver, the
> user decided that he wants to give it a try, however, and built the
> driver module, which picked up init/vermagic.o; our imaginary user is
> using a distribution that provides frequent updates and he/she makes
> regular use of this service - it just so happens that one of these
> updates installed gcc 3.0 as the new default compiler. The new module
> is thus built using gcc 3.0, but init/vermagic.o still indicates gcc
> 2.95; the module loader will erroneously believe everything is fine.

Again, when you're using your own external build system, it's up to you to 
mess it up in all possible ways, the above being one of them.

When you're using the kernel build, the above cannot happen, since the 
kernel build system knows about this dependency and builds a new 
init/vermagic.o with the correct information before it gets linked into 
the external module.

--Kai



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267216AbSKSUmR>; Tue, 19 Nov 2002 15:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267217AbSKSUmJ>; Tue, 19 Nov 2002 15:42:09 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:33697 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267216AbSKSUlp>; Tue, 19 Nov 2002 15:41:45 -0500
Date: Tue, 19 Nov 2002 14:48:09 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Larry McVoy <lm@bitmover.com>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Sam Ravnborg <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [RFC/CFT] Separate obj/src dir
In-Reply-To: <20021119123115.C16028@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0211191444400.24137-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Larry McVoy wrote:

> On Tue, Nov 19, 2002 at 03:22:45PM -0500, Richard B. Johnson wrote:
> > On Tue, 19 Nov 2002, Sam Ravnborg wrote:
> > 
> > > Based on some initial work by Kai Germaschewski I have made a
> > > working prototype of separate obj/src tree.
> > > 
> > > Usage example:
> > > #src located in ~/bk/linux-2.5.sepobj
> > > mkdir ~/compile/v2.5
> > > cd ~/compile/v2.5
> > > sh ../../kb/v2.5/kbuild
> > 
> > [SNIPPED...]
> > 
> > I have a question; "What problem is this supposed to solve?"
> > This looks like a M$ism to me. Real source trees don't
> > look like this. If you don't have write access to the source-
> > code tree, you are screwed on a real project anyway. That's
> > why we have CVS, tar and other tools to provide a local copy.
> 
> It can be really nice to maintain a bunch of different architectures at
> the same time from the same tree.  It also makes it really easy to 
> "clean" a tree.
> 
> On the other hand, I do wonder whether ccache could be used to get the
> same effect.  Sam?

ccache helps a lot if you change your .config back to one previously 
compiled, but it still doesn't offer you the option to keep multiple 
.configs around at the same time.

Also, of course it doesn't help with keeping the source tree clean of 
non-source files ;)

Wrt the original patch, I like it, one preliminary comment is that I think
symlinks are nicer than copying. They are faster, shouldn't cause any
trouble on NFS, make uses "stat" and not "lstat", so it gets the
timestamps right, too. And if you edit a Makefile/Kconfig in the source
tree, you rather want that to take effect immediately, I guess ;)

--Kai



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbSJCOW0>; Thu, 3 Oct 2002 10:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbSJCOW0>; Thu, 3 Oct 2002 10:22:26 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:10129 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261401AbSJCOWZ>; Thu, 3 Oct 2002 10:22:25 -0400
Date: Thu, 3 Oct 2002 09:27:49 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: John Levon <levon@movementarian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: RfC: Don't cd into subdirs during kbuild
In-Reply-To: <20021003140530.GA56233@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0210030922270.24570-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, John Levon wrote:

> On Wed, Oct 02, 2002 at 09:59:00PM -0500, Kai Germaschewski wrote:
> 
> > ChangeSet@1.676, 2002-10-02 14:42:00-05:00, kai@tp1.ruhr-uni-bochum.de
> >   kbuild: Remove xfs vpath hack
> 
> Why is it a hack ?

Since it gives Rules.make the wrong file names in $(obj-[ym]), and relies 
on implementation details inside of Rules.make in combination with the 
vpath statement to make things work despite those wrong names. 

> >   xfs.o is built as one modules out of objects distributed into
> >   multiple subdirs. That is okay with the current kbuild, you just
> >   have to include the path for objects which reside in a subdir, then.
> >   
> >   xfs used vpath instead of explicitly adding the paths, which is
> >   inconsistent and conflicts e.g. with proper module version generation.
> 
> So I must name the full path for each object in drivers/oprofile/ I
> include from arch/i386/oprofile/ then ?

So did you decide to move things from drivers/oprofile/$(ARCH) to 
arch/$(ARCH)/oprofile? It's possible to make it work, but not pretty. As I 
said before, kbuild actually expects to have all parts of a single module 
to be in a single dir. This can be lifted a little bit as done for xfs, 
but spreading parts all over the tree is not very desirable IMO.

--Kai



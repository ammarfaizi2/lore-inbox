Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317324AbSGTCGm>; Fri, 19 Jul 2002 22:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSGTCGm>; Fri, 19 Jul 2002 22:06:42 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:21888 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317324AbSGTCGl>; Fri, 19 Jul 2002 22:06:41 -0400
Date: Fri, 19 Jul 2002 21:09:43 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: John Levon <movement@marcelothewonderpenguin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild - building a module/target from multiple directories
In-Reply-To: <20020720015215.GA43258@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0207192100100.1639-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002, John Levon wrote:

> On Fri, Jul 19, 2002 at 08:23:36PM -0500, Kai Germaschewski wrote:
> 
> > > With kbuild in 2.5, how do I specify that a module/target is to be built of
> > > object files and sub-directories ?
> > 
> > Short answer: Don't.
> 
> Why not ? Simply because kbuild can't handle it nicely ?

Well, if you see the parts of your project as really separate, it probably 
makes sense to do the modularization also at the module level, i.e. have 
your project use some number of modules which can be split into subdirs 
without problems.

If it's all logically only one thing (as linking it all into just one
module implies), then why not put it into just one directory - maybe using
some prefix to the filenames to distinguish separate entities (e.g.
lowlevel ll_* highlevel hl_*). drivers/net has 145 .c files, I doubt
you'll have more than that ;)

I made kbuild handle this case (in the way above) for XFS, but in a way
it's against the normal way how the source is organized in the kernel
tree, and I don't see a good reason to change that. Dirs are used as
higher level containers, like "fs" all file system-specific things and
then fs/{ext2,nfs,...} with one file system per dir.

--Kai



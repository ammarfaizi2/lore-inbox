Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317469AbSF1RWS>; Fri, 28 Jun 2002 13:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317470AbSF1RWR>; Fri, 28 Jun 2002 13:22:17 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:3087 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317469AbSF1RWR>;
	Fri, 28 Jun 2002 13:22:17 -0400
Date: Fri, 28 Jun 2002 19:28:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, mec@shout.net,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: menuconfig and config uses $objtree
Message-ID: <20020628192807.A2142@mars.ravnborg.org>
References: <20020628001452.A14485@mars.ravnborg.org> <31443.1025230740@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <31443.1025230740@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Fri, Jun 28, 2002 at 12:19:00PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2002 at 12:19:00PM +1000, Keith Owens wrote:
> On Fri, 28 Jun 2002 00:14:52 +0200, 
> Sam Ravnborg <sam@ravnborg.org> wrote:
> >In order to prepare for separate obj and src trees make use of $objtree
> >within scripts/Menuconfig and scripts/Configure.
> >All temporary and all result files are located in directory pointed at
> >by $objtree.
> >
> >This functionality is foreseen useful for both current kbuild and kbuild-2.5
> 
> Wrong approach.  This messes up kbuild 2.5.  The config tools should
> not know where the files are being read from or written to, you have
> hard coded knowledge about the tree structure into the config system.
Thanks for the feedback.
And I agree with you 100% that the config tools shall not
know where the files are being read, nor where they are being written.

> kbuild 2.5 handles this by constructing a set of symlinks then invoking
> the configure system under those symlinks, followed by copying any
> results to their destination.  The symlink tree completely isolates
> the config system from any knowledge of where its inpuuts and outputs
> really are, everything looks local.
I noticed this 'magic' in kbuild-2.5.
As you see a lot of cruft is required to circumvent the fact that the
current config tools are hardcoded to read from current directory
and hardcoded to write to current directory.

> You have a 750+ line patch to imbed tree knowledge into configure, that
> knowledge will have to be duplicated for any new CML tools.  kbuild 2.5
> does it in a few lines of scripts/Makefile-2.5 which automatically
> works for any new CML code.
Did you look in the patch?
It basically teach the config tools that the SRC are no longer
in current directory but pointed out by $srctree, that output files
are pointed out by $objtree, and temporary files the same place.

No nasty tricks with sym-lnks required, no copy files around before
or after the config tools are used. No specific directories that
needs to be created beforehand.
Indeed my approach is a number of lines - but that on the other hand
simplify the usage of the config tools.

But I see your point that we should avoid hardcoding too much
knowledge in the config tools, and I may change the patch to
use command-line parameters to specify SRC and OBJ dirs.

	Sam

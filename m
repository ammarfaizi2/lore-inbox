Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262724AbSJCD3T>; Wed, 2 Oct 2002 23:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262725AbSJCD3T>; Wed, 2 Oct 2002 23:29:19 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:28146 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262724AbSJCD3S>; Wed, 2 Oct 2002 23:29:18 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 2 Oct 2002 21:32:29 -0600
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021003033229.GC3000@clusterfs.com>
Mail-Followup-To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02, 2002  21:59 -0500, Kai Germaschewski wrote:
> The build process remains recursive, but it changes the recursion
> from 
> 	make -C subdir
> to
> 	make -f subdir/Makefile
> 
> i.e. the current working directory remains the top dir for all times. So 
> gcc/ld/.. are now called from the topdir, allowing to closer resemble 
> a non-recursive build. Some Makefiles may need a little additional 
> tweaking (in particular arch/*), but generally, the changes required are 
> pretty small.

This is nice, because if you are doing "make -j[n]" you currently get
dumped into the wrong file (or just some non-existent file in the wrong
directory) on build warnings and errors (when compiling under vim/emacs)
because e.g. the "make[1]: entering directory fs/ext3" message was
followed by "make[1]: entering directory fs/msdos", while still
compiling files in fs/ext3.

Granted, this isn't a great reason to change, but it bugs me every
day.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/


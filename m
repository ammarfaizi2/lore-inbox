Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVI2CCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVI2CCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 22:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVI2CCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 22:02:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60138 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932078AbVI2CCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 22:02:24 -0400
Date: Thu, 29 Sep 2005 04:02:21 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Documentation: getting and installing git
Message-ID: <20050929020221.GN30883@pasky.or.cz>
References: <200509290305.01625.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509290305.01625.jesper.juhl@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I think Pavel Machek had some short git HOWTO as well, so I'm Cc'ing him.

  In general, I think it's not a good idea to just duplicate GIT
documentation in the kernel tree. If you think the GIT documentation is
insufficient or is missing some "quick start" document, it'd be more
reasonable to submit patches for GIT, but I'd keep kernel's GIT
documentation to kernel-specific usage and tips'n'tricks.

Dear diary, on Thu, Sep 29, 2005 at 03:05:01AM CEST, I got a letter
where Jesper Juhl <jesper.juhl@gmail.com> told me that...
> --- /dev/null	2005-09-28 20:05:57.000000000 +0200
> +++ linux-2.6.14-rc2-git3/Documentation/get-and-install-git.txt	2005-09-29 02:57:59.000000000 +0200
> @@ -0,0 +1,130 @@
> +	Getting and installing `git` and pulling your first tree
> +	--------------------------------------------------------
> +	
> +		(Writen by Jesper Juhl, September 2005)
> +
> +
> +This document describes how to obtain and install the `git` tool used (among
> +other things) to manage the Linux kernel source tree. It also shows you how
> +to use git to pull down your first copy of the vanilla Linux kernel source
> +(current git head version).

  Since you're cc'ing me, you'll get a shameless plug. ;-) What about
some decent short notice like:

	Note that you might prefer to use one of the simpler user interfaces
	available for GIT, e.g. the Cogito layer or StGIT patch manager. See
	the GIT homepage for details.

> +Those who already have an older version of git can grab a newer version with
> +	it clone http://www.kernel.org/pub/scm/git/git.git LOCALDIR

  Missing leading 'g'.

> +To obtain the latest git source snapshot go to this URL: 
> +	http://www.codemonkey.org.uk/projects/git-snapshots/git/
> +and download the latest version (at the time of this writing the exact filename
> +is git-2005-09-29.tar.gz, but a symlink called git-latest.tar.gz is also
> +provided that will always pull the latest git source regardless of its actual
> +filename).

  I think recommending the latest development snapshot instead of the
latest release is a really bad idea if you don't have some really
compelling reason to do so. The snapshot can be variously broken and
buggy, while a release gives you some stable reference point and path
from it you can follow.

...
> +At this point you should have git installed and available in your PATH.

  Perhaps you might rather want to extend GIT's INSTALL file?

> +Now it's time to download your first kernel source tree. To do that you should
> +first change into the directory where you want to store the kernel source in a
> +subdir. I'll assume you want to keep kernel source in ~/linux-kernel, so do
> +this : 
> +
> +	$ mkdir ~/linux-kernel ; cd ~/linux-kernel
> +
> +Now let's use git to download the latest git HEAD (the current head of Linus'
> +development tree). Execute these commands to do this :
> +
> +	$ git clone \
> +	  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
> +	  linux-2.6
> +	$ cd linux-2.6
> +	$ rsync -a --verbose --stats --progress \
> +	  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
> +	  .git/

Why the second rsync command? If you are after tags and other heads, you
can run it just on .git/refs/.

But actually, it is very dangerous. Never ever run it later than right
after the initial clone (ignore what the "Kernel Hackers' Guide to git"
tells you!). If you did any local commits, it will likely trash them,
and if you didn't, it will probably completely confuse the tools which
care about updating your working tree with new changes.

> +When the download finishes you'll have a brand sparkling new git HEAD linux
> +kernel source tree in ~/linux-kernel/linux-2.6

[Nitpick] I'm not a native English speaker, but I think "brand new
sparkling" is more right.

> +If you want to do a git bisection search to find what patch caused a problem,
> +please see the Documentation/git-bisect.txt document in the git source tree.
> +You may also want to read and/or use Documentation/git-bisect-script.txt

This notice would be quite useful in the rather antique
Documentation/BUG-HUNTING file.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275485AbRJHCt2>; Sun, 7 Oct 2001 22:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275693AbRJHCtR>; Sun, 7 Oct 2001 22:49:17 -0400
Received: from rj.sgi.com ([204.94.215.100]:40346 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S275485AbRJHCtD>;
	Sun, 7 Oct 2001 22:49:03 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.11-pre4 remove spurious kernel recompiles 
In-Reply-To: Your message of "Mon, 08 Oct 2001 04:12:15 +0200."
             <20011008041215.O726@athlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 12:49:25 +1000
Message-ID: <440.1002509365@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001 04:12:15 +0200, 
Andrea Arcangeli <andrea@suse.de> wrote:
>On Mon, Oct 08, 2001 at 11:34:04AM +1000, Keith Owens wrote:
>The main thing I like is to be able to compile out of the tree and
>avoiding touching the header files during compilation (that's really
>annoying).

All fixed in kbuild 2.5.

>I personally don't care about correctness in the sense of getting "make"
>doing everything for you regardless of what you changed, I'm fine with
>some "make distclean" forced checkpoint after PATCHLEVEL changed etc...,
>you said infact full compile is needed sometime, not to tell about
>kernel configuration.

Strongly disagree.  One of the biggest problems with kbuild is the user
who applies a patch and expects the kernel to automatically rebuild
just the bits that are affected.  We must not rely on every user doing
make distclean or mrproper after applying a patch, we know that does
not happen, resulting in inconsistent kernels.  If you want to do a
complete recompile after a patch that is your choice, but we cannot
rely on the entire user population doing that.  kbuild must be
automatic and correct.

>One good example is the mkdep hack, it's far from correct: the header
>dependences is nearly random.  We cannot trust it unless we remeber
>every user included us (one more reason I'm used to full recompiles),

Absolutely agree.  The design assumption for mkdep is that the source
and/or .config do not change after make dep.  That might have been true
once but with several kernel trees, separate arch patches, separate sub
system patches and compiling for multiple configurations it is not true
now.  kbuild 2.5 completely redesigned the dependency tree and gets it
right!

However we are getting off the original patch which removes spurious
compiles from the existing system.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266432AbSKGJ41>; Thu, 7 Nov 2002 04:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266433AbSKGJ40>; Thu, 7 Nov 2002 04:56:26 -0500
Received: from surf.cadcamlab.org ([156.26.20.182]:12440 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S266432AbSKGJ40>; Thu, 7 Nov 2002 04:56:26 -0500
Date: Thu, 7 Nov 2002 04:00:21 -0600
To: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kbuild] Possibility to sanely link against off-directory .so
Message-ID: <20021107100021.GL4182@cadcamlab.org>
References: <20021106185230.GD5219@pasky.ji.cz> <20021106212952.GB1035@mars.ravnborg.org> <20021106220347.GE5219@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106220347.GE5219@pasky.ji.cz>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Petr Baudis]
> Can't say anything about the C++ stuff, but the second user of shared
> libraries is going to be lxdialog - hopefully this evening already,
> in my patches (it already works, I'm only cleaning out few details
> now; lxdialog + mconf is also user of both these extensions).

What is so all-fired great about shared libraries anyway?  It's not
like our burning need is to save memory when two people run 'make
menuconfig' in parallel.  What's wrong with 'ar cq libxxx.a $(OBJS)'
anyway?  It's fast, it's easy, it's portable, and you never have to
worry about things like LD_LIBRARY_PATH or `-rpath'.

Sure, with Linux you can create a shared library with 'gcc -shared' ...
but what about bootstrapping a Linux kernel from a legacy OS?  (Yes,
people do compile Linux on Solaris, for example.)  HOSTCC may or may
not be gcc, and if it is, it may or may not support creating shared
libraries, and if it does, you might need funky flags or variables to
denote the link-time or run-time search path.  Why bother?  `ar' is
basically universal, both in availability and usage.  (Well, *almost*
universal usage: if you want to run 'ranlib', be prepared for it not to
exist.)

Basically, what I'm saying is, I see no need for the existing .so in
the kernel build, much less another one.  Static libraries are ever so
much easier to manage.

Peter

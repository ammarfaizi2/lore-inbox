Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWEEEza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWEEEza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 00:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWEEEza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 00:55:30 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:51979 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932463AbWEEEza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 00:55:30 -0400
Date: Fri, 5 May 2006 06:55:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Merillat <harik.attar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kbuild + Cross compiling
Message-ID: <20060505045529.GA17896@mars.ravnborg.org>
References: <c0c067900605041852m50e04171x7fd1579e77c9d5a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c067900605041852m50e04171x7fd1579e77c9d5a3@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 09:52:56PM -0400, Dan Merillat wrote:
> I must be an idiot, but why does Kbuild rebuild every file when 
> cross-compiling?
> I'm not editing .config or touching any headers, I'm making tweaks to
> a single .c driver,
> and it is taking forever due to continual full-rebuilds.
> 
> building on i386 for ARCH=arm CROSS_COMPILE=arm-linux-uclibc-
> 
> I tried following the logic, but everything is a forced build using
> if_changed and if_changed_dep, and I can't read GNU Make well enough
> to figure out what it thinks is new.  I know make -d says all the
> dependancies are up-to-date, so it's being forced some other way.
kbuild checks for any differences in the commandline alos - so a rebuild
happens if you change options to gcc (think -O2 => -Os).
If you experience that for example mm/slab.c is rebuild then try to
do the following:
cp mm/.slab.o.cmd foo
make mm/
diff -u foo mm/.slab.o.cmd

If diff detects any difference then you know why and need to find out
why there is a difference.

Btw. what make version and what kernel version are you compiling?
There was some inconsistency in kbuild that triggered with make 3.81-rc1
and which will trigger with make 3.82-cvs also.
This issue was only fixed lately - recall it was for 2.6.16

	Sam

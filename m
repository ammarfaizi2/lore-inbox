Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbUDSUsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUDSUsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUDSUsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:48:36 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:15910 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262041AbUDSUsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:48:32 -0400
Date: Mon, 19 Apr 2004 22:58:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: build system broken in 2.6.6rc1 for external modules?
Message-ID: <20040419205817.GA2090@mars.ravnborg.org>
Mail-Followup-To: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
	linux-kernel@vger.kernel.org, zippel@linux-m68k.org
References: <200404191956.53184.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404191956.53184.arekm@pld-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 07:56:52PM +0200, Arkadiusz Miskiewicz wrote:

[Please send kbuild related stuff to me. Roman is not kbuild maintainer].

> On 2.6.5 this works fine (/usr/src/linux is read only and make mrproper'ed):
> 
> ln -sf %{_kernelsrcdir}/config-up .config
> install -d include/{linux,config}
> ln -sf %{_kernelsrcdir}/include/linux/autoconf-up.h include/linux/autoconf.h
> ln -sf %{_kernelsrcdir}/include/asm-%{_arch} include/asm
> touch include/config/MARKER
> %{__make} -C %{_kernelsrcdir} scripts modules \
>         SUBDIRS=$PWD \
>         O=$PWD \
>         V=1

The way to build modules are now:

cd $KERNELSRCDIR
make
make clean

cd $MODULEDIR
make -C KERNELSRCDIR M=$PWD

This will work even with MODVERSIONING turned on.

There is currently a glitch that requires you to have defined
at least one module in the kernel. net/dummy for example.
When next round of patched are in you will not need to build the full kernel either.

If you do not want (cannot) build the kernel in the $KERNELSRCDIR
then you can use:

cd $KERNELSRCDIR
copy config-up ~/build
make O=~/build
make O=~/build clean

cd $MODULEDIR
make -C KERNELSRCDIR O=~/build M=$PWD


Hope this clarifies it.

	Sam

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWGAXGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWGAXGr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 19:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWGAXGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 19:06:47 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:17898 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751543AbWGAXGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 19:06:46 -0400
Date: Sun, 2 Jul 2006 01:06:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
Message-ID: <20060701230635.GA19114@mars.ravnborg.org>
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com> <1151788673.3195.58.camel@laptopd505.fenrus.org> <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com> <1151789342.3195.60.camel@laptopd505.fenrus.org> <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com> <a44ae5cd0607011556t65b22b06m317baa9a47ff962@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0607011556t65b22b06m317baa9a47ff962@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >> > > >
> >> > > >   KLIBCLD usr/klibc/libc.so
> >> > > > usr/klibc/execl.o: In function `execl':
...
 >
> >https://wiki.ubuntu.com/GccSsp
> >
> >It appears that Ubuntu's Edgy Eft (the development tree) now contains
> >"Stack Smashing Protection" enabled by default.  I found a web page
> >that states that -fno-stack-protector can be used to disable this
> >functionality.  Interestingly, another web page stated that SSP has
> >been enabled in Redhat compilers for a long time and is now also
> >enabled in Debian SID.  Perhaps -fno-stack-protector should be added
> >to the kernel build be default?
> 
> Darn it.  I don't seem to know how to get -fno-stack-protector to
> work.  I ran:
> export CFLAGS=-fno-stack-protector
> make mrproper
> cp ../.config .
> make oldconfig
> CFLAGS=-fno-stack-protector make all install modules modules_install
> 
> But I am still getting the errors.  Anyone know what I am doing wrong?

For klibc you need to patch scripts/Kbuild.klibc

Appending it to KLIBCWARNFLAGS seems the right place.

Do you know from what gcc version we can start using -fno-stack-protector?

	Sam

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbUJaG36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbUJaG36 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 01:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbUJaG36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 01:29:58 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:12493 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261510AbUJaG3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 01:29:54 -0500
Date: Sun, 31 Oct 2004 07:29:53 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Alessandro Amici <lists@b-open-solutions.it>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: massive cross-builds without too much PITA
Message-ID: <20041031062953.GB10597@mail.13thfloor.at>
Mail-Followup-To: Alessandro Amici <lists@b-open-solutions.it>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20041028054833.GP24336@parcelfarce.linux.theplanet.co.uk> <200410281821.22486.lists@b-open-solutions.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410281821.22486.lists@b-open-solutions.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 06:21:22PM +0200, Alessandro Amici wrote:
> 
> Al,
> 
> I happen to be learning how to cross-compile on Debian right now, so i can 
> testify that building the cross toolchain 'The Debian Way' is even easier 
> than you describe ;).
> 
> On Thursday 28 October 2004 07:48, Al Viro wrote:
> > Building cross-toolchain is surprisingly easy these days; I'm using debian
> > on build boxen and cross-compilers are not hard to do:
> >  apt-get build-dep binutils
> >  apt-get build-dep gcc-3.3
> >  apt-get install dpkg-cross
> >  apt-get source binutils
> >  get binutils-cross-... patch from bugs.debian.org/231707
> >  cd binutils-...
> >  apply patch
> >  TARGET=<target>-linux fakeroot debian/rules binary-cross
> >  cd ..
> >  dpkg -i binutils-<target>-....deb
> >  got linux-kernel-headers, libc6, libc6-dev and libdb1-compat for target
> >  dpkg-cross -a <target> -b on all of those
> >  dpkg -i resulting packages
> >  apt-get source gcc-3.3
> >  cd gcc-3.3-...
> >  GCC_TARGET=<gcc_target> debian/rules control
> >  GCC_TARGET=<gcc_target> debian/rules build
> >  GCC_TARGET=<gcc_target> fakeroot debian/rules binary
> >  cd ..
> >  dpkg -i resulting packages.
> > One note: <target> here is debian platform name (e.g. ppc), but
> > <gcc_target> is *gcc* idea of what that bugger is called (e.g. powerpc).
> >
> > IIRC, Nikita Youshchenko had pre-built debs somewhere, but they were not
> > for the host I'm using (amd64/sid).
> 
> The package toolchain-source (together with dpkg-cross) makes the process even 
> more automatic. Detailed instructions are at:
> http://people.debian.org/~debacle/cross.html
> 
> The short story is:
> # apt-get toolchain-source dpkg-cross autoconf2.13 fakeroot
> # tpkg-install-libc <terget>-linux # grabs, converts and install the headers
> $ tpkg-make <target>-linux  # no need to patch anything
> $ cd binutils...
> $ debuild -us -uc    # no magic env variables
> # dpkg -i ../binutils...deb
> $ cd ../gcc...
> $ debuild -us -uc
> # dpkg -i ../gcc...deb
> 
> If I'm not mistaken, that's all.
> 
> > In practical terms it means no ppc64.
> 
> Sadly right! guess which platform I needed to cross compile :-/

http://vserver.13thfloor.at/Stuff/Cross/howto.info
(don't forget to apply the 'fixes' from
 http://vserver.13thfloor.at/Stuff/Cross/)

HTH,
Herbert

> Cheers,
> Alessandro
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

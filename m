Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbUJ1QXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbUJ1QXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbUJ1QXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:23:25 -0400
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:30945 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261722AbUJ1QVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:21:48 -0400
From: Alessandro Amici <lists@b-open-solutions.it>
Organization: B-Open Solutions srl
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: massive cross-builds without too much PITA
Date: Thu, 28 Oct 2004 18:21:22 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20041028054833.GP24336@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041028054833.GP24336@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410281821.22486.lists@b-open-solutions.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Al,

I happen to be learning how to cross-compile on Debian right now, so i can 
testify that building the cross toolchain 'The Debian Way' is even easier 
than you describe ;).

On Thursday 28 October 2004 07:48, Al Viro wrote:
> Building cross-toolchain is surprisingly easy these days; I'm using debian
> on build boxen and cross-compilers are not hard to do:
>  apt-get build-dep binutils
>  apt-get build-dep gcc-3.3
>  apt-get install dpkg-cross
>  apt-get source binutils
>  get binutils-cross-... patch from bugs.debian.org/231707
>  cd binutils-...
>  apply patch
>  TARGET=<target>-linux fakeroot debian/rules binary-cross
>  cd ..
>  dpkg -i binutils-<target>-....deb
>  got linux-kernel-headers, libc6, libc6-dev and libdb1-compat for target
>  dpkg-cross -a <target> -b on all of those
>  dpkg -i resulting packages
>  apt-get source gcc-3.3
>  cd gcc-3.3-...
>  GCC_TARGET=<gcc_target> debian/rules control
>  GCC_TARGET=<gcc_target> debian/rules build
>  GCC_TARGET=<gcc_target> fakeroot debian/rules binary
>  cd ..
>  dpkg -i resulting packages.
> One note: <target> here is debian platform name (e.g. ppc), but
> <gcc_target> is *gcc* idea of what that bugger is called (e.g. powerpc).
>
> IIRC, Nikita Youshchenko had pre-built debs somewhere, but they were not
> for the host I'm using (amd64/sid).

The package toolchain-source (together with dpkg-cross) makes the process even 
more automatic. Detailed instructions are at:
http://people.debian.org/~debacle/cross.html

The short story is:
# apt-get toolchain-source dpkg-cross autoconf2.13 fakeroot
# tpkg-install-libc <terget>-linux # grabs, converts and install the headers
$ tpkg-make <target>-linux  # no need to patch anything
$ cd binutils...
$ debuild -us -uc    # no magic env variables
# dpkg -i ../binutils...deb
$ cd ../gcc...
$ debuild -us -uc
# dpkg -i ../gcc...deb

If I'm not mistaken, that's all.

> In practical terms it means no ppc64.

Sadly right! guess which platform I needed to cross compile :-/

Cheers,
Alessandro

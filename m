Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbUBXByr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUBXByr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:54:47 -0500
Received: from relay.pair.com ([209.68.1.20]:2309 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261958AbUBXByo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:54:44 -0500
X-pair-Authenticated: 24.126.73.164
Message-ID: <403AADA9.3040803@kegel.com>
Date: Mon, 23 Feb 2004 17:49:29 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Jim Wilson <wilson@specifixinc.com>, linux-kernel@vger.kernel.org,
       Judith Lebzelter <judith@osdl.org>, cliff white <cliffw@osdl.org>,
       "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: Kernel Cross Compiling [update]
References: <20040222035350.GB31813@MAIL.13thfloor.at> <1077565352.1054.22.camel@leaf.tuliptree.org> <20040223203257.GA9800@MAIL.13thfloor.at>
In-Reply-To: <20040223203257.GA9800@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
> my primary goal isn't to get this fixed by the gcc folks,
> I want to have a simple and working solution, which seems
> to be at hand for the toolchains, to cross compile the
> linux kernel for testing purposes. the changes so far are
> not very intrusive IMHO, and I can live with a few patches.
> (btw. currently Dan Kegel has a lot more patches to gcc in 
> his toolchain than I do)

My crosstool package has very, very few patches, and each patch is carefully documented.
(You can see them at http://kegel.com/crosstool/current/patches/gcc-3.3.2/ )
The patches that end in -test.patch simply add testcases to the gcc
regression test.  Several of the other patches simply fix testsuite problems.
The only patches that actually affect gcc are

http://kegel.com/crosstool/current/patches/gcc-3.3.2/gcc-3.3.2-arm-softfloat.patch
http://kegel.com/crosstool/current/patches/gcc-3.3.2/sh-lib1funcs_sizeAndType.patch
http://kegel.com/crosstool/current/patches/gcc-3.3.2/sh-libgcc-hidden.patch
http://kegel.com/crosstool/current/patches/gcc-3.3.2/sh-pic-set_fpscr-gcc-3.3.2.patch

I only add a patch after I have verified that it fixes a problem,
and I document what that problem is at the top of the patch;
when possible, the patch starts with a link to gcc's bugzilla for
the problem it fixes.
Fairly often, my patches are simply backports from cvs.

Debian, by comparison, builds gcc with huge collections of patches that are not
documented at all.  Likewise, Red Hat uses quite a few patches.
I don't want to say the Debian and Red Hat compilers are bad,
but I *do* want to say that crosstool builds compilers that are
extremely close to vanilla, with all departures from vanilla carefully documented.

By the way, I agree with Jim Wilson's remark:
 > As a gcc
 > maintainer, it makes my job harder when people are building the compiler
 > different ways, because I may get bug reports that I can't reproduce or
 > understand.  Also, there is a risk that a kernel-only cross compiler
 > will accidentally be used for some other purpose, resulting in a bug
 > report that wastes the time of the gcc maintainers.

That's why I suspect crosstool is a good toolchain for anyone who
wants to report bugs to the gcc folks; it's tightly controlled,
very close to vanilla, and has support for (gasp) running the gcc
and glibc testsuites in a cross-development environment.

- Dan

-- 
US citizens: if you're considering voting for Bush, look at these first:
http://www.misleader.org/
http://www.cbc.ca/news/background/arar/
http://www.house.gov/reform/min/politicsandscience/

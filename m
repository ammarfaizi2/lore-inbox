Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312988AbSDERxk>; Fri, 5 Apr 2002 12:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313347AbSDERxa>; Fri, 5 Apr 2002 12:53:30 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:61174
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312988AbSDERxZ>; Fri, 5 Apr 2002 12:53:25 -0500
Date: Fri, 5 Apr 2002 09:55:27 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup KERNEL_VERSION definition and linux/version.h
Message-ID: <20020405175527.GK961@matchmail.com>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020405020752.GJ961@matchmail.com> <3034.1017974559@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >On Thu, Apr 04, 2002 at 11:36:06AM +1000, Keith Owens wrote:
> >> No, but version.h is working at the moment in 2.4.  Why change it?
> >

> On Thu, 4 Apr 2002 18:07:52 -0800, 
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> >Why do so many drivers enable options depending on the kernel version?
> >Shouldn't that be stripped out before a patch is accepted into the kernel?
> 

On Fri, Apr 05, 2002 at 12:42:39PM +1000, Keith Owens wrote:
> >From kbuild 2.5 top level Makefile.
> 
> # FIXME: Current kernel source includes linux/version.h, mainly to get
> # KERNEL_VERSION().  version.h also includes UTS_RELEASE which changes every
> # time the kernel identifiers change.  The presence of UTS_RELEASE in version.h
> # causes lots of unnecessary recompilations, very few places actually want
> # UTS_RELEASE.  The new makefile generates separate linux/version.h and
> # linux/uts_release.h, with version.h including utsname.h to avoid compilation
> # errors.  Find all the source code that needs just UTS_RELEASE and change it to
> # include uts_release.h, then remove #include <linux/uts_release.h> from the
> # commands below.  KAO
> 
> Unfortunately this area of kbuild 2.4 is fragile.  At the moment,
> changes to the top level Makefile indirectly force a rebuild,
> Makefile -> version.h -> KERNEL_VERSION() -> almost everything.
> 
> Breaking that chain _might_ cause problems in 2.4 because it does not
> have a complete dependency chain to pick up changes to the top level
> Makefile, it only works at the moment due to the extra recompiles.  I
> am not willing to change this in 2.4 until I have got it stable in 2.5.

Sounds like a good plan to work on 2.5 first.

Hmm.  It looks like kbuild 2.5 might be able to be split up into a few
separate parts.  Do you think so too?

Do you know where I could find some good documentation on Makefiles?
Especially on dependencies and etc?

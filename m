Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311244AbSDECnI>; Thu, 4 Apr 2002 21:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311264AbSDECm6>; Thu, 4 Apr 2002 21:42:58 -0500
Received: from rj.SGI.COM ([204.94.215.100]:56295 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S311244AbSDECmy>;
	Thu, 4 Apr 2002 21:42:54 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup KERNEL_VERSION definition and linux/version.h 
In-Reply-To: Your message of "Thu, 04 Apr 2002 18:07:52 PST."
             <20020405020752.GJ961@matchmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Apr 2002 12:42:39 +1000
Message-ID: <3034.1017974559@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002 18:07:52 -0800, 
Mike Fedyk <mfedyk@matchmail.com> wrote:
>On Thu, Apr 04, 2002 at 11:36:06AM +1000, Keith Owens wrote:
>> On Thu, 04 Apr 2002 10:12:29 +0900, 
>> Hiroyuki Toda <might@might.dyn.to> wrote:
>> >
>> >Keith> This file will change completely in 2.5 when kbuild 2.5 goes in.  Why
>> >Keith> does it need to be rearranged in 2.4?
>> >
>> >Will kbuild 2.5 go in 2.4 tree also?
>> 
>> No, but version.h is working at the moment in 2.4.  Why change it?
>
>Why do so many drivers enable options depending on the kernel version?
>Shouldn't that be stripped out before a patch is accepted into the kernel?

>From kbuild 2.5 top level Makefile.

# FIXME: Current kernel source includes linux/version.h, mainly to get
# KERNEL_VERSION().  version.h also includes UTS_RELEASE which changes every
# time the kernel identifiers change.  The presence of UTS_RELEASE in version.h
# causes lots of unnecessary recompilations, very few places actually want
# UTS_RELEASE.  The new makefile generates separate linux/version.h and
# linux/uts_release.h, with version.h including utsname.h to avoid compilation
# errors.  Find all the source code that needs just UTS_RELEASE and change it to
# include uts_release.h, then remove #include <linux/uts_release.h> from the
# commands below.  KAO

Unfortunately this area of kbuild 2.4 is fragile.  At the moment,
changes to the top level Makefile indirectly force a rebuild,
Makefile -> version.h -> KERNEL_VERSION() -> almost everything.

Breaking that chain _might_ cause problems in 2.4 because it does not
have a complete dependency chain to pick up changes to the top level
Makefile, it only works at the moment due to the extra recompiles.  I
am not willing to change this in 2.4 until I have got it stable in 2.5.


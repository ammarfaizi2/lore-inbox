Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288015AbSABXW3>; Wed, 2 Jan 2002 18:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288017AbSABXU1>; Wed, 2 Jan 2002 18:20:27 -0500
Received: from svr3.applink.net ([206.50.88.3]:10761 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287989AbSABXSv>;
	Wed, 2 Jan 2002 18:18:51 -0500
Message-Id: <200201022317.g02NHwSr023105@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: skidley <skidley@crrstv.net>, Timothy Covell <timothy.covell@ashavan.org>
Subject: Re: system.map
Date: Wed, 2 Jan 2002 17:14:17 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Keith Owens <kaos@ocs.com.au>, adrian kok <adriankok2000@yahoo.com.hk>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.43.0201021853300.2334-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.43.0201021853300.2334-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 17:01, skidley wrote:
> On Wed, 2 Jan 2002, Timothy Covell wrote:
> > However, I'm concerned about searching in "/usr/src/linux" for it.
> > Linus has taken great pains to point out that we shouldn't be building
> > our kernels in /usr/src/linux, it would seem that this is reenforcing a
> > mistake.
>
> I'm curious as to why kernels shouldn't be built in /usr/src/linux. Also
> this may be a dumb question but if I have built my kernels in /usr/src and
> want to move them to /home for eg. will that screw up things? Installing
> some apps from source sometimes they search for the kernel source during
> configure. If a kernel was compiled and moved to a different dir will this
> matter?

The issue was that libc include files could step on kernel include
files due to symlinks in /usr/include/linux to /usr/src/linux/include.
IIRC the issue is that include files must point to those with which
the libc was compiled for proper userland compilations.   

The latest File Hierarchy Standard states that for glibc based systems,
/usr/src can be whatever it wants but that for libc5 based systems,

6.1.7 /usr/include :
Header files included by C programs These symbolic links are required if a C 
or C++ compiler is installed and only for systems not based on glibc. 
/usr/include/asm -> /usr/src/linux/include/asm-<arch> 
/usr/include/linux -> /usr/src/linux/include/linux

Thus, practice dictated that it was safer to build the linux kernel somewhere 
other than /usr/src/linux.   Since the kernel is shipped with it's own 
include files, it works just fine building the kernel anywhere else; I am 
building under /home/kernel/linux-x.y.z.


-- 
timothy.covell@ashavan.org.

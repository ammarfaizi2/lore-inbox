Return-Path: <linux-kernel-owner+w=401wt.eu-S932537AbXAGNVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbXAGNVG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 08:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbXAGNVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 08:21:05 -0500
Received: from 1wt.eu ([62.212.114.60]:1830 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932537AbXAGNVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 08:21:04 -0500
Date: Sun, 7 Jan 2007 14:20:54 +0100
From: Willy Tarreau <w@1wt.eu>
To: Akula2 <akula2.shark@gmail.com>
Cc: Steve Brueggeman <xioborg@mchsi.com>, Auke Kok <sofar@foo-projects.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Multi kernel tree support on the same distro?
Message-ID: <20070107132054.GA435@1wt.eu>
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com> <459D9872.8090603@foo-projects.org> <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com> <20070107093057.GS24090@1wt.eu> <8355959a0701070511v55c671dibc3bb7d4426129e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8355959a0701070511v55c671dibc3bb7d4426129e0@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 06:41:00PM +0530, Akula2 wrote:
> On 1/7/07, Willy Tarreau <w@1wt.eu> wrote:
> >> There are some difficulties with gcc versions between linux-2.4 and 
> >linux-2.6,
> >> but I do not recall all of the details off of the top of my head.  If I 
> >recall
> >> correctly, one of the issues is, linux-2.4 ?prefers? gcc-2.96, while 
> >newer
> >> linux-2.6 support/prefer gcc-3.? or greater.
> 
> That's correct about gcc-3.4.x & gcc-4.1.x about 2.6 tree support.
> This means 2.6 supports both gcc versions. Here are the binaries I do
> use:-
> 
> http://download.fedora.redhat.com/pub/fedora/linux/core/3/i386/os/Fedora/RPMS/gcc-3.4.2-6.fc3.i386.rpm
> http://download.fedora.redhat.com/pub/fedora/linux/core/3/i386/os/Fedora/RPMS/kernel-2.6.9-1.667.i686.rpm
> 
> Now issue remains with 2.4 tree. Is it possible to build/install
> gcc-4.1.x along with gcc-3.4.x? This is what am trying to figure by
> few tests on the FC3 base machine.
> Can we call this as backward compatibility?
> 
> Any inputs here is helpful :-)
> 
> >Hmm, I think you did it the *hard* way. Gcc has been supporting
> >multi-version for years. You just have to compile it with --suffix=-3.4
> >or --suffix=4.1 to have a whole collection of gcc versions on your host.
> >If you don't want to recompile gcc, simply rename the binaries and you're
> >OK. When you build, you only have to do :
> >
> >  $ make bzImage modules CC=gcc-3.4
> >
> >I've been using it like this for years without problem. It's really
> >convenient, and it also allows you to easily compare output codes and
> >sizes between compilers.
> 
> I did understand this, thanks. I have one doubt: Imagine I have
> built/installed these:-
> 
> 2.4.34 & 2.6.20 kernels has these gcc-3.4.x & gcc-4.1.x compilers
> built on say FC6 box. Now issue comes when I run an application. How
> does it understand which library use?
> 
> example:
> myArmWireless app. needs gcc-3.4.x, NOT gcc-2.6.x libs on say 2.4.34 kernel.
> 
> Will it take automatically? Or we need to pass args to target the
> gcc-3.4.x libs?

I don't see which libs you are talking about. The compiler you build your
kernel with is totally independant on the compiler you build your apps with.
A few years ago, some distros even shipped a compiler just for the kernel
(they called the binary "kgcc").

So you just have to build 2 different GCC, one for 2.4, one for 2.6 and
you use them to build your kernels. If you want yet another compiler for
your apps, simply do it, it's not a problem. For instance, look on my
system when I type gcc- <Tab> :

$ gcc-
gcc-2.95    gcc-3.3     gcc-3.4     gcc-4.0     gcc-4.1     
gcc-2.95.3  gcc-3.3.6   gcc-3.4.4   gcc-4.0.2   gcc-4.1.1   

My gcc is a symlink to gcc-2.95, and I use any of those to build kernels
and applications, depending on what I need (optimizations, etc...).

> Hope you guys consider these (my) questions as Novice, because am
> trying to figure a design @ How-To build such multi kernel/gcc
> systems.

Well, I hope it will help you
Willy


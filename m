Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTFZNk0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 09:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTFZNk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 09:40:26 -0400
Received: from mail.hometree.net ([212.34.181.120]:19903 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S261249AbTFZNkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 09:40:12 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: DVB Include files
Date: Thu, 26 Jun 2003 13:54:24 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bdetug$m5n$2@tangens.hometree.net>
References: <20030625182409.A29252@infradead.org> <16122.5726.626761.307704@sheridan.metzler>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1056635664 22711 212.34.181.4 (26 Jun 2003 13:54:24 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 26 Jun 2003 13:54:24 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Metzler <mocm@metzlerbros.de> writes:

>Christoph Hellwig writes:
> > >  > In that case yes, you are screwed.  Your ABI just changed incompatibly.
> > > 
> > > Not if you recompile.

>>If you need to recompile your ABI changed.  And yes, then your absolutely
>>screwed.

>You may be, I am not.

If you run a kernel with a different ABI than the one described in
/usr/src/linux/include (or whereever you happen to put your symlink
to), you are. The fact that you have a kernel source tree which
describes a kernel version in /usr/src/linux, doesn't necessarly mean,
that it describes the _currently running_ kernel.

If you upgrade and your ABI breaks, you're toast. If you recompile and
the headers you include do not describe the same ABI as the kernel
you're running, you're still toast. If you symlink your user space
include directory to a kernel source tree directory, then you're still
toast. It doesn't matter.

You need an ABI that matches your applications for running existing
binaries.

You need headers for user space and kernel space that describe the
same thing to compile applications matching to that kernel.

You need headers that describe the ABI of the running kernel to
compile an application that runs on your current kernel.

Your idea of linking kernel headers to user space can break. 
Christophs' (and the widely accepted) policy of having separate
headers for kernel and user space can break as well. None of these
policies is a guarantee for having matching headers to your running
kernel.

The only guarantee would be having an "includes-fs" which synthesizes
include headers in a sysfs/procfs way that describe the currently
running kernel.... (ducks, runs)

	Regards
		Henning



> > > 
> > > Why (It's DVB by the way)? It's as close to the kernel as ls or cat
> > > and having two sets of the same includes is stupid. 

>>No, it's not.  One if for the driver you compile and one for the application.

>Yeah, yeah. I know, get off it. They are the same.

> > > What packages? You are always talking about packages. There are no packages.
> > > There are only the kernel and my app. Nothing else. No copying of headers.

>>Then you need to add a package with the userland header (which, as I already
>>said might be exactly the same ones as those in the kernel tree).

>What are those packages you are talking about? I am not making a
>distribution.

> > > There is no one who does that, not even distributions. The includes
> > > needed for libc are far less prone to change than v4l or dvb. And not
> > > as linux specific.

>> Oh yes, everyone does.  Ever looked at an errata kernel from RH, SuSE
>> or Debian?  Yes, they never change what's /usr/include/.

>So where are all the libc packages for each and every kernel package
>in debian?

> > > I see your point, but right now it's only academic and not practicable.

>>It's how Linux works.  If you don't like that play with SCO Unix or MacOS.

>No, it's how a linux distribution may work ( or should I say a
>GNU/Linux distribution).

>> On Wed, Jun 25, 2003 at 10:48:36PM +0200, Marcus Metzler wrote:
> > > That was kind of the point. If I have to check and copy the includes
> > > all the time I may run into trouble because of such changes. Whereas
> > > without that, I only have to recompile. I don't have to check each and
> > > evry possible place where old headers may be, which may even be
> > > different for every distribution.
> > 
> > If that's your attitude we should drop dvb from the kernel again.  The Linux
> > Kernel has a stable userspace ABI.
> > 

>Yes, that's why it's called the unstable branch. You are talking about a ready
>all done distribution. I am not. I am talking about developement. I
>don't know what your problem is. If you want the app in your
>distribution then change it to the way you want.

>Fact is that you need the headers in the kernel, in order to compile
>the drivers.

>Fact is that I need those same headers for my applications, not some
>others somewhere else.

>Fact is that this is the kernel list and we are talking about a
>developement kernel.

>All you are talking about is some user who gets a distribution and
>wants to compile his own programs. But they don't use DEVELOPEMENT
>kernels. And the don't write low level apps to test the drivers.

>Get over it, I am done feeding the trolls.

>Marcus

>-- 
>/--------------------------------------------------------------------\
>| Dr. Marcus O.C. Metzler        |                                   |
>|--------------------------------|-----------------------------------|
>| mocm@metzlerbros.de            | http://www.metzlerbros.de/        |
>\--------------------------------------------------------------------/



>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

--- Quote of the week: "It is pointless to tell people anything when
you know that they won't process the message." --- Jonathan Revusky

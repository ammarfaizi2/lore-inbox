Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUFUWWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUFUWWH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUFUWWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:22:07 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:1589 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266490AbUFUWWA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:22:00 -0400
Date: Tue, 22 Jun 2004 00:33:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kbuild updates
Message-ID: <20040621223344.GD2903@mars.ravnborg.org>
Mail-Followup-To: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <20040620211905.GA10189@mars.ravnborg.org> <20040620220319.GA10407@mars.ravnborg.org> <1087769761.14794.69.camel@nosferatu.lan> <200406202326.54354.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406202326.54354.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 11:26:54PM +0100, Alistair John Strachan wrote:
> [snipped a few CC addresses]
> 
> On Sunday 20 June 2004 23:16, Martin Schlemmer wrote:
> > On Mon, 2004-06-21 at 00:03, Sam Ravnborg wrote:
> > > On Sun, Jun 20, 2004 at 11:30:34PM +0200, Martin Schlemmer wrote:
> > > > I know Sam's mta blocks my mail at least (lame isp), but for the rest,
> > > > please reconsider using this.
> > >
> > > Hmm, got your mail.
> > >
> > > > Many external modules, libs, etc use
> > > > /lib/modules/`uname -r`/build to locate the _source_, and this will
> > > > break them all.
> > >
> > > Examples please. What I have seen so far is modules that was not
> > > adapted to use kbuild when being build.
> > > If they fail to do so they are inherently broken.
> >
> > Well, glibc use it for instance as an fall-through if you do not specify
> > it via ./configure arguments, or environment (yes, glibc should not use
> > it, etc, etc, no flames please =).  So as well does alsa-driver,
> > nvidia's drivers (gah, puke, yes, its got some binary-only stuff in
> > there ;), ati's drivers and a lot of other stuff (if you really need
> > them all I can try to find time to look for more).
> >
> > I am not sure about ati's drivers and alsa, but nvidia uses kbuild.
> >
> >
> > Thanks,
> 
> Sam's point is that unless you ask KBUILD to put the kernel build in a 
> separate directory to its sources (this is not the default 
> behaviour), /lib/modules/`uname -r`/build will still point to the mixture of 
> source and build data, therefore no breakage will occur.

Correct!

> I understand Sam's reasoning and I believe it is sensible to have the source 
> and build output in separate directories within /lib/modules/`uname -r`. The 
> drivers in question can easily be updated to support the exceptional case 
> whereby users build kernels in a different directory to the source.
> 
> Sam, maybe if there was a way to easily detect whether a kernel had been build 
> with or without a different output directory, it would be easier to have 
> vendors take this change on board. For example, I imagine in the typical case 
> whereby no change in build directory is made, you will have something like 
> this:
> 
> /lib/modules/2.6.7/build -> /home/alistair/linux-2.6
> /lib/modules/2.6.7/source -> /home/alistair/linux-2.6
> 
> Whereas when O is given, it will instead be like this:
> 
> /lib/modules/2.6.7/build -> /home/alistair/my-dir
> /lib/modules/2.6.7/source -> /home/alistair/linux-2.6
> 
> I presume that checking for the existence of /lib/modules/`uname -r`/source 
> will be enough.
> 
> #
> # where's the kernel source?
> #
> 
> if [ -d /lib/modules/`uname -r`/source ]; then
> 	# 2.6.8 and newer
> 	KERNDIR="/lib/modules/`uname -r`/source"
> else
> 	# pre 2.6.8 kernels
> 	KERNDIR="/lib/modules/`uname -r`/build"
> fi

Look ok.

	Sam

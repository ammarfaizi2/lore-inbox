Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTISTTu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTISTTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:19:49 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:6528 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S261687AbTISTTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:19:46 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Martin Schlemmer <azarah@gentoo.org>, Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: Make modules_install doesn't create /lib/modules/$version
Date: Fri, 19 Sep 2003 15:16:23 -0400
User-Agent: KMail/1.5
Cc: Rusty Russell <rusty@rustcorp.com.au>, "Randy.Dunlap" <rddunlap@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <20030919024455.834992C0F1@lists.samba.org> <16234.51231.312249.132103@gargle.gargle.HOWL> <1063987305.5491.21.camel@workshop.saharacpt.lan>
In-Reply-To: <1063987305.5491.21.camel@workshop.saharacpt.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309191516.23611.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 September 2003 12:01, Martin Schlemmer wrote:
> On Fri, 2003-09-19 at 11:10, Mikael Pettersson wrote:
> > Martin Schlemmer writes:
> >  > On Fri, 2003-09-19 at 04:25, Rusty Russell wrote:
> >  > > In message <20030918091511.276309a6.rddunlap@osdl.org> you write:
> >  > > > On Thu, 18 Sep 2003 03:21:40 -0400 Rob Landley <rob@landley.net> 
wrote:
> >  > > > | I've installed -test3, -test4, and now -test5, and each time
> >  > > > | make modules_install died with the following error:
> >  > > > |
> >  > > > | Kernel: arch/i386/boot/bzImage is ready
> >  > > > | sh arch/i386/boot/install.sh 2.6.0-test5 arch/i386/boot/bzImage
> >  > > > | System.map "" /lib/modules/2.6.0-test5 is not a directory.
> >  > >
> >  > > Looks like arch/i386/boot/install.sh is calling ~/bin/installkernel
> >  > > or /sbin/installkernel, which is not creating the directory.
> >  > >
> >  > > Should depmod create the directory?  It can, of course, but AFAICT
> >  > > the old one didn't.
> >  > >
> >  > > Maybe a RedHat issue?
> >  >
> >  > Likely, it works fine here with the one we are using
> >  > from debianutils.
> >
> > So how come it's never been a problem on my RH boxes?
> > (Currently RH9 + module-init-tools but none of Arjan's .rpms)
> >
> > I basically do
> > make bzImage modules |& tee /tmp/log
> > grep Warning /tmp/log
> > su
> > make modules_install
> > make install
> >
> > Creating the /lib/modules/<version> directory is the kernel's
> > job, not installkernel (it's never done that before).
>
> Yes, OK, so I have not checked =)  I just reacted on if
> installkernel form non RH misbehave or not.

The kernel isn't doing it.  A script called from installkernel (in Red Hat 9) 
calls depmod, which has to be Rusty's new depmod or it doesn't create the 
directory.  This means depmod is running against the OLD modules.

I've been bitten by this before, by the way.  I switched from an accidental 
SMP kernel to a UP kernel on my laptop, and the install complained about 
unresolved SMP symbols in the modules.  (This is how I got in the habit of 
doing make modules_install before make install, which I thought might also be 
responsible for the directory creation problem, but wasn't.  Neither creates 
the directory: depmod does).

Rob

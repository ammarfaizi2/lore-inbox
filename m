Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272146AbTG2VhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272134AbTG2Vel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:34:41 -0400
Received: from msgbas2x.cos.agilent.com ([192.25.240.37]:29682 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S272155AbTG2Vdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:33:50 -0400
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D5523A@axcs03.cos.agilent.com>
From: yiding_wang@agilent.com
To: sam@ravnborg.org, holt@sgi.com
Cc: linux-kernel@vger.kernel.org, kai@tp1.ruhr-uni-bochum.de
Subject: RE: 2.5.x module make questions
Date: Tue, 29 Jul 2003 15:33:41 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Sam and Robin!  

I read kbuild/makefile.txt several times and could not find the answer fit my need. It looks like I have to change my source tree structure.  I was refering to scsi/aic7xxx/ but not getting solution either.  Now I am going to look into arch/Makefiles.

Appreciate your help, always!

Eddie

> -----Original Message-----
> From: Sam Ravnborg [mailto:sam@ravnborg.org]
> Sent: Tuesday, July 29, 2003 2:09 PM
> To: yiding_wang@agilent.com
> Cc: linux-kernel@vger.kernel.org; Kai Germaschewski
> Subject: Re: 2.5.x module make questions
> 
> 
> On Tue, Jul 29, 2003 at 02:45:35PM -0600, 
> yiding_wang@agilent.com wrote:
> > Team,
> > 
> > I have two questions regarding kbuild.
> > 1, According to doc., makefile can do descending.  Could 
> make carry ascending?
> Kbuild is not designed to support ascending, and I do not think it is
> possible to tweak it to do so. If you manage to tweak kbuild 
> to support it
> do not complain if it breakes. This is not intended neither supported.
> 
> > 2, Does old style of makefile still work (it should 
> according to the article of "Driver porting: compiling 
> external module")?
> 
> What Corbet suggest in the referenced doc is to have the following:
> 
> ifndef KERNELRELEASE
> here goes old style Makefile
> else
> here goes Kbuild makefile
> endif
> 
> And this is _only_ the topmost makefile. And the oldstyle part is only
> to make it simple to do make -C kernelsrcdir SUBDIRS=$PWD modules
> kbuild does not support old-style Makefiles, but fragments 
> are supported.
> 
> May I request you to read Documentation/kbuild/makefiles.txt - this
> is an up-to-date description of what kbuild supports, and 
> what syntax to use.
> 
> The most complex examples of use in the kernel today is some of the
> arch Makefiles. Maybe they can help you?
> 
> > export TOPDIR
> > export CFLAGS
> > 
> > all : ag.o
> > 
> > ag.o: ../../../../t/s/ts.o ../../../f/c/fc.o 
> ../../../f/i/fi.o  s/sl.o 
> > 	ld -r -o ag.o ../../../../t/s/ts.o ../../../f/c/fc.o 
> ../../../f/i/fi.o s/sl.o 
> 
> This looks really ugly. I do not expect kbuild to even get 
> close to help
> you here. kbuild is designed around the idea that objects are built
> directory-by-directory, and in the upper level directory the 
> are linked.
> What you have surely does not follow that principle.
> 
> > Any suggestion is welcomed.  If the kbuild cannot do 
> ascending, I have to change the source tree structure but 
> that is the least I want to do.
> 
> This is my best suggestion. Follow the normal way of doing 
> things in the
> kernel make it easier/possible to use the infrastructure provided
> by the kernel.
> 
> PS. Please also read the paper by Kai Germashewski from OLS -
> see www.linuxsymposium.org - it provide good background info 
> on kbuild.
> 
> 	Sam
> 

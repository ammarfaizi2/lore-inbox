Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUGNVku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUGNVku (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUGNVkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:40:49 -0400
Received: from web40006.mail.yahoo.com ([66.218.78.24]:33952 "HELO
	web40006.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265134AbUGNVkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:40:45 -0400
Message-ID: <20040714214044.69938.qmail@web40006.mail.yahoo.com>
Date: Wed, 14 Jul 2004 14:40:44 -0700 (PDT)
From: Song Wang <wsonguci@yahoo.com>
Subject: Re: [kbuild-devel] kbuild support to build one module with multiple separate components?
To: Sam Ravnborg <sam@ravnborg.org>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040714211936.GA8888@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sam

Thanks for the reply.

However, in the way you indicate, the
mainmodule and each submodule will be built
as separate kernel modules. You will get
mainmodule.ko, a_sub_module.ko, b_sub_module.ko etc.

This is not what I tried to get. I tried to
build a single kernel module, which means that
mainmodule.o, a_sub_module.o, b_sub_module.o
should be linked together to produce the single
module.

This will be convenient, for instance, for
distribution because you need only to distribute one
kernel module instead of a long list of modules.

-Song


--- Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Jul 02, 2004 at 04:47:35PM -0700, Song Wang
> wrote:
> > Hi, Folks
> > 
> > I'm puzzled by the kbuild system in 2.6 kernel.
> > I want to write a kernel module, which consists of
> > several components. The module is produced by
> > linking these components. These components are
> located
> > in separate subdirectories (for example A, B,C). 
> > Each component is generated also by linking 
> > multiple files. (For example, a_1.c, a_2.c for
> > building A.o, b_1.c, b_2.c for building B.o, then
> A.o
> > and B.o
> > should be linked to produce mymodule.o) 
> > 
> > I know if I put all the files in a single
> directory
> > The makefile of the module looks like
> > 
> > obj-$(CONFIG_MYMODULE) += mymodule.o
> > mymodule-objs := a_1.o a_2.o b_1.o b_2.o c_1.o
> c_2.o
> > 
> > It should work. But it is really messy, especially
> > there are a lot of files or each component
> requires
> > different EXTRA_CFLAGS. However, if I write
> > separate Makefiles for each component in their own
> > subdirectory, the Makefile of component A looks
> like
> > 
> > obj-y := A.o (or obj-$(CONFIG_MYMODULE) +=  A.o)
> > A-objs := a_1.o a_2.o
> > 
> > This is wrong, because kbuild will treat A as
> > independent module. All I want is to treat
> > A as component of the only module mymodule.o. It
> > should be linked to mymodule.o
> > 
> > Any idea on how to write a kbuild Makefile to
> > support such kind of single module produced
> > by linking multiple components and each component
> > is located in separate directory? Thanks.
> 
> 
> Hi Song (added lkml to cc:).
> 
> You just need to have one common module usign all
> the sub-modules.
> 
> So having each sub-module in directory M/sub-a
> M/sub-b etc.
> you need a makefile in M/ that looks like:
> M/Makefile:
> obj-m += sub-a/
> obj-m += sub-b/
> obj-m += mainmodule.o
> 
> In each sub-directory you need a separate Makefile
> like:
> M/sub-a/Makefile
> obj-m += a_sub_module.o
> 
> Then all symbols used by the mainmodule needs to be
> properly
> exported in each sub-module.
> 
> Hope this clarifies it.
> 
> 	Sam
> 



		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUGNVNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUGNVNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUGNVNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:13:32 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:36675 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265245AbUGNVMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:12:03 -0400
Date: Wed, 14 Jul 2004 23:19:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Song Wang <wsonguci@yahoo.com>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] kbuild support to build one module with multiple separate components?
Message-ID: <20040714211936.GA8888@mars.ravnborg.org>
Mail-Followup-To: Song Wang <wsonguci@yahoo.com>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040702234735.63710.qmail@web40003.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702234735.63710.qmail@web40003.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 04:47:35PM -0700, Song Wang wrote:
> Hi, Folks
> 
> I'm puzzled by the kbuild system in 2.6 kernel.
> I want to write a kernel module, which consists of
> several components. The module is produced by
> linking these components. These components are located
> in separate subdirectories (for example A, B,C). 
> Each component is generated also by linking 
> multiple files. (For example, a_1.c, a_2.c for
> building A.o, b_1.c, b_2.c for building B.o, then A.o
> and B.o
> should be linked to produce mymodule.o) 
> 
> I know if I put all the files in a single directory
> The makefile of the module looks like
> 
> obj-$(CONFIG_MYMODULE) += mymodule.o
> mymodule-objs := a_1.o a_2.o b_1.o b_2.o c_1.o c_2.o
> 
> It should work. But it is really messy, especially
> there are a lot of files or each component requires
> different EXTRA_CFLAGS. However, if I write
> separate Makefiles for each component in their own
> subdirectory, the Makefile of component A looks like
> 
> obj-y := A.o (or obj-$(CONFIG_MYMODULE) +=  A.o)
> A-objs := a_1.o a_2.o
> 
> This is wrong, because kbuild will treat A as
> independent module. All I want is to treat
> A as component of the only module mymodule.o. It
> should be linked to mymodule.o
> 
> Any idea on how to write a kbuild Makefile to
> support such kind of single module produced
> by linking multiple components and each component
> is located in separate directory? Thanks.


Hi Song (added lkml to cc:).

You just need to have one common module usign all the sub-modules.

So having each sub-module in directory M/sub-a M/sub-b etc.
you need a makefile in M/ that looks like:
M/Makefile:
obj-m += sub-a/
obj-m += sub-b/
obj-m += mainmodule.o

In each sub-directory you need a separate Makefile like:
M/sub-a/Makefile
obj-m += a_sub_module.o

Then all symbols used by the mainmodule needs to be properly
exported in each sub-module.

Hope this clarifies it.

	Sam

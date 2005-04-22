Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVDVLbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVDVLbe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 07:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVDVLbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 07:31:33 -0400
Received: from colin.muc.de ([193.149.48.1]:24837 "EHLO colin2.muc.de")
	by vger.kernel.org with ESMTP id S261993AbVDVLbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 07:31:31 -0400
Date: 22 Apr 2005 13:31:30 +0200
Date: Fri, 22 Apr 2005 13:31:30 +0200
From: Andi Kleen <ak@muc.de>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] minor syctl fix in vsyscall_init
Message-ID: <20050422113130.GA19292@muc.de>
References: <200504131745.j3DHjIVE017612@snoqualmie.dp.intel.com> <20050413182913.GE50241@muc.de> <40f323d0050421091625659f16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f323d0050421091625659f16@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 06:16:48PM +0200, Benoit Boissinot wrote:
> On 13 Apr 2005 20:29:13 +0200, Andi Kleen <ak@muc.de> wrote:
> > On Wed, Apr 13, 2005 at 10:45:18AM -0700, Matt Tolentino wrote:
> > >
> > > Andi,
> > >
> > > If CONFIG_SYCTL is not enabled then the x86-64 tree
> > > fails to build due to use of a symbol that is not
> > > compiled in.  Don't bother compiling in the sysctl
> > > register call if not building with sysctl.
> > 
> > Thanks. Actually it would be better to fix up sysctl.h
> > to define dummy functions in this case. I thought it did
> > that already in fact....
> > 
> 
> Yes it already does that, but kernel_root_table2 is not defined when
> CONFIG_SYSCTL is not set (the problem isn't with
> register_sysctl_table).
> 
> With 2.6.12-rc3:
> arch/x86_64/kernel/vsyscall.c: In function `vsyscall_init':
> arch/x86_64/kernel/vsyscall.c:221: error: `kernel_root_table2'
> undeclared (first use in this function)
> 
> If you prefer, i can send a patch which sets kernel_table_root2 to
> NULL when CONFIG_SYSCTL is not set. Or maybe there a better fix (btw
> is sysctl_vsyscall needed when !CONFIG_SYSCTL ?).

Hmpf ok. I assumed they were macros who ignore their arguments.
The original patch was fine, thanks.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWGJPJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWGJPJE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWGJPJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:09:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:57748 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965014AbWGJPJD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:09:03 -0400
Date: Mon, 10 Jul 2006 10:08:21 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       Kirill Korotaev <dev@openvz.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6: kernel/sysctl.c: PROC_FS=n compile error
Message-ID: <20060710150821.GE28688@sergelap.austin.ibm.com>
References: <20060703030355.420c7155.akpm@osdl.org> <20060708202011.GD5020@stusta.de> <20060709185228.GB14100@sergelap.austin.ibm.com> <20060709233321.GY13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709233321.GY13938@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adrian Bunk (bunk@stusta.de):
> On Sun, Jul 09, 2006 at 01:52:28PM -0500, Serge E. Hallyn wrote:
> > Quoting Adrian Bunk (bunk@stusta.de):
> > > namespaces-utsname-sysctl-hack.patch and ipc-namespace-sysctls.patch 
> > > cause the following compile error with CONFIG_PROC_FS=n:
> > > 
> > > <--  snip  -->
> > > 
> > > ...
> > >   CC      kernel/sysctl.o
> > > kernel/sysctl.c:107: warning: #proc_do_ipc_string# used but never defined
> > > kernel/sysctl.c:150: warning: #proc_do_utsns_string# used but never defined
> > > kernel/sysctl.c:2465: warning: #proc_do_uts_string# defined but not used
> > > ...
> > >   LD      .tmp_vmlinux1
> > > kernel/built-in.o:(.data+0x938): undefined reference to `proc_do_utsns_string'
> > > kernel/built-in.o:(.data+0x964): undefined reference to `proc_do_utsns_string'
> > > kernel/built-in.o:(.data+0x990): undefined reference to `proc_do_utsns_string'
> > > kernel/built-in.o:(.data+0x9bc): undefined reference to `proc_do_utsns_string'
> > > kernel/built-in.o:(.data+0x9e8): undefined reference to `proc_do_utsns_string'
> > > kernel/built-in.o:(.data+0xc24): undefined reference to `proc_do_ipc_string'
> > > kernel/built-in.o:(.data+0xc50): undefined reference to `proc_do_ipc_string'
> > > kernel/built-in.o:(.data+0xc7c): undefined reference to `proc_do_ipc_string'
> > > kernel/built-in.o:(.data+0xca8): undefined reference to `proc_do_ipc_string'
> > > kernel/built-in.o:(.data+0xcd4): undefined reference to `proc_do_ipc_string'
> > > kernel/built-in.o:(.data+0xd00): more undefined references to `proc_do_ipc_string' follow
> > > make: *** [.tmp_vmlinux1] Error 1
> > 
> > Does the below patch fix this for you?  Took me awhile to get a valid
> 
> I can confirm this patch fixes the compilation for me.
> 
> > CONFIG_PROC_FS=n .config, and I'm having other -mm s390 build failures
> > which I'll look into tomorrow, but this seems to fix the problem.
> 
> CONFIG_EMBEDDED=y is required for CONFIG_PROC_FS=n, but apart from this 
> there was no problem for me.
> 
> Did you observe any other problems (besides a small ATM compile error 
> Dave has just merged my patch for) with CONFIG_PROC_FS=n?

Ok, CONFIG_PROC_FS=n hides the fs/proc/task_mmu.c:arch_vma_name()
definition, and only i386 and powerpc have their own versions.

2.6.18-rc1-mm1's kernel/signal.c uses arch_vma_name() in print_vma().

-serge

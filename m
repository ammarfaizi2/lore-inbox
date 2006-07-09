Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbWGIXdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbWGIXdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbWGIXdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:33:24 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10257 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161218AbWGIXdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:33:22 -0400
Date: Mon, 10 Jul 2006 01:33:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Sam Vilain <sam.vilain@catalyst.net.nz>,
       Kirill Korotaev <dev@openvz.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6: kernel/sysctl.c: PROC_FS=n compile error
Message-ID: <20060709233321.GY13938@stusta.de>
References: <20060703030355.420c7155.akpm@osdl.org> <20060708202011.GD5020@stusta.de> <20060709185228.GB14100@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709185228.GB14100@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 01:52:28PM -0500, Serge E. Hallyn wrote:
> Quoting Adrian Bunk (bunk@stusta.de):
> > namespaces-utsname-sysctl-hack.patch and ipc-namespace-sysctls.patch 
> > cause the following compile error with CONFIG_PROC_FS=n:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      kernel/sysctl.o
> > kernel/sysctl.c:107: warning: #proc_do_ipc_string# used but never defined
> > kernel/sysctl.c:150: warning: #proc_do_utsns_string# used but never defined
> > kernel/sysctl.c:2465: warning: #proc_do_uts_string# defined but not used
> > ...
> >   LD      .tmp_vmlinux1
> > kernel/built-in.o:(.data+0x938): undefined reference to `proc_do_utsns_string'
> > kernel/built-in.o:(.data+0x964): undefined reference to `proc_do_utsns_string'
> > kernel/built-in.o:(.data+0x990): undefined reference to `proc_do_utsns_string'
> > kernel/built-in.o:(.data+0x9bc): undefined reference to `proc_do_utsns_string'
> > kernel/built-in.o:(.data+0x9e8): undefined reference to `proc_do_utsns_string'
> > kernel/built-in.o:(.data+0xc24): undefined reference to `proc_do_ipc_string'
> > kernel/built-in.o:(.data+0xc50): undefined reference to `proc_do_ipc_string'
> > kernel/built-in.o:(.data+0xc7c): undefined reference to `proc_do_ipc_string'
> > kernel/built-in.o:(.data+0xca8): undefined reference to `proc_do_ipc_string'
> > kernel/built-in.o:(.data+0xcd4): undefined reference to `proc_do_ipc_string'
> > kernel/built-in.o:(.data+0xd00): more undefined references to `proc_do_ipc_string' follow
> > make: *** [.tmp_vmlinux1] Error 1
> 
> Does the below patch fix this for you?  Took me awhile to get a valid

I can confirm this patch fixes the compilation for me.

> CONFIG_PROC_FS=n .config, and I'm having other -mm s390 build failures
> which I'll look into tomorrow, but this seems to fix the problem.

CONFIG_EMBEDDED=y is required for CONFIG_PROC_FS=n, but apart from this 
there was no problem for me.

Did you observe any other problems (besides a small ATM compile error 
Dave has just merged my patch for) with CONFIG_PROC_FS=n?

> thanks,
> -serge
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


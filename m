Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVBRFWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVBRFWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 00:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVBRFWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 00:22:46 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:5291 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261208AbVBRFWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 00:22:44 -0500
Date: Fri, 18 Feb 2005 16:22:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
       davem@davemloft.net, ralf@linux-mips.org, tony.luck@intel.com,
       ak@suse.de, willy@debian.org, schwidefsky@de.ibm.com
Subject: Re: [PATCH] Consolidate compat_sys_waitid
Message-Id: <20050218162229.63d69935.sfr@canb.auug.org.au>
In-Reply-To: <20050215184307.GQ29917@parcelfarce.linux.theplanet.co.uk>
References: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
	<20050215184307.GQ29917@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005 18:43:07 +0000 Matthew Wilcox <matthew@wil.cx> wrote:
>
> On Tue, Feb 15, 2005 at 02:01:49PM +1100, Stephen Rothwell wrote:
> 
> > +asmlinkage long compat_sys_waitid(u32 which, u32 pid,
> > +		struct compat_siginfo __user *uinfo, u32 options,
> > +		struct compat_rusage __user *uru)
> 
> Some subtle differences which I feel incompetent to diagnose ... ours
> looks like:
> 
> asmlinkage int compat_sys_waitid(int which, pid_t pid,
>                                  compat_siginfo_t __user *infop, int options,
>                                  struct compat_rusage __user *ru)

They are u32 in my version because we decided that the kernel zero extends
the compat syscall parameters.

> Other than variable names, we're identical to this point:
> 
>         /* Tell copy_siginfo_to_user that it was __SI_CHLD */
>         ksiginfo.si_code |= __SI_CHLD;
>         
>         if (compat_copy_siginfo_to_user(infop, &ksiginfo) != 0)

Every other relevant architecture has copy_siginfo_to_user32 which returns
0/-EFAULT.  And it is declared in linux/compat.h.  I like your name
better, but that is a different patch.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

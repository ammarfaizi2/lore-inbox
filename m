Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVC3TNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVC3TNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbVC3TKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:10:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:24218 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262383AbVC3TGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:06:11 -0500
Date: Wed, 30 Mar 2005 11:05:09 -0800
From: Greg KH <greg@kroah.com>
To: blaisorblade@yahoo.it
Cc: torvalds@osdl.org, akpm@osdl.org,
       user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org,
       jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: [stable] [patch 3/8] uml: quick fix syscall table [urgent]
Message-ID: <20050330190509.GA17602@kroah.com>
References: <20050330173348.63741EFE76@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050330173348.63741EFE76@zion>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 07:33:48PM +0200, blaisorblade@yahoo.it wrote:
> 
> CC: <stable@kernel.org>
> 
> *) Uml 2.6.11 does not compile with gcc 2.95.4 because some entries are
> duplicated, and that GCC does not accept this (unlike gcc 3). Plus various
> other bugs in the syscall table definitions:
> 
>   *) 223 is a syscall hole (i.e. ni_syscall) only on i386, on x86_64 it's a
>   valid syscall (thus a duplicated one).
> 
>   *) __NR_vserver must be only once with sys_ni_syscall, and not multiple
>   times with different values!
> 
>   *) syscalls duplicated in SUBARCHs and in common files (thus assigning twice
>   to the same array entry and causing the GCC 2.95.4 failure mentioned above):
>   sys_utimes, which is common, and sys_fadvise64_64, sys_statfs64,
>   sys_fstatfs64, which exist only on i386.
> 
>   *) syscalls duplicated in each SUBARCH, to put in common files:
>   sys_remap_file_pages, sys_utimes, sys_fadvise64
> 
>   *) 285 is a syscall hole (i.e. ni_syscall) only on i386, on x86_64 the range
>   does not arrive to that point.
> 
>   *) on x86_64, the macro name is __NR_kexec_load and not __NR_sys_kexec_load.
>   Use the correct name in either case.
> 
> Note: as you can see, part of the syscall table definition in UML is
> arch-independent (with everywhere defined syscalls), and part is
> arch-dependant. This has created confusion (some syscalls are listed in both
> places, some in the wrong one, some are wrong on one arch or another).
> 
> Also, as add-ons:
> 
> *) uses __va_copy instead of va_copy since some old versions of gcc (2.95.4
> for instance) don't accept va_copy.
> 
> *) some whitespace cleanups in the syscall table (if you don't like them, feel
> free to remove them).

For this to be considered for the -stable tree, can you remove the
whitespace cleanups, and break this up into different patches for the
different things you are doing (one thing per patch please.)

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSALRnZ>; Sat, 12 Jan 2002 12:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287231AbSALRnP>; Sat, 12 Jan 2002 12:43:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:22386 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287204AbSALRnE>; Sat, 12 Jan 2002 12:43:04 -0500
Date: Sat, 12 Jan 2002 18:42:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
Message-ID: <20020112184216.U1482@inspiron.school.suse.de>
In-Reply-To: <20020112141738.L1482@inspiron.school.suse.de> <200201121726.g0CHQZ7369540@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200201121726.g0CHQZ7369540@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Sat, Jan 12, 2002 at 12:26:35PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 12:26:35PM -0500, Albert D. Cahalan wrote:
> Andrea Arcangeli writes:
> > On Fri, Jan 11, 2002 at 11:32:37PM -0800, H. Peter Anvin wrote:
> >> By author:    rwhron@earthlink.net
> 
> >>> --- linux.aa2/arch/i386/config.in       Fri Jan 11 20:57:58 2002
> >>> +++ linux/arch/i386/config.in   Fri Jan 11 22:20:32 2002
> >>> @@ -169,7 +169,11 @@
> >>>  if [ "$CONFIG_HIGHMEM64G" = "y" ]; then
> >>>     define_bool CONFIG_X86_PAE y
> >>>  else
> >>> -   bool '3.5GB user address space' CONFIG_05GB
> >>> +   choice 'Maximum Virtual Memory' \
> >>> +       "3GB            CONFIG_1GB \
> >>> +        2GB            CONFIG_2GB \
> >>> +        1GB            CONFIG_3GB \
> >>> +        05GB           CONFIG_05GB" 3GB
	       ^^ this should be 3.5GB btw
> >>>  fi
> >>
> >> Calling this "Maximum Virtual Memory" is misleading at best.  This is
> >> best described as "kernel:user split" (3:1, 2:2, 1:3, 3.5:0.5);
> >> "maximum virtual memory" sounds to me a lot like the opposite of what
> >> your parameter is.
> >
> > actually it is really max virtual memory.. but from the user point of
> > view, user is supposed to care about the virtual memory he can manage,
> > not about what the kernel will do with the rest. So if the user wants
> > 3GB of virtual memory available to each task he will select 3GB. I
> > really don't mind if you want to change it from the kernel point of
> > view, but given it's the user who's supposed to compile it, also the
> > current patch looks good enough to me.
> 
> The numbers are wrong anyway, because of vmalloc() and PCI space.
> The PCI space is motherboard-dependent AFAIK, but you could at
> least account for the 128 MB vmalloc() area:

looks dirty, the size of the kernel direct mapping is mainly in function
of #defines that can be changed freely, they're not constant in function
of CONFIG_1G etc.. and it changes also in function of smp/up/4G/64G
options.  The 3GB/2GB/1GB/3.5GB visible into the menuconfig are exact
instead.  So I wouldn't mention inprecise stuff that can changed under
us (and the exact size of the kernel direct mapping doesn't matter to
the user anyways I think [and if it matters I think it means he's
skilled enough to know about vmalloc space ;) ]).

> 
> user virtual space / non-kmap physical memory
> 
> 3584/384
> 3072/896
> 2048/1920
> 1024/2944  (sure this works, even for syscalls w/ bad pointers?)
> 512/3456   (sure this works, even for syscalls w/ bad pointers?)

Andrea

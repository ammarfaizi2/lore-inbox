Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTEMQgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTEMQgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:36:17 -0400
Received: from havoc.daloft.com ([64.213.145.173]:47316 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261956AbTEMQgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:36:10 -0400
Date: Tue, 13 May 2003 12:48:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] PAG support only
Message-ID: <20030513164856.GC30944@gtf.org>
References: <8943.1052843591@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8943.1052843591@warthog.warthog>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:33:11PM +0100, David Howells wrote:
> Due to the slight unpopularity of the AFS multiplexor, here's a patch with

I think of it as "bitter pill we will be forced to swallow", and then
hope and pray that we can use your AFS stuff as a transition step to --
after many years -- migrate people away from AFS altogether.  ;-)

Or maybe that's just wishful thinking.


> diff -uNr linux-2.5.69/fs/open.c linux-2.5.69-cred/fs/open.c
> --- linux-2.5.69/fs/open.c	2003-05-06 15:04:45.000000000 +0100
> +++ linux-2.5.69-cred/fs/open.c	2003-05-13 11:28:08.000000000 +0100
> @@ -46,7 +46,7 @@
>  	struct nameidata nd;
>  	int error;
>  
> -	error = user_path_walk(path, &nd);
> +	error = user_path_walk(path,&nd);

a bit of noise


> --- linux-2.5.69/include/asm-i386/posix_types.h	2003-05-06 15:04:37.000000000 +0100
> +++ linux-2.5.69-cred/include/asm-i386/posix_types.h	2003-05-12 10:19:15.000000000 +0100
> @@ -13,6 +13,7 @@
>  typedef unsigned short	__kernel_nlink_t;
>  typedef long		__kernel_off_t;
>  typedef int		__kernel_pid_t;
> +typedef int		__kernel_pag_t;
>  typedef unsigned short	__kernel_ipc_pid_t;
>  typedef unsigned short	__kernel_uid_t;
>  typedef unsigned short	__kernel_gid_t;
[...]
> +int sys_setpag(pag_t pag)
> +int sys_getpag(void)

Surely you want s/int/long/ here?

Two other comments:

* even though you're referencing 'current', I'm a bit surprised you
  don't need any locking at all in sys_getpag.  Is that guaranteed
  through judicious use of xchg()?

* is it reasonable to make credentials support a config option?
  Long term I worry about Linux kernel becoming another Irix, supporting
  thousands of rarely used syscalls unconditionally.

	Jeff



P.S.  Looking forward to the "cachefs" code you have in your cvs repo
hitting mainline.  That will be fun for NFS.  <grin>


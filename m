Return-Path: <linux-kernel-owner+w=401wt.eu-S1030324AbXAEFNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbXAEFNX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 00:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbXAEFNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 00:13:23 -0500
Received: from smtp.osdl.org ([65.172.181.24]:54048 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030324AbXAEFNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 00:13:22 -0500
Date: Thu, 4 Jan 2007 21:13:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] dont export asm/page.h to userspace
Message-Id: <20070104211305.3d3e8a68.akpm@osdl.org>
In-Reply-To: <200701042228.31456.vapier@gentoo.org>
References: <200701042228.31456.vapier@gentoo.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007 22:28:30 -0500
Mike Frysinger <vapier@gentoo.org> wrote:

> On 1/4/07, Christoph Hellwig <hch@infradead.org> wrote:
> > It should not be exported to userspace at all.  Care to submit a patch?
> 
> trivial patch attached
> -mike
> 
> 
> [application/pgp-signature (828B)]
> 
> [linux-dont-export-asm-page.patch  text/x-diff (326B)]
> diff --git a/include/asm-generic/Kbuild.asm b/include/asm-generic/Kbuild.asm
> index a37e95f..642d277 100644
> --- a/include/asm-generic/Kbuild.asm
> +++ b/include/asm-generic/Kbuild.asm
> @@ -32,4 +32,3 @@ unifdef-y += user.h
>  # These probably shouldn't be exported
>  unifdef-y += shmparam.h
>  unifdef-y += elf.h
> -unifdef-y += page.h

box:/usr/src/25> make headers_check
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     include/linux/utsrelease.h
make[1]: `scripts/unifdef' is up to date.
  REMOVE  include/asm/page.h
  REMOVE  include/asm/.check.page.h
  CHECK   include/asm-generic/siginfo.h
  CHECK   include/asm-generic/resource.h
  CHECK   include/asm-generic/statfs.h
  CHECK   include/asm-generic/signal.h
  CHECK   include/asm-generic/mman.h
  CHECK   include/asm-generic/ipc.h
  CHECK   include/asm-generic/ioctl.h
  CHECK   include/asm-generic/fcntl.h
  CHECK   include/asm-generic/errno.h
  CHECK   include/asm-generic/errno-base.h
  CHECK   include/asm/vm86.h
  CHECK   include/asm/user.h
/usr/src/devel/usr/include/asm/user.h requires asm/page.h, which does not exist in exported headers
make[2]: *** [/usr/src/devel/usr/include/asm/.check.user.h] Error 1
make[1]: *** [asm-i386] Error 2
make: *** [headers_check] Error 2

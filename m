Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbUDWM3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbUDWM3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 08:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264797AbUDWM3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 08:29:20 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:33296 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264788AbUDWM2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 08:28:01 -0400
Date: Fri, 23 Apr 2004 22:27:38 +1000
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SOFTWARE_SUSPEND as a module
Message-ID: <20040423122738.GA12504@gondor.apana.org.au>
References: <20040422120417.GA2835@gondor.apana.org.au> <20040423005617.GA414@elf.ucw.cz> <20040423093836.GA10550@gondor.apana.org.au> <20040423122123.GG976@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423122123.GG976@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 02:21:23PM +0200, Pavel Machek wrote:
>
> > The point of this is to allow inclusion in distribution kernels where
> > block devices are built as modules.
> 
> What's the problem with block devices as module? You need to insmod
> before resume?

Exactly.

> If you really ensure userspace is stopped, you should be fine.
> 
> *But* kernel is only correct if userspace is "correct", and need for
> all processes stopped is not going to be obvious to users. I'd like
> kernel to be kernel to be okay regardless what stupid stuff happens in
> userspace. (Well, they really should not scribble on disks).

But in this context if user space is not doing the right thing,
you'll lose whatever the kernel does.  For example, if user space
writes to any file systems mounted in the suspended image, then
you'll get corruption no matter what the kernel does.

This module is not meant to be loaded directly by users.  It's only
meant to be used by system initrd scripts.

> And here's diff between my tree and mainline.. so that you work on
> current sources.

Thanks.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

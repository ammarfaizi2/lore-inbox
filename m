Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTKINYn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 08:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbTKINYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 08:24:43 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.26]:62869 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261605AbTKINYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 08:24:42 -0500
Date: Sun, 9 Nov 2003 14:24:39 +0100
To: Johannes Stezenbach <js@convergence.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ioctl compile warnings in userspace
Message-ID: <20031109132439.GA2460@iliana>
References: <20031107173205.GA4425@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031107173205.GA4425@convergence.de>
User-Agent: Mutt/1.5.4i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 06:32:05PM +0100, Johannes Stezenbach wrote:
> Hi,
> 
> Debian unstable now has glibc 2.3.2 and includes kernel headers
> from "2.5.999-test7-bk-8".
> 
> $ gcc --version
> gcc (GCC) 3.3.2 (Debian)

I also get this problem when compiling parted :

../../libparted/linux.c: In function `_device_get_length':
../../libparted/linux.c:407: error: parse error before '[' token
../../libparted/linux.c:407: warning: signed and unsigned type in conditional expression
make[4]: *** [linux.lo] Erreur 1

This error is due to the usage of BLKGETSIZE64 in linux/fs.h, which is
defined as :

  #define BLKGETSIZE64 _IOR(0x12,114,size_t)      /* return device size in bytes (u64 *arg) */

I understand that size_t should no more be used or something such, which
is way the _IOC_TYPECHECK(t) was introduced.

I believe that the error is due to :

  sizeof(t[1])

trying to do :

   sizeof(size_t[1])

Not sure though.

I guess the debian glibc should not use 2.6.0-test headers in its
unstable glibc, which will run on systems with 2.4.x kernels anyway.

Friendly,

Sven Luther

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbUCOTAo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbUCOTAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:00:44 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:54752 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262696AbUCOTAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:00:42 -0500
Date: Mon, 15 Mar 2004 12:00:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, torvalds@osdl.org,
       davem@redhat.com
Subject: Re: [SPARC64][PPC] strange error ..
Message-ID: <20040315190026.GG4342@smtp.west.cox.net>
References: <Pine.LNX.4.58L.0403151437360.16193@alpha.zarz.agh.edu.pl> <Pine.LNX.4.58L.0403151939460.17732@alpha.zarz.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0403151939460.17732@alpha.zarz.agh.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 07:41:57PM +0100, Wojciech 'Sas' Cieciwa wrote:

> OK. here is trivial fix:
> 
> --- linux-2.6.4/init/do_mounts_initrd.c.org	2004-03-15 09:24:58.000000000 +0100
> +++ linux-2.6.4/init/do_mounts_initrd.c	2004-03-15 19:35:50.186528400 +0100
> @@ -1,6 +1,6 @@
>  #define __KERNEL_SYSCALLS__
> -#include <linux/unistd.h>
>  #include <linux/kernel.h>
> +#include <linux/unistd.h>
>  #include <linux/fs.h>
>  #include <linux/minix_fs.h>
>  #include <linux/ext2_fs.h>

That leaves the more general problem of <asm/unistd.h> uses 'asmlinkage'
on platforms where either (or both) of the following can be true:
- 'asmlinkage' is a meaningless term, and shouldn't be used.
- <asm/unistd.h> doesn't include <linux/linkage.h> so it's possible
  another file down the line breaks.

-- 
Tom Rini
http://gate.crashing.org/~trini/

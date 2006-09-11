Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWIKWRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWIKWRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWIKWRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:17:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965068AbWIKWRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:17:06 -0400
Date: Mon, 11 Sep 2006 15:16:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Haverkamp <markh@osdl.org>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc6-mm1
Message-Id: <20060911151655.1a0c4f00.akpm@osdl.org>
In-Reply-To: <1158009592.10005.24.camel@markh3.pdx.osdl.net>
References: <20060908011317.6cb0495a.akpm@osdl.org>
	<1158009592.10005.24.camel@markh3.pdx.osdl.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2006 14:19:52 -0700
Mark Haverkamp <markh@osdl.org> wrote:

> On Fri, 2006-09-08 at 01:13 -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
> > 
> 
> compiling a kernel with allnoconfig produces the following error:
> 
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CHK     include/linux/compile.h
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> mm/built-in.o: In function `writeback_congestion_end':
> (.text+0x5d3b): undefined reference to `blk_congestion_end'
> make: *** [.tmp_vmlinux1] Error 1
> 
> The problem is that the block layer isn't configured and this is where
> the blk_congestion_end symbol comes from.
> 
> This comes from the git-nfs.patch.
> 

Yup, CONFIG_BLOCK=n is bust, sorry.  It's relatively simple to fix but I've
basically thrown up my hands and decided that we can tidy this up once
everything hits mainline.  Or Jens or Trond (whoever merges second) will
fix it prior to merging.

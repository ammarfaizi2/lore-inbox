Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUEYVnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUEYVnS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUEYVnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:43:18 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:13379 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264461AbUEYVnR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:43:17 -0400
Date: Tue, 25 May 2004 23:43:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Kegel <dank@kegel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bringing back 'make symlinks'?
Message-ID: <20040525214328.GA2675@mars.ravnborg.org>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	linux-kernel@vger.kernel.org
References: <40B36A0E.5080509@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B36A0E.5080509@kegel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 08:45:18AM -0700, Dan Kegel wrote:
> In the 2.4 kernel, 'make symlinks' created the symlinks needed
> to use the kernel tree's headers for building a gcc/glibc toolchain.
> 
> In the 2.6 kernel, you can do the same thing with 'include include/asm'.
> Unless you're trying to build arm or cris, or maybe others, in which case 
> you also need
> 'include/asm-$(ARCH)/.arch'.
> 
> That's fine, but it means that a script (like crosstool) or a book (like 
> LFS)
> that's trying to build a gcc/glibc toolchain for both 2.4 and 2.6 ends up
> with a section like
> 
> case "$KERNEL_VERSION.$KERNEL_PATCHLEVEL.x" in
> 2.2.x|2.4.x) make ARCH=$ARCH symlinks    include/linux/version.h
>              ;;
> 2.6.x)       make ARCH=$ARCH include/asm include/linux/version.h
>              case $ARCH in
>              arm*|cris*) make ARCH=$ARCH include/asm-$ARCH/.arch
>                          ;;
>              esac
>              ;;
> *)           abort "Unsupported kernel version 
> $KERNEL_VERSION.$KERNEL_PATCHLEVEL"
> esac

In current 2.6 there exitst a target named: modules_prepare
It does a bit more than what symlinks did in 2.4 - actually prepare for
building external modules.

	Sam

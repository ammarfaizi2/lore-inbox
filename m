Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264689AbUEXUkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbUEXUkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264688AbUEXUkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:40:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:26848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264689AbUEXUkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:40:39 -0400
Date: Mon, 24 May 2004 13:43:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] msync shouldn't go over bss sections
Message-Id: <20040524134314.508bd514.akpm@osdl.org>
In-Reply-To: <1085408042.27361.17.camel@boxen>
References: <1085408042.27361.17.camel@boxen>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@telia.com> wrote:
>
> This changes the behaviour of msync_interval() to make it impossible to
> try to sys_msync() anything not file mapped.
> 

Well the patch doesn't "make it impossible".  It makes it return -ENOMEM.

>From my reading of the spec your patch converts correct behaviour to
incorrect behaviour, and even if that's untrue, I think we're stuck with
the current behaviour - this change can break current applications.


> --- mm/msync_orig.c     2004-05-23 21:31:32.000000000 +0200
> +++ mm/msync.c  2004-05-24 16:10:24.000000000 +0200
> @@ -137,7 +137,7 @@ static int filemap_sync(struct vm_area_s
>  static int msync_interval(struct vm_area_struct * vma,
>         unsigned long start, unsigned long end, int flags)
>  {
> -       int ret = 0;
> +       int ret = -ENOMEM;
>         struct file * file = vma->vm_file;
>   
>         if ((flags & MS_INVALIDATE) && (vma->vm_flags & VM_LOCKED))

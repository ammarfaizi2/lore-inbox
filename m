Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263048AbVCJUgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbVCJUgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbVCJUdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:33:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:38068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263116AbVCJUbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:31:23 -0500
Date: Thu, 10 Mar 2005 12:30:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Direct io on block device has performance regression on 2.6.x
 kernel
Message-Id: <20050310123043.69e5fd48.akpm@osdl.org>
In-Reply-To: <200503101831.j2AIV2g03286@unix-os.sc.intel.com>
References: <20050309200936.0b1bea9e.akpm@osdl.org>
	<200503101831.j2AIV2g03286@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> Losing 6% just from Linux kernel is a huge deal for this type of benchmark.
>  People work for days to implement features which might give sub percentage
>  gain.  Making Software run faster is not easy, but making software run slower
>  apparently is a fairly easy task.
> 
> 

heh

> 
>  > Fine-grained alignment is probably too hard, and it should fall back to
>  > __blockdev_direct_IO().
>  >
>  > Does it do the right thing with a request which is non-page-aligned, but
>  > 512-byte aligned?
>  >
>  > readv and writev?
>  >
> 
>  That's why direct_io_worker() is slower.  It does everything and handles
>  every possible usage scenarios out there.  I hope making the function fatter
>  is not in the plan.

We just cannot make a change like this if it does not support readv and
writev well, and if it does not support down-to-512-byte size and
alignment.  It will break applications.


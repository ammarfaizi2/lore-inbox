Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWAUHxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWAUHxD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 02:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWAUHxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 02:53:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751124AbWAUHxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 02:53:02 -0500
Date: Fri, 20 Jan 2006 23:52:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Don Dupuis <dondster@gmail.com>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: Can't mlock hugetlb in 2.6.15
Message-Id: <20060120235240.39d34279.akpm@osdl.org>
In-Reply-To: <632b79000601181149o67f1c013jfecc5e32ee17fe7e@mail.gmail.com>
References: <632b79000601181149o67f1c013jfecc5e32ee17fe7e@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Dupuis <dondster@gmail.com> wrote:
>
> I have an app that mlocks hugepages. The same app works just fine in 2.6.14.
> This app has 128MB or more of shared memory that is using hugepages via
> mmap. When I try this, I get the error "can't allocate memory".  Is this a
> kernel bug or is this not supported anymore.  I want to guarantee that
> this memory doesn't get swapped out to a swap device.

hugetlb areas are not pageable and it's very unlikely that they will become
so in the forseeable future.  So you don't need to do this.

That being said, we shouldn't have broken your application.

I guess a suitable back-compatibility fix would be to check for a hugetlb
vma early on and return "success" for that vma section without actually
doing anything.

But we need to understand why this happened.

> I made the same
> modifications to include/linux/resource.h that was in 2.6.14, which
> set MLOCK_LIMIT to 2GB.
> 

That's rather naughty of you ;) You're supposed to use setrlimit() in a
parent process for this...


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVKKDNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVKKDNL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 22:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVKKDNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 22:13:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932325AbVKKDNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 22:13:10 -0500
Date: Thu, 10 Nov 2005 19:12:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arun Sharma <arun.sharma@google.com>
Cc: rohit.seth@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Expose SHM_HUGETLB in shmctl(id, IPC_STAT, ...)
Message-Id: <20051110191254.2206860f.akpm@osdl.org>
In-Reply-To: <437406D4.4060304@google.com>
References: <20051109184623.GA21636@sharma-home.net>
	<20051109222223.538309e4.akpm@osdl.org>
	<43739302.1080404@google.com>
	<20051110115941.1cbe1ae7.akpm@osdl.org>
	<4373BE8D.2070104@google.com>
	<20051110140621.47729c5b.akpm@osdl.org>
	<437406D4.4060304@google.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arun Sharma <arun.sharma@google.com> wrote:
>
>  Andrew Morton wrote:
> 
>  >>>How important is this feature?
>  >>
>  >>Without this feature, an application has no way to figure out if a given 
>  >>segment is hugetlb or not. Applications need to know this to be able to 
>  >>handle alignment issues properly.
>  >>
>  >>Also, if the flag is exported via ipcs, the system administrator would 
>  >>have a better idea about how the hugetlb pages she configured on the 
>  >>system are getting used.
>  >>
>  > 
>  > 
>  > I'd suggest that any API which allows us to query the hugeness of a piece
>  > of memory should also work for mmap(hugetld_fd...).  IOW: this capability
>  > shouldn't be restricted to sysv shm areas.
> 
>  The capability I was talking about was the ability to figure out where 
>  the configured hugetlb pages are going (vs is this a hugetlb page?).

Well, please figure out a way which has less risk of breaking userspace.

Bear in mind that the sort of apps we're talking about here are
dubiously-written monsters with long and costly upgrade cycles and we tend
to not get any reports until many many months after we made a kernel
change.  It's very costly all round and we need to be cautious.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVI1Kcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVI1Kcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 06:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVI1Kcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 06:32:53 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:35039 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750869AbVI1Kcw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 06:32:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dUmNkajE3pZ7QpGlN4Sm1L35LaESc3vlfWXX/TiS9H0QMkpoOCrxuBpxmmdsOe3vdUhIcAeG1F9JU3ObG/C6KNtXAiZ32RETCPEwTvEFA/4SRN4ATBc57tdXvCLNZ2kztlnsQUGgHfHpqYNRio2tMuFWEUAbp8tP5/PO508+t6Q=
Message-ID: <1e62d13705092803329ed334a@mail.gmail.com>
Date: Wed, 28 Sep 2005 15:32:51 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: Fawad Lateef <fawadlateef@gmail.com>
To: lk <linux_kernel@patni.com>
Subject: Re: alloc_page_buffers() - kernel panic?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <002f01c5c412$194561c0$5e91a8c0@patni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <002f01c5c412$194561c0$5e91a8c0@patni.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, lk <linux_kernel@patni.com> wrote:
> I was looking at the fs(buffer.c) code, An observation:
>
> alloc_page_buffers() is called from the function create_empty_buffers() . If
> the memory allocation for the buffer head (through kmem_cache_alloc) fails
> the allocation is retried till successful for async I/O. However for
> synchronous I/O no such handling is done and create_buffer will return
> NULL which is not checked in the calling function. The pointer returned by
> NULL
> is used without checking for the NULL condition. This would result in a
> kernel panic when alloc_page_buffers() is not able to allocate buffer heads
> from the cache for sync I/O.
>

I think you overlooked alloc_page_buffers call from
create_empty_buffers .... It is called with third argument as 1 and it
is the retry argument in alloc_page_buffers function which checks
if(!retry) return NULL; so it will never return NULL if retry is 1
..........

> Is anyone aware of the thought process behind this difference in
> implementation for sync and async I/O.
>

what kind of difference ?? If its allocation of page buffers then
async IOs are not allowed to fail so it waits to allocate
memory/buffers for it ....


--
Fawad Lateef

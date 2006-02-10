Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWBJDv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWBJDv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 22:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWBJDv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 22:51:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53642 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751038AbWBJDv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 22:51:26 -0500
Date: Thu, 9 Feb 2006 19:50:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20060209195035.5403ce95.akpm@osdl.org>
In-Reply-To: <43EC0A44.1020302@yahoo.com.au>
References: <20060209071832.10500.qmail@science.horizon.com>
	<20060209001850.18ca135f.akpm@osdl.org>
	<43EAFEB9.2060000@yahoo.com.au>
	<20060209004208.0ada27ef.akpm@osdl.org>
	<43EB3801.70903@yahoo.com.au>
	<20060209094815.75041932.akpm@osdl.org>
	<43EC0A44.1020302@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  > It's a bit of a disaster if you happen to msync(MS_ASYNC) the same page at
>  > any sort of frequency - we have to wait for the previous I/O to complete
>  > before new I/O can be started.  That was the main problem which caused this
>  > change to be made.  You can see that it'd make 100x or 1000x speed improvements
>  > with some sane access patterns.
>  > 
> 
>  I'm not sure you'd have to do that, would you? Just move the dirty bit
>  from the pte and skip the page if it is found locked or writeback.

That would make MS_ASYNC mean "start I/O now, unless there's I/O in
progress, in whch case start I/O in 30 seconds.  That's not good.

If we're going to change the kernel, better off using fadvise()
enhancements, whic are also useful for post-write() operations.


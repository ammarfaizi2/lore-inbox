Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSGBIgL>; Tue, 2 Jul 2002 04:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSGBIgK>; Tue, 2 Jul 2002 04:36:10 -0400
Received: from holomorphy.com ([66.224.33.161]:29667 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316677AbSGBIgK>;
	Tue, 2 Jul 2002 04:36:10 -0400
Date: Tue, 2 Jul 2002 01:37:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Erik Andersen <andersen@codepoet.org>, Timo Benk <t_benk@web.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: allocate memory in userspace
Message-ID: <20020702083737.GQ22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erik Andersen <andersen@codepoet.org>, Timo Benk <t_benk@web.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20020701172659.GA4431@toshiba> <20020701174913.GA19338@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020701174913.GA19338@codepoet.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 11:49:13AM -0600, Erik Andersen wrote:
> void *malloc(size_t size)
> {
>     void *result;
>     if (size == 0)
> 	return NULL;
>     result = mmap((void *) 0, size + sizeof(size_t), PROT_READ | PROT_WRITE, 
> 	    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>     if (result == MAP_FAILED)
> 	return 0;
>     * (size_t *) result = size;
>     return(result + sizeof(size_t));
> }

This looks like a very bad idea. Userspace allocators should make some
attempt at avoiding diving into the kernel at every allocation like this.
Also, they should be intelligent enough to get around TASK_UNMAPPED_BASE.
Wilson's allocator survey has an excellent discussion of the issues.
Doug Lea has a better example of a userspace memory allocator.


Cheers,
Bill

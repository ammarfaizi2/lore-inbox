Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbULIVxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbULIVxL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 16:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbULIVxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 16:53:11 -0500
Received: from quark.didntduck.org ([69.55.226.66]:39356 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261625AbULIVxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 16:53:06 -0500
Message-ID: <41B8C952.3050104@didntduck.org>
Date: Thu, 09 Dec 2004 16:53:22 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Imanpreet Singh Arora <imanpreet@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question from Russells Spinlocks
References: <41B76B7E.9020706@gmail.com>
In-Reply-To: <41B76B7E.9020706@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Imanpreet Singh Arora wrote:
> 
> Hello there,
> 
>    I was reading Russell's guide on spinlocks, and I have some questions 
> regarding it.
> 
> 
>    Question-->    Russell says that in case of non-SMP machines 
> spinlocks don't exist _at_ALL_. Well they should do something don't they 
> like disable interrupts and premptations. I checked linux/spinlock well 
> they DO NOT do anything atleast not when DEBUG_SPINLOCKS == 0. My 
> understanding is that since they aren't used anywhere outside kernel and 
> drivers(?), they can't be prempted. At least that is what I have read.
> 

On UP kernels, the spinlock operations that include interrupt 
manipulations still affect interrupts.  It's only the actual lock 
portion that becomes a no-op.

> 
> What does the comment about gcc while defining atomic_t signify?
>             --> What about the comment about the limit of 24 bits on 
> atomic_t?                a)    Atomic operations on integers are 
> guranteed only if there value can be stored in 24 bits.
>             b)    Atomic operations are guranteed only if the pointer 
> has 8 MSbits set zero.
> 
> 

In 2.6, the 24-bit limit is no longer valid.  atomic_t variables are a 
full 32 bits on all arches now.

--
				Brian Gerst


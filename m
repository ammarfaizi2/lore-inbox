Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWEIFwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWEIFwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 01:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWEIFwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 01:52:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751404AbWEIFwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 01:52:30 -0400
Date: Mon, 8 May 2006 22:49:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Add SYSTEM_BOOTING_KMALLOC_AVAIL system_state
Message-Id: <20060508224952.0b43d0fd.akpm@osdl.org>
In-Reply-To: <20060509053512.GA20073@monkey.ibm.com>
References: <20060509053512.GA20073@monkey.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <kravetz@us.ibm.com> wrote:
>
> There are a few places that check the system_state variable to
>  determine if they should use the bootmem or kmalloc allocator.
>  However, this is not accurate as system_state transitions from
>  SYSTEM_BOOTING to SYSTEM_RUNNING well after the bootmem allocator
>  is no longer usable.  Introduce the SYSTEM_BOOTING_KMALLOC_AVAIL
>  state which indicates the kmalloc allocator is available for use.

Let's not do this - system_state is getting out of control.

How about some private boolean in slab.c, and some special allocation
function like

void __init *alloc_memory_early(size_t size, gfp_t gfp_flags)
{
	if (slab_is_available)
		return kmalloc(size, gfp_flags);
	return alloc_bootmem(size);
}	

?

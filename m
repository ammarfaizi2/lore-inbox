Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWBQFre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWBQFre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 00:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWBQFre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 00:47:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23509 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932212AbWBQFrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 00:47:33 -0500
Date: Thu, 16 Feb 2006 21:49:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Generic is_compat_task helper
Message-Id: <20060216214939.78aebcbb.akpm@osdl.org>
In-Reply-To: <20060217025242.GM13492@quicksilver.road.mcmartin.ca>
References: <20060217025242.GM13492@quicksilver.road.mcmartin.ca>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle McMartin <kyle@parisc-linux.org> wrote:
>
> Implement a generic is_compat_task function. It should only be used
> when absolutely necessary. For example, to clean up the per-architecture
> tests in drivers/input/evdev.c.
> 
> Prototype is such that the existing asm-x86_64 helper needs no change.
> 
> Architecture maintainers must add an appropriate implementation to
> asm/compat.h, if needed.
> 
> ...
>
> +static inline int __is_compat_task(struct task_struct *t)
> +{
> +	return (personality(t->personality) == PER_LINUX32);
> +}
> +

What continues to bug me about this (in a high-level hand-wavy sort of way)
is that this is an attribute of the mm_struct, not of the task_struct.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVF2AnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVF2AnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVF2Amr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:42:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1233 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262323AbVF2ABU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:01:20 -0400
Date: Tue, 28 Jun 2005 17:02:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 06/16] IB uverbs: memory pinning implementation
Message-Id: <20050628170212.24623191.akpm@osdl.org>
In-Reply-To: <2005628163.qcqYIUxXOrm3IH43@cisco.com>
References: <2005628163.jfSiMqRcI78iLMJP@cisco.com>
	<2005628163.qcqYIUxXOrm3IH43@cisco.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
> Add support for pinning userspace memory regions and returning a list
> of pages in the region.  This includes tracking pinned memory against
> vm_locked and preventing unprivileged users from exceeding RLIMIT_MEMLOCK.
> 

Can you tell us a bit more about the design ideas here?  What's it doing,
how and why?

We should look at these things and also decide whether some of this should
live in mm/*.

> +int ib_umem_get(struct ib_device *dev, struct ib_umem *mem,
> +		void *addr, size_t size, int write)
> +{
> ...
> +	if (!can_do_mlock())
> +		return -EPERM;
> +
> ...
> +	if ((locked > lock_limit) && !capable(CAP_IPC_LOCK)) {

The capable() test is redundant.

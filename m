Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267813AbUG3UEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267813AbUG3UEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267816AbUG3UEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:04:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:64936 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267813AbUG3UEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:04:09 -0400
Date: Fri, 30 Jul 2004 13:02:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] Improve pci_alloc_consistent wrapper on preemptive
 kernels
Message-Id: <20040730130238.0f68f5e7.akpm@osdl.org>
In-Reply-To: <20040730190227.29913e23.ak@suse.de>
References: <20040730190227.29913e23.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> This is a minor optimization for the pci_alloc_consistent wrapper for
>  the generic dma API. When the kernel is compiled preemptive the caller
>  can decide if the allocation needs to be GFP_KERNEL or GFP_ATOMIC.

We're paying for past sins here.  I think it would be better to create a
new version of pci_alloc_consistent() which takes gfp_flags, then migrate
the drivers you care about to use it.  That way the benefit is available on
non-preempt kernels too.

The ultimate aim of course would be to deprecate then remove the old
function.


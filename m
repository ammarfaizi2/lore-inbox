Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVCCCvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVCCCvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVCCCsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:48:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:6561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261434AbVCCCr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:47:27 -0500
Date: Wed, 2 Mar 2005 18:46:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, scalability@gelato.org
Subject: Re: [PATCH] Fixing address space lock contention in 2.6.11
Message-Id: <20050302184653.3ea8e29d.akpm@osdl.org>
In-Reply-To: <16934.28560.325928.858464@berry.gelato.unsw.EDU.AU>
References: <16934.28560.325928.858464@berry.gelato.unsw.EDU.AU>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
>
> 
> Hi,
> 	As part of the Gelato scalability focus group, we've been running
> OSDL's Re-AIM7 benchmark with an I/O intensive load with varying
> numbers of processors.  The current kernel shows severe contention on
> the tree_lock in the address space structure when running on tmpfs or
> ext2 on a RAM disk.
> 

Yup.

Problem is, an rwlock is a little bit slower than a spinlock on a P4 due to
the buslocked unlock, and a lot of people have p4's.

Could you do some testing on a 2-way p4?

> Anyway, here's the patch to convert the address space lock to a
> rwlock, and allow multiple processes to scan an address-space's radix
> tree at once.

dude, make-tree_lock-an-rwlock.patch has been in -mm since May 2004.  I've
just been waiting for someone to justify merging it.


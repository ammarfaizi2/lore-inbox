Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTJAOvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTJAOvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:51:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:48078 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262434AbTJAOus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:50:48 -0400
Date: Wed, 1 Oct 2003 07:51:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: hugh@veritas.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata
 patch
Message-Id: <20031001075151.4e595f99.akpm@osdl.org>
In-Reply-To: <20031001093329.GA2649@mail.shareable.org>
References: <20031001073132.GK1131@mail.shareable.org>
	<Pine.LNX.4.44.0310010900280.5501-100000@localhost.localdomain>
	<20031001093329.GA2649@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
>  > What about the 4G+4G split?
> 
>  Whoever is looking after the 4G+4G patch can deal with it, presumably.
>  It'll be the same condition ad 4G+4G uses to decide if it's an access
>  to userspace (needing a search of the vma list), or not.

It should "just work".   4G+4G is false advertising:

#ifdef CONFIG_X86_4G_VM_LAYOUT
#define __PAGE_OFFSET		(0x02000000)
#define TASK_SIZE		(0xff000000)
#else

I'm a bit confused as to what significance the faulting address has btw:
kernel code can raise prefetch faults against addresses which are less
than, and presumably greater than TASK_SIZE.


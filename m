Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbTEFFeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 01:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbTEFFeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 01:34:05 -0400
Received: from [12.47.58.20] ([12.47.58.20]:56078 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262149AbTEFFeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 01:34:04 -0400
Date: Mon, 5 May 2003 22:48:15 -0700
From: Andrew Morton <akpm@digeo.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-Id: <20030505224815.07e5240c.akpm@digeo.com>
In-Reply-To: <20030505.211606.28803580.davem@redhat.com>
References: <20030506040856.8B3712C36E@lists.samba.org>
	<20030505.204002.08338116.davem@redhat.com>
	<20030505220250.213417f6.akpm@digeo.com>
	<20030505.211606.28803580.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 05:46:29.0378 (UTC) FILETIME=[D73D5620:01C31392]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> 
> Please address the ia64 concerns then :-)  It probably means we
> have to stay with the dereferencing stuff...  at which point you
> might as well use normal kmalloc() and smp_processor_id() indexing
> inside of modules.

I think so.  So we'd end up with:

- DEFINE_PER_CPU and kmalloc_percpu() work in core kernel, and use the 32k
  pool.

- DEFINE_PER_CPU in modules uses the 32k pool as well (core kernel does the
  allocation).

- kmalloc_per_cpu() is unavailble to modules (it ain't exported).

AFAICT the only thing which will break is sctp, which needs a trivial
conversion to DEFINE_PER_CPU.


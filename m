Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVKHGMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVKHGMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 01:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbVKHGMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 01:12:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964942AbVKHGMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 01:12:34 -0500
Date: Mon, 7 Nov 2005 22:11:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] use ptrace_get_task_struct in various places
Message-Id: <20051107221149.08aa0820.akpm@osdl.org>
In-Reply-To: <20051108053049.GA9422@lst.de>
References: <20051108053049.GA9422@lst.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> The ptrace_get_task_struct() helper that I added as part of the ptrace
> consolidation is usefull in variety of places that currently opencode
> it.  Switch them to the common helper.

If we're going to export ptrace_get_task_struct() to the world it would be
nice to document it too - things like returning zero and a NULL *childp is
a little obscure.

The change breaks ALLOW_INIT_TRACING in sparc32 and sparc64.  I don't know
if that matters.  If (presumably) not, there are cleanups left over.

In arch/ia64/ia32/sys_ia32.c this patch will cause PTRACE_TRACEME requests
to be handled by ptrace_request() rather than by sys_ptrace(), which is a
not-obviously-correct change.

Was the omission of arch/ia64/kernel/ptrace.c:sys_ptrace() deliberate?


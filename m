Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266739AbUGLGjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266739AbUGLGjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 02:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266740AbUGLGjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 02:39:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:31455 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266739AbUGLGjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 02:39:02 -0400
Date: Sun, 11 Jul 2004 23:37:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Instrumenting high latency
Message-Id: <20040711233750.2050c4b1.akpm@osdl.org>
In-Reply-To: <cone.1089613755.742689.28499.502@pc.kolivas.org>
References: <cone.1089613755.742689.28499.502@pc.kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Because of the recent discussion about latency in the kernel I asked William 
> Lee Irwin III to help create some instrumentation to determine where in the 
> kernel there were still sustained periods of non-preemptible code. He hacked 
> together this simple patch which times periods according to the preempt 
> count.

Looks sane.

> The patch appears to require CONFIG_PREEMPT enabled on uniprocessor and is 
> i386 only at the moment.

Not sure what you mean by "on uniprocessor"?  AFAICT the patch will work
as-is on uniprocessor and on SMP.  Looks like it'll work with
CONFIG_PREEMPT=n, too, although that would be a slightly bizarre thing to
do.

+				print_symbol("%s\n",
+					__get_cpu_var(preempt_exit));

I'll change this to

				print_symbol("%s",
					__get_cpu_var(preempt_exit));
				printk("\n");

so it doesn't make a mess with CONFIG_KALLSYMS=n.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWCWCua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWCWCua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 21:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWCWCua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 21:50:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60552 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964910AbWCWCu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 21:50:29 -0500
Date: Wed, 22 Mar 2006 18:37:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
       linux-ia64@vger.kernel.org
Subject: Re: perfmon2 context: thread_struct vs. task_struct?
Message-Id: <20060322183736.4a3bb1c2.akpm@osdl.org>
In-Reply-To: <20060322233253.GB26602@frankl.hpl.hp.com>
References: <20060322233253.GB26602@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@hpl.hp.com> wrote:
>
> Hello,
> 
> The perfmon2 subsystem maintains a structure per-thread
> that contains the save-area for the performance counters
> and related software state. The save area is used on
> context-switch. There can only be one context per thread.
> The context is dynamically allocated as such it does not
> consume memory in each thread. It is dyanmically attached
> to the thread to monitor.
> 
> In the current implementation, the context (pfm_context)
> pointer is implemented in the thread_struct on the basis
> that this is somewhat related to machine state.
> 
> Historically, the perfmon subsystem only existed on IA-64
> which made the thread_struct (an arch-specific structure)
> the obvious place to put this.
> 
> Nowadays, perfmon2 supports most major architectures. It
> may make sense to move the void *pfm_context pointer from 
> the thread_struct into the task_struct. This would save
> some indirections, make it readily available to other
> archiectures when it is ported.
> 
> I admit I am not quite clear as to what goes where between
> thread_struct and task_struct.
> 
> Would it make sense  to move the pointer to the perfmon2
> context into the task_struct?

I'd say so, yes.  Especialy if the struct is the same on all architectures,
is referred to from non-arch-specific code and is absent if
CONFIG_PERFMON=n.


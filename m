Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbWCVXh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWCVXh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWCVXh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:37:28 -0500
Received: from palrel13.hp.com ([156.153.255.238]:63677 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S932622AbWCVXh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:37:26 -0500
Date: Wed, 22 Mar 2006 15:32:53 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org
Subject: perfmon2 context: thread_struct vs. task_struct?
Message-ID: <20060322233253.GB26602@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The perfmon2 subsystem maintains a structure per-thread
that contains the save-area for the performance counters
and related software state. The save area is used on
context-switch. There can only be one context per thread.
The context is dynamically allocated as such it does not
consume memory in each thread. It is dyanmically attached
to the thread to monitor.

In the current implementation, the context (pfm_context)
pointer is implemented in the thread_struct on the basis
that this is somewhat related to machine state.

Historically, the perfmon subsystem only existed on IA-64
which made the thread_struct (an arch-specific structure)
the obvious place to put this.

Nowadays, perfmon2 supports most major architectures. It
may make sense to move the void *pfm_context pointer from 
the thread_struct into the task_struct. This would save
some indirections, make it readily available to other
archiectures when it is ported.

I admit I am not quite clear as to what goes where between
thread_struct and task_struct.

Would it make sense  to move the pointer to the perfmon2
context into the task_struct?

Thanks.

-- 
-Stephane

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTLLVFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTLLVFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:05:39 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:9225
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261973AbTLLVFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:05:37 -0500
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide
From: Rob Love <rml@tech9.net>
To: Dave Jones <davej@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20031212154401.GA10584@redhat.com>
References: <20031212052812.E80972C085@lists.samba.org>
	 <20031212154401.GA10584@redhat.com>
Content-Type: text/plain
Message-Id: <1071263135.13785.212.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Fri, 12 Dec 2003 16:05:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-12 at 10:44, Dave Jones wrote:

>  Might be worth mentioning in the Per-CPU data section that code doing
> operations on CPU registers (MSRs and the like) needs to be protected
> by an explicit preempt_disable() / preempt_enable() pair if it's doing
> operations that it expects to run on a specific CPU.
> 
> For examples, see arch/i386/kernel/msr.c & cpuid.c

Good point.

I think this can be generalized to "you must remain atomic so long as
you expect the processor state to remain consistent."  For example,
while manipulating processor registers or modes.

This means that you must disable kernel preemption and must not sleep
within the critical region.

	Rob Love



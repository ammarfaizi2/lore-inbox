Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbTLLQ0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 11:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbTLLQ0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 11:26:04 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:38917 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S265271AbTLLQ0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 11:26:02 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide 
In-reply-to: Your message of "Fri, 12 Dec 2003 15:44:01 -0000."
             <20031212154401.GA10584@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Dec 2003 03:25:52 +1100
Message-ID: <4939.1071246352@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003 15:44:01 +0000, 
Dave Jones <davej@redhat.com> wrote:
> Might be worth mentioning in the Per-CPU data section that code doing
>operations on CPU registers (MSRs and the like) needs to be protected
>by an explicit preempt_disable() / preempt_enable() pair if it's doing
>operations that it expects to run on a specific CPU.

Also calls to smp_call_function() need to be wrapped in preempt_disable,
plus any work that is done on the current cpu before/after calling a
function on the other cpus.  Lack of preempt disable could result in
the operation being done twice on one cpu and not at all on another.


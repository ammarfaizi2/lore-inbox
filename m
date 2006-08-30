Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWH3Mjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWH3Mjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWH3Mjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:39:53 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:28857 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750886AbWH3Mjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:39:52 -0400
Date: Wed, 30 Aug 2006 08:33:40 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for
  i386.
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Message-ID: <200608300838_MC3-1-C9C6-CA79@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44F557A8.1030605@goop.org>

On Wed, 30 Aug 2006 02:17:28 -0700, Jeremy Fitzhardinge wrote:

> > This changes the ABI for signals and ptrace() and that seems like
> > a bad idea to me.
> >   
> 
> I don't believe it does; it certainly shouldn't change the usermode 
> ABI.  How do you see it changing?

Nevermind.  I thought because you changed struct pt_regs in ptrace_abi.h
it meant a user ABI change.

> > And the way things are done now is so ingrained into the i386
> > kernel that I'm not sure it can be done.  E.g. I found two
> > open-coded implementations of current, one in kernel_fpu_begin()
> > and one in math_state_restore().
> >   
> 
> That's OK.  The current task will still be available in thread_info; 

But they can get out of sync, e.g. when switch_to() restores the new
task's esp, the PDA still contains the old pcurrent and they don't get
synchronized until the write_pda() in __switch_to().

> To be honest, I haven't looked at percpu.h in great detail.  I was 
> making assumptions about how it works, but it looks like they were wrong.

Would it make any sense to replace the 'cpu' field in thread_info with
a pointer to a PDA-like structure?  We could even embed the static per_cpu
data directly into that struct instead of chasing pointers...

-- 
Chuck


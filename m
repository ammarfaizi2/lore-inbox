Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUJ0XcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUJ0XcU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbUJ0X2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 19:28:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:60089 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262772AbUJ0X1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 19:27:17 -0400
Date: Thu, 28 Oct 2004 01:27:15 +0200
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Early call_usermodehelper causes double fault on x86_64
Message-ID: <20041027232715.GE23595@wotan.suse.de>
References: <20041027124055.B2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027124055.B2357@build.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 12:40:55PM -0700, Chris Wright wrote:
> Hi,
> 
> I'm seeing a double fault on recent (2.6.10-rc1-bk) kernels during
> driver_init().  The upcall to userspace gets far enough to schedule the
> work, khelper picks it up, calls kernel_thread, the child thread does
> execve, then double faults.  Bootup continues, I get three more double
> faults, then the system appears fine (even w/ continued upcalls).
> 
> I have an example of the fault below.  It shows a rip and rsp
> of 0.  I poked about a bit and see that the FAKE_STACK_FRAME $0 in
> arch/x86-64/kernel/entry.S sets up a 0 rip, and if I change the \rip
> in that macro call, that's the rip in the double fault.  Any ideas on
> further debugging?

It looks like do_execve returned with a zero return without
executing start_thread properly. I would add a printk to 
all error exits in the execve path and see which one triggers.

-Andi

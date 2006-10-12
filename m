Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWJLVFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWJLVFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWJLVFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:05:21 -0400
Received: from xenotime.net ([66.160.160.81]:54249 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750869AbWJLVFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:05:20 -0400
Date: Thu, 12 Oct 2006 14:06:44 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Edward Goggin <egoggin@emc.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: looking for explanation of spontaneous reset/reboot on Opteron
Message-Id: <20061012140644.732227f7.rdunlap@xenotime.net>
In-Reply-To: <6CCEAEDF4D06984A83F427424F47D6E4013D1446@CORPUSMX40A.corp.emc.com>
References: <6.2.3.4.0.20061012095229.048db398@pop-server.san.rr.com>
	<6CCEAEDF4D06984A83F427424F47D6E4013D1446@CORPUSMX40A.corp.emc.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 13:43:15 -0400 Edward Goggin wrote:

> I'm looking for information about potential causes for a
> spontaneous reboot of a dual core Opteron running RHEL 4
> linux (2.6.9 derivative).  I'm thinking the cause is
> due to the box taking a triple fault and resetting the
> BIOS.
> 
> I'm also thinking that the triple fault is caused by a
> kernel stack overflow into an unmapped virtual page
> frame.  Is this a reasonable explanation?  Are there
> others?
> 
> What are reasonable debugging strategies for handling
> this?  Following the kernel stack overflow hunch, I'm
> going to try increasing the Opteron stack size from
> 8K to 16K.  Can this be done by simply changing
> THREAD_ORDER in include/asm-x86_64/page.h from 1 to 2?
> 
> Also, is there any kernel stack overflow detection
> debugging code anywhere for x86_64 as there is for
> i386?

[Please start a new thread instead of replying to a diff.
one and changing the subject.]

arch/x86_64/Kconfig.debug has these Kernel hacking options:
[but I'm not talking about 2.6.9; maybe you should/could try
a newer kernel]

config DEBUG_STACKOVERFLOW
        bool "Check for stack overflows"
        depends on DEBUG_KERNEL
        help
	  This option will cause messages to be printed if free stack space
	  drops below a certain limit.

config DEBUG_STACK_USAGE
        bool "Stack utilization instrumentation"
        depends on DEBUG_KERNEL
        help
	  Enables the display of the minimum amount of free stack which each
	  task has ever had available in the sysrq-T and sysrq-P debug output.

	  This option will slow down process creation somewhat.


---
~Randy

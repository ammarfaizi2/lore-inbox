Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269163AbUINGnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269163AbUINGnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269169AbUINGnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:43:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:3327 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269163AbUINGjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:39:37 -0400
Date: Tue, 14 Sep 2004 12:11:53 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: jBeulich@novell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: hardware breakpoints questions
Message-ID: <20040914064153.GE32365@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan,

> Why is it that user mode has to have knowledge about the layout and
>number of debug registers?
	User should know the number of debug registers,to use them efficiently.
On i386 architecture the primary function of the debug registers is to set 
up and monitor from 1 to 4 breakpoints, numbered 0 though 3. 
For each breakpoint, the following information can be specified and 
detected with the debug registers: 

1.The linear address where the breakpoint is to occur. 
2.The length of the breakpoint location (1, 2, or 4 bytes). 
3.The operation that must be performed at the address for a debug exception 
to be generated. 
4.Whether the breakpoint is enabled. 
5.Whether the breakpoint condition was present when the debug exception 
was generated.

>- Why is it that (on i386/x86-64) one can't, say, set a byte-range
>breakpoint on TASK_SIZE - 1 (whatever this may be good for)?

On i386 Bits 18, 19, 22, 23, 26, 27, 30, and 31 in DR7 register specify the 
size of the memory location at the address specified in the corresponding 
breakpoint address register (DR0 through DR3). These fields are interpreted 
as follows: 

00 1-byte length 
01 2-byte length 
10 Undefined 
11 4-byte length
	that's why you cant set a byte-range to the size of TASK_SIZE.

>- Why is it that (on i386/x86-64) one can't set 2- or 4-byte-range
>execution breakpoints, but one can (on x86-64) set 8-byte-range ones?

refere x86_64 architecure manuals. 

More information can be found in i386/x86_64 manuals.

Also Kprobes provides interface to set and remove watchpoints.
Kernel watchpoints information can be found at URL:
http://www-124.ibm.com/developerworks/oss/linux/projects/kprobes/
Let me know if you need more information on kernel watchpoint probes.

>Thanks, Jan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269230AbUINJbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269230AbUINJbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269236AbUINJbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:31:51 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:19635
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S269230AbUINJbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:31:32 -0400
Message-Id: <s146c882.038@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Tue, 14 Sep 2004 11:32:16 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <prasanna@in.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: hardware breakpoints questions
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think you read questions 2 and 3 I intended them to be read. I
know of all the hardware details. The questions raised point out
inconsistencies which I try to find reasons for (or if there are no
reasons, then eliminate the inconsistencies).

As to the user mode one, you don't answer it either. Per se, user mode
doesn't have to know anything about the hardware details. The ptrace
interface could (should in my opinion) instead allow for an abstract
request for setting a (hardware) breakpoint. If the request can be
fulfilled with what the underlying architecture supports, then this
would succeed. If you look at the 'global debugregs' patch, you already
see what trying to overcome this results in. Trying to put in more
sophisticated break point handling makes the whole situation even
worse.

Jan

>>> Prasanna S Panchamukhi <prasanna@in.ibm.com> 14.09.04 08:41:53 >>>
Jan,

> Why is it that user mode has to have knowledge about the layout and
>number of debug registers?
	User should know the number of debug registers,to use them
efficiently.
On i386 architecture the primary function of the debug registers is to
set 
up and monitor from 1 to 4 breakpoints, numbered 0 though 3. 
For each breakpoint, the following information can be specified and 
detected with the debug registers: 

1.The linear address where the breakpoint is to occur. 
2.The length of the breakpoint location (1, 2, or 4 bytes). 
3.The operation that must be performed at the address for a debug
exception 
to be generated. 
4.Whether the breakpoint is enabled. 
5.Whether the breakpoint condition was present when the debug exception

was generated.

>- Why is it that (on i386/x86-64) one can't, say, set a byte-range
>breakpoint on TASK_SIZE - 1 (whatever this may be good for)?

On i386 Bits 18, 19, 22, 23, 26, 27, 30, and 31 in DR7 register specify
the 
size of the memory location at the address specified in the
corresponding 
breakpoint address register (DR0 through DR3). These fields are
interpreted 
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
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbVLCDdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVLCDdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 22:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVLCDdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 22:33:55 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45819 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750998AbVLCDdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 22:33:54 -0500
Date: Fri, 02 Dec 2005 21:33:49 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: copy_from_user/copy_to_user question
In-reply-to: <1133580225.4894.29.camel@localhost.localdomain>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vinay Venkataraghavan <raghavanvinay@yahoo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4391121D.9080305@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5fv0G-3kS-11@gated-at.bofh.it> <5fvam-3vP-9@gated-at.bofh.it>
 <43910731.4090404@shaw.ca> <1133580225.4894.29.camel@localhost.localdomain>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> Nope, the kernel is always locked into memory.  If you take a page fault
> from the kernel world, you will crash and burn. The kernel is never
> "swapped out".  So if you are in kernel mode, going into do_page_fault
> in arch/i386/mm/fault.c there is no path to swap a page in.  Even the
> vmalloc_fault only handles a page not in the page global descriptor of
> the current task.  But if this page is not mapped somewhere in memory
> (not swapped out), you will get a kernel oops.
> 
> Kernel memory may never be swapped out. What happens if an interrupt
> tries to use such memory. How does it handle sleeping?
> 
> Just change copy_to_user into memcopy, and see how long your system
> stays up and running.  Do it on a machine that you don't need to worry
> about rogue applications.  It won't last very long.

Yes, kernel memory is never swapped out. But my point is merely that as 
far as I know there is no special handling in the copy_to/from_user 
functions to handle the case where the userspace memory is swapped out, 
and therefore this would not be an issue for accessing the memory 
directly. Obviously this is not something that one should actually do, 
since access faults are not trapped and on some architectures or 
configurations it won't work at all.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


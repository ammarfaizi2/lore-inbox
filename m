Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbUDLOdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbUDLOc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:32:59 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:59090 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262981AbUDLOcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:32:13 -0400
Message-ID: <407AA848.2000008@nortelnetworks.com>
Date: Mon, 12 Apr 2004 10:31:36 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: want to clarify powerpc assembly conventions in head.S	and	entry.S
References: <4077A542.8030108@nortelnetworks.com>	 <1081591559.25144.174.camel@gaston>  <4078D42C.1020608@nortelnetworks.com> <1081661150.1380.183.camel@gaston>
In-Reply-To: <1081661150.1380.183.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>You knew this was coming...  What's special about syscalls?  There's the 
>>r3 thing, but other than that...
> 
> The whole codepath is a bit different, there's the syscall trace,
> we can avoid saving much more registers are syscalls are function
> calls and so can clobber the non volatiles, etc...

It appears that we always enter the kernel via "transfer_to_handler", 
and return via "ret_from_except".  Is this true? (I'm running on at 
least a 74xx chip.)

I want to insert two new bits of code, one that gets called before the 
exception handler when we drop from userspace to kernelspace, and one as 
late as possible before going back to userspace.  I need to catch 
syscalls, interrupts, exceptions, everything.

The entry one I planned on putting in "transfer_to_handler", just before 
"addi   r11,r1,STACK_FRAME_OVERHEAD".

I was planning on putting the exit one just after the "restore_user" 
label.  Will this catch all possible returns to userspace?

Thanks,

Chris

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTE2VRr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTE2VRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:17:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58609 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263011AbTE2VRo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:17:44 -0400
Date: Thu, 29 May 2003 16:30:54 -0500
Subject: Re: [CHECKER] pcmcia user-pointer dereference
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org, Junfeng Yang <yjf@stanford.edu>
To: David Hinds <dhinds@sonic.net>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <20030529142238.A8933@sonic.net>
Message-Id: <D43209EB-921C-11D7-B8B8-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 29, 2003, at 16:22 US/Central, David Hinds wrote:

> On Thu, May 29, 2003 at 04:11:19PM -0500, Hollis Blanchard wrote:
>>
>> I contacted David Hinds about this; the behavior is by design. User
>> space passes in a pointer to a kernel data structure, and the kernel
>> verifies it by checking a magic number in that structure.
>>
>> It seems possible to perform some activity from user space to get the
>> magic number into (any) kernel memory, then iterate over kernel space
>> by passing pointers to the pcmcia ds_ioctl() until you manage to
>> corrupt something. But I'm not really a security guy...
>
> This ioctl just returns the contents of another field of that same
> data structure that contains the magic number.  So, a malicious user
> could, if they were able to cause another kernel data structure to
> contain that magic number and they knew the address of that data
> structure, use this ioctl to read out the contents of an adjacent
> field that might not have otherwise been user-accessable.  You could
> not corrupt anything with this ioctl.

That's true for pcmcia_get_mem_page. However pcmcia_map_mem_page writes 
into the structure it verifies. I think pcmcia_get_first/next_window 
could also be used to corrupt memory (*handle = win in 
pcmcia_get_window).

> The kernel pointer could be done away with, by instead using an
> integer to represent the position in a linked list of the target data
> structure, which would be the best fix, if someone wants to code it.

That does sound like a better idea. :)

-- 
Hollis Blanchard
IBM Linux Technology Center


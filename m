Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbUBZQ0T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbUBZQ0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:26:15 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:49811 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S262812AbUBZQZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:25:27 -0500
Message-ID: <403E1DF1.9060901@raytheon.com>
Date: Thu, 26 Feb 2004 08:25:21 -0800
From: Ross Tyler <retyler@raytheon.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: how does one disable processor cache on memory allocated with
 get_free_pages?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Thank you for taking the time to reply. I really appreciate your help.

My understanding of ioremap_nocache is that it falls short of what I 
need to do.
It is appropriate for, say, mapping physical memory on a PCI device that 
is marked prefetchable (and otherwise subject to caching when mapped 
with ioremap) as non-caching.
Can you confirm my understanding?

If so, it will not work for me as I am not mapping physical memory but 
memory allocated by get_free_pages.
Do you concur?

AFAIK, the only way to access this memory without using processor cache 
is to have a device driver memory map it for a process like 
drivers/char/mem.c does.
When the memory is accessed through these memory mapped pages, the 
access will not be cached.
When the memory is accessed through the get_free_pages pages, the access 
will be cached.
Concur?

In order to access this process mapped memory from outside the context 
of the process it was mapped for, one either needs to independently 
remap it for the current process (what to do in interrupt code?) or set 
up a kiobuf to the memory.
It has been my experience, however, that the pages referenced by the 
kiobuf are the same pages returned by get_free_pages.
I expect these same pages have the same (caching) attributes associated 
with them which would not work.
?

Again, I thank you for your support.

Andrew Morton wrote:

>Ross Tyler <retyler@raytheon.com> wrote:
>  
>
>>If so, what is the mechanism for modifying the entries and synchronizing 
>>the configuration with the processor cache?
>>    
>>
>
>The only thing we have is ioremap_nocache()
>  
>



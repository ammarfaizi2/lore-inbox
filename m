Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262142AbSJJS7r>; Thu, 10 Oct 2002 14:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262144AbSJJS7r>; Thu, 10 Oct 2002 14:59:47 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:5586 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262142AbSJJS7q>;
	Thu, 10 Oct 2002 14:59:46 -0400
Message-ID: <3DA5CE88.7020400@us.ibm.com>
Date: Thu, 10 Oct 2002 12:01:28 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@fenrus.demon.nl>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
References: <3DA4D3E4.6080401@us.ibm.com> <1034244381.3629.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>+/**
>>+ * sys_mem_setbinding - set the memory binding of a process
>>+ * @pid: pid of the process
>>+ * @memblks: new bitmask of memory blocks
>>+ * @behavior: new behavior
>>+ */
>>+asmlinkage long sys_mem_setbinding(pid_t pid, unsigned long memblks, 
>>+				    unsigned int behavior)
>>+{
> 
> Do you really think exposing low level internals as memory layout / zone
> split up to userspace is a good idea ? (and worth it given that the VM
> already has a cpu locality preference?)
Yes, I actually do.  If userspace processes/users don't care about the 
memory/zone layout, they don't have to look.  But if they *do* care, 
they should be able to find out, and not be left in the proverbial dark. 
  Embedded systems will care, as will really large NUMA/Discontig 
systems.  As with some other patches, this functionality will not affect 
the average user on the average computer...  They are useful for really 
small systems, and really large systems, however.

> I'd much rather see the VM have an arch-specified "cost" for getting
> memory from not-the-prefered zones than exposing all this stuff to
> userspace and depending on userspace to do the right thing.... it's the
> kernel's task to abstract the low level details of the hardware after
> all.
The arch-specified 'cost' is also a good idea.  Some of the topology 
stuff I'm working on will allow that sort of interface as well.  And 
this patch does not 'depend' on userspace to do the right thing.  The 
patch does not alter the default VM behavior unless userspace 
*specifically* asks to alter it.

Cheers!

-Matt


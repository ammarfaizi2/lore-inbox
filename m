Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWIFJlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWIFJlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 05:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWIFJlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 05:41:13 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:54119 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750744AbWIFJlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 05:41:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XB9fJi+GJzwNVZQuJsQ0gZmZlTRywTBUS8cKdgfmwDILgs0wmNa3sxCPwkHR+lk7T/fwV+Q2t9iC1tb6sVxftAUtJZmuIk/iEwa8O45cLCEZt7HgBFxI8ql540Kpo27USGrA8HWzSTew5b83dD1brmRRYaIJkp1snqp7Sw27fIk=  ;
Message-ID: <44FE97B1.7050206@yahoo.com.au>
Date: Wed, 06 Sep 2006 19:41:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Emelianov <xemul@openvz.org>
CC: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 9/13] BC: locked pages (charge hooks)
References: <44FD918A.7050501@sw.ru> <44FD97D1.4070206@sw.ru> <44FE43E7.1030003@yahoo.com.au> <44FE8A8D.9090801@openvz.org>
In-Reply-To: <44FE8A8D.9090801@openvz.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelianov wrote:

>Nick Piggin wrote:
>
>>Kirill Korotaev wrote:
>>
>>
>>>Introduce calls to BC core over the kernel to charge locked memory.
>>>
>>>Normaly new locked piece of memory may appear in insert_vm_struct,
>>>but there are places (do_mmap_pgoff, dup_mmap etc) when new vma
>>>is not inserted by insert_vm_struct(), but either link_vma-ed or
>>>merged with some other - these places call BC code explicitly.
>>>
>>>Plus sys_mlock[all] itself has to be patched to charge/uncharge
>>>needed amount of pages.
>>>
>>
>>I still haven't heard your good reasons why such a complex scheme is
>>required when my really simple proposal of unconditionally charging
>>the page to the container it was allocated by.
>>
>Charging the page to the container it was allocated in is a possible and
>correct way, we agree, but how does this comment refer to locked pages
>

If it is a possible and correct way, I'd must rather see *that* way
get tried first, and then made more complex or discarded if it is
found to be insufficient.

>accounting?
>

That's where I'd looked at enough mm/ stuff to decide that it wasn't
just my usual unjustified whining. Complexity of this approach is
quite... high.

Sorry if that wasn't clear.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 

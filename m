Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVEaUoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVEaUoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVEaUoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:44:21 -0400
Received: from quark.didntduck.org ([69.55.226.66]:65514 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261461AbVEaUnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:43:55 -0400
Message-ID: <429CCCC1.8020106@didntduck.org>
Date: Tue, 31 May 2005 16:44:49 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timur Tabi <timur.tabi@ammasso.com>
CC: Gerd Knorr <kraxel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Will __pa(vmalloc()) ever work?
References: <4297746C.10900@ammasso.com> <873bs5yrxj.fsf@bytesex.org> <429C87FF.5070003@ammasso.com> <20050531161345.GB24106@bytesex> <429CB429.8090008@ammasso.com>
In-Reply-To: <429CB429.8090008@ammasso.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:
> Gerd Knorr wrote:
> 
>> Can you fix that?  If so, try that.  Would be the best.
> 
> 
> No, I cannot.  The memory is passed to my driver from some other driver 
> that I do not
> control.

What kind of driver are you writing, and what other driver is giving you 
this address?

>> I think you can't.  What is "anywhere else"?  Does that include
>> userspace addresses?
> 
> No, but it might include the stack.
> 
>> Not sure how portable that is, but comparing the vaddr against
>> the vmalloc address space could work.  There are macros for
>> that, VMALLOC_START & VMALLOC_END IIRC.
> 
> 
> Thanks, I'll try that.
> 
> I still haven't gotten an answer to my question about whether 
> pgd/pud/pmd/pte_offset will obtain the physical address for a kmalloc'd 
> buffer.

Walking the page tables isn't guaranteed to work for all addresses on 
all arches.  On some you have to deal with large pages, on others you 
have parts of the address space that are mapped by different mechanisms. 
  This isn't something that drivers should be getting involved in.

--
				Brian Gerst

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbVKBAgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbVKBAgD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbVKBAgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:36:01 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:24766 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751484AbVKBAgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:36:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wR43B0Y4XgJHs3zlFzxe4DooK6iFodGwKbnDcC3hW1clw2GQOGRNTBWg31S9YESPrQx5w92onJY2wyafV4qP8OdKUfEWysVLpr2/snOIxZks9zLeNuKoMnP65aDIZxFtM181/DRBl0W6Z/sPJgs+cEji0/mKVWHnCda4kVKI64g=  ;
Message-ID: <4368097A.1080601@yahoo.com.au>
Date: Wed, 02 Nov 2005 11:34:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
References: <4367C25B.7010300@vc.cvut.cz>
In-Reply-To: <4367C25B.7010300@vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> Hello Nick,
>   what's the reason behind disallowing get_user_pages() on VM_RESERVED 
> regions?  vmmon uses VM_RESERVED on its 'vma' as otherwise some kernels 
> used by SUSE complained loudly about mismatch between PageReserved() and 
> VM_RESERVED flags.
> 

Hi Petr,

The reason is that VM_RESERVED indicates that the core vm is not allowed
to touch any 'struct page' through this mapping, which get_user_pages
would do.

>   I'll remove it from vmmon for >= 2.6.14 kernels as that bogus test 
> never made to Linux kernel, but I cannot find any reason why 
> get_user_pages() should not work on VM_RESERVED (or VM_IO for that 
> matter) user pages.  Can you show me reasoning behind that decision ?

The reasoning behind the decision was so VM_RESERVED is usable for a
complete replacement to PageReserved. For example mappings through
/dev/mem should not touch the page count.

You may be able to go a step further and clear PageReserved from your
pages as well, and thus have a working driver without special casing
for both kernels.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

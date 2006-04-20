Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWDTTdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWDTTdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWDTTds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:33:48 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:52319 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751114AbWDTTdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:33:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ib2UH39MG9bVqt5d5O+ny9Yr5qNf3i+VVUUMflo2Lz36JHoPM8gu1nnJCA/xy/eT2wd1JQK8hpdBCfpZtiHMC7vV1v8Vl4OgFvsR02znoH/Zr3+j6tLo4+VzTpoRzY7jbKg1+iiysFbvfIdptY8rENzYZFzS3fnJdVso/QzYHnU=  ;
Message-ID: <44477585.4030508@yahoo.com.au>
Date: Thu, 20 Apr 2006 21:50:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: dmarkh@cfl.rr.com
CC: linux-kernel <linux-kernel@vger.kernel.org>, markh@compro.net
Subject: Re: get_user_pages ?
References: <44475DBA.7020308@cfl.rr.com>
In-Reply-To: <44475DBA.7020308@cfl.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hounschell wrote:
> For some reason (unknown to me) the VM_IO and even newer VM_PFNMAP
> vm_flags are set when I use this call causing it to fail for me. I'm
> currently using 2.6.16.9 on an x86 platform.

[...]

> I'm not the author of any of this code so please gentle with me. Nor do
> I have much of an understanding of the vm system. Any help in how this
> task should really be accomplished, taken the stated limitations of the
> pci card in mind, would be greatly appreciated. And any help as to what
> would just make it work again would also be greatly appreciated. As I
> stated above this all worked fine until the VM_PFNMAP bit was added to
> the vm->flags and subsequently checked for in the get_user_pages call.

remap_pfn_range isn't the best API for someone who needs get_user_pages.
remap_pfn_range operates on the pfn level only, so underlying addresses
may not even have a struct page.

This area is going through some changes lately. If you want something to
quickly get things working, removing VM_PFNMAP from your vma flags should
work.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

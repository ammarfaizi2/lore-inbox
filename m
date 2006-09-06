Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWIFDnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWIFDnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 23:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbWIFDnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 23:43:43 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:23983 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751695AbWIFDnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 23:43:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=JtsEq5ephcG5lGq7wxZUL1sQgwePmN0Po3fPUeheaSI7u8STJtPn2UoReKStMcbT7oKLp4/MmP/5Im/wu1IK4sGUHAlcBtQaSHIcicmBg0L6TxJCzUichOGwIdf7lV+5iUnEXa/4uZMoRQceO9h0cQXOSzeJab+TnPhX8oxfNzk=  ;
Message-ID: <44FE43E7.1030003@yahoo.com.au>
Date: Wed, 06 Sep 2006 13:43:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 9/13] BC: locked pages (charge hooks)
References: <44FD918A.7050501@sw.ru> <44FD97D1.4070206@sw.ru>
In-Reply-To: <44FD97D1.4070206@sw.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

> Introduce calls to BC core over the kernel to charge locked memory.
>
> Normaly new locked piece of memory may appear in insert_vm_struct,
> but there are places (do_mmap_pgoff, dup_mmap etc) when new vma
> is not inserted by insert_vm_struct(), but either link_vma-ed or
> merged with some other - these places call BC code explicitly.
>
> Plus sys_mlock[all] itself has to be patched to charge/uncharge
> needed amount of pages.


I still haven't heard your good reasons why such a complex scheme is
required when my really simple proposal of unconditionally charging
the page to the container it was allocated by.

That has the benefit of not being full of user explotable holes and
also not putting such a huge burden on mm/ and the wider kernel in
general.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 

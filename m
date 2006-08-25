Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWHYKGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWHYKGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWHYKGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:06:19 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:9342 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750704AbWHYKGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:06:18 -0400
Message-ID: <44EECC47.7080902@sw.ru>
Date: Fri, 25 Aug 2006 14:09:11 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 5/6] BC: kernel memory accounting (core)
References: <44EC31FB.2050002@sw.ru> <44EC36D3.9030108@sw.ru> <20060824212340.GA952@oleg>
In-Reply-To: <20060824212340.GA952@oleg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> On 08/23, Kirill Korotaev wrote:
> 
>>+int bc_slab_charge(kmem_cache_t *cachep, void *objp, gfp_t flags)
>>+{
>>+	unsigned int size;
>>+	struct beancounter *bc, **slab_bcp;
>>+
>>+	bc = get_exec_bc();
>>+	if (bc == NULL)
>>+		return 0;
> 
> 
> Is it possible to .exec_bc == NULL ?
> 
> If yes, why do we need init_bc? We can do 'set_exec_bc(NULL)' in __do_IRQ()
> instead.
no, exec_bc can't be NULL. thanks for catching old hunks which historically exist
due to old times when host system was not accounted (bc was NULL).

Thanks,
Kirill

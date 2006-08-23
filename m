Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWHWNYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWHWNYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWHWNYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:24:39 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:7084 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932083AbWHWNYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:24:38 -0400
Message-ID: <44EC57BD.4020807@sw.ru>
Date: Wed, 23 Aug 2006 17:27:25 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Greg KH <greg@kroah.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 2/6] BC: beancounters core (API)
References: <44EC31FB.2050002@sw.ru> <44EC35EB.1030000@sw.ru> <200608231337.48941.ak@suse.de>
In-Reply-To: <200608231337.48941.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 23 August 2006 13:03, Kirill Korotaev wrote:
> 
> 
>>+#ifdef CONFIG_BEANCOUNTERS
>>+extern struct hlist_head bc_hash[];
>>+extern spinlock_t bc_hash_lock;
> 
> 
> I wonder who pokes into that hash from other files? Looks a bit dangerous.
it was kernel/ub/proc.c with proc interface :)
however, we removed it from this patchset version, but forgot extern's...

will remove

>>+void __put_beancounter(struct beancounter *bc);
>>+static inline void put_beancounter(struct beancounter *bc)
>>+{
>>+	__put_beancounter(bc);
>>+}
> 
> 
> The wrapper seems pointless too.
yep, almost the same reason :)

> The file could use a overview comment what the various counter
> types actually are.
you mean comment about what resource parameters we introduce?
ok, will add it with each resource patch.

>>+	bc_print_id(bc, uid, sizeof(uid));
>>+	printk(KERN_WARNING "BC %s %s warning: %s "
> 
> 
> Doesn't this need some rate limiting? Or can it be only triggered
> by code bugs?
only due to code bugs.

>>+	bc = &default_beancounter;
>>+	memset(bc, 0, sizeof(default_beancounter));
> 
> 
> You don't trust the BSS to be zero? @)
:))

Kirill

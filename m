Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWHWLiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWHWLiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHWLiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:38:13 -0400
Received: from ns2.suse.de ([195.135.220.15]:17897 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932407AbWHWLiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:38:10 -0400
From: Andi Kleen <ak@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Subject: Re: [PATCH 2/6] BC: beancounters core (API)
Date: Wed, 23 Aug 2006 13:37:48 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Greg KH <greg@kroah.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
References: <44EC31FB.2050002@sw.ru> <44EC35EB.1030000@sw.ru>
In-Reply-To: <44EC35EB.1030000@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608231337.48941.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 August 2006 13:03, Kirill Korotaev wrote:

> +#ifdef CONFIG_BEANCOUNTERS
> +extern struct hlist_head bc_hash[];
> +extern spinlock_t bc_hash_lock;

I wonder who pokes into that hash from other files? Looks a bit dangerous.

> +void __put_beancounter(struct beancounter *bc);
> +static inline void put_beancounter(struct beancounter *bc)
> +{
> +	__put_beancounter(bc);
> +}

The wrapper seems pointless too.

The file could use a overview comment what the various counter
types actually are.

> +	bc_print_id(bc, uid, sizeof(uid));
> +	printk(KERN_WARNING "BC %s %s warning: %s "

Doesn't this need some rate limiting? Or can it be only triggered
by code bugs?


> +	bc = &default_beancounter;
> +	memset(bc, 0, sizeof(default_beancounter));

You don't trust the BSS to be zero? @)
 
-Andi

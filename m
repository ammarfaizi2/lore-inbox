Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTJHNKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbTJHNKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:10:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40931 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261464AbTJHNKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:10:15 -0400
Message-ID: <3F840C9C.9050704@pobox.com>
Date: Wed, 08 Oct 2003 09:09:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tobias DiPasquale <toby@cbcg.net>
CC: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       netfilter@lists.netfilter.org, akpm@zip.com.au, davem@redhat.com,
       kuznet@ms2.inr.ac.ru, pekkas@netcore.fi, jmorris@intercode.com.au,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] kfree_skb() bug in 2.4.22
References: <1065617075.1514.29.camel@localhost>
In-Reply-To: <1065617075.1514.29.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias DiPasquale wrote:
> Hi all,
> 
> I was debugging one of my iptables/netfilter modules yesterday and I
> came across this bug in kfree_skb(). One of my functions returns a
> struct skbuff * on success and NULL on failure. When it failed, the code
> calling said function attempted to free the struct skbuff *, which at
> that point was NULL. This produced a kernel panic. I investigated the
> problem and found that, not only should I be checking for a NULL pointer
> when freeing the struct skbuff *, but the actual cause of the panic was
> because kfree_skb() and kfree_skb_fast() do not check for skb==NULL,
> either. They immediately attempt to dereference the users field of the
> struct skbuff * in order to decrement that reference counter. 


I would prefer that you fix your code instead, to not pass NULL to 
kfree_skb()...


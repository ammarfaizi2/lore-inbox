Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVC3SPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVC3SPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVC3SPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:15:36 -0500
Received: from graphe.net ([209.204.138.32]:54030 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262378AbVC3SOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:14:03 -0500
Date: Wed, 30 Mar 2005 10:13:49 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, shai@scalex86.org
Subject: Re: API changes to the slab allocator for NUMA memory allocation
In-Reply-To: <424AE7F7.3080508@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0503301013060.15596@server.graphe.net>
References: <20050315204110.6664771d.akpm@osdl.org> <42387C2E.4040106@colorfullife.com>
 <273220000.1110999247@[10.10.2.4]> <4238845E.5060304@colorfullife.com>
 <Pine.LNX.4.58.0503292126050.32140@server.graphe.net> <424A3FA0.9030403@colorfullife.com>
 <Pine.LNX.4.58.0503300748320.12816@server.graphe.net> <424AE7F7.3080508@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Manfred Spraul wrote:

> Correct, I was thinking about the NUMA case.
> You've decided to add one register load to every call of kmalloc. On
> i386, kmalloc_node() is a 24-byte function. I'd bet that adding the node
> parameter to every call of kmalloc causes a .text increase larger than
> 240 bytes. And I have not yet considered that you have increased the
> number of conditional branches in every kmalloc(32,GFP_KERNEL) call by
> 33%, i.e. from 3 to 4 conditional branch instructions.
> I'd add an explicit kmalloc_node function. Attached is a prototype
> patch. You'd have to reintroduce the flags field to
> kmem_cache_alloc_node() and update kmalloc_node.
> The patch was manually edited, I hope it applies to a recent tree ;-)
>
> What do you think?

Looks fine to me.

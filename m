Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWHKChM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWHKChM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 22:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWHKChM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 22:37:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26269 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750783AbWHKChK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 22:37:10 -0400
Message-ID: <44DBED4C.6040604@redhat.com>
Date: Thu, 10 Aug 2006 22:37:00 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Thomas Graf <tgraf@suug.ch>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060808193345.1396.16773.sendpatchset@lappy> <20060808211731.GR14627@postel.suug.ch>
In-Reply-To: <20060808211731.GR14627@postel.suug.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Graf wrote:

> skb->dev is not guaranteed to still point to the "allocating" device
> once the skb is freed again so reserve/unreserve isn't symmetric.
> You'd need skb->alloc_dev or something.

There's another consequence of this property of the network
stack.

Every network interface must be able to fall back to these
MEMALLOC allocations, because the memory critical socket
could be on another network interface.  Hence, we cannot
know which network interfaces should (not) be marked MEMALLOC.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

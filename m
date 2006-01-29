Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWA2AtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWA2AtS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 19:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWA2AtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 19:49:18 -0500
Received: from kanga.kvack.org ([66.96.29.28]:14564 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750761AbWA2AtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 19:49:18 -0500
Date: Sat, 28 Jan 2006 19:44:59 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, kiran@scalex86.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
Message-ID: <20060129004459.GA24099@kvack.org>
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <20060127224433.GB3565@localhost.localdomain> <43DAA586.5050609@cosmosbay.com> <20060127151635.3a149fe2.akpm@osdl.org> <43DABAA4.8040208@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DABAA4.8040208@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 01:28:20AM +0100, Eric Dumazet wrote:
> We might use atomic_long_t only (and no spinlocks)
> Something like this ?

Erk, complex and slow...  Try using local_t instead, which is substantially 
cheaper on the P4 as it doesn't use the lock prefix and act as a memory 
barrier.  See asm/local.h.

		-ben

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWA2A4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWA2A4V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 19:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWA2A4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 19:56:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750778AbWA2A4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 19:56:20 -0500
Date: Sat, 28 Jan 2006 16:55:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: dada1@cosmosbay.com, kiran@scalex86.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables --
 proto.sockets_allocated
Message-Id: <20060128165549.262f2b90.akpm@osdl.org>
In-Reply-To: <20060129004459.GA24099@kvack.org>
References: <20060126185649.GB3651@localhost.localdomain>
	<20060126190357.GE3651@localhost.localdomain>
	<43D9DFA1.9070802@cosmosbay.com>
	<20060127195227.GA3565@localhost.localdomain>
	<20060127121602.18bc3f25.akpm@osdl.org>
	<20060127224433.GB3565@localhost.localdomain>
	<43DAA586.5050609@cosmosbay.com>
	<20060127151635.3a149fe2.akpm@osdl.org>
	<43DABAA4.8040208@cosmosbay.com>
	<20060129004459.GA24099@kvack.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> wrote:
>
> On Sat, Jan 28, 2006 at 01:28:20AM +0100, Eric Dumazet wrote:
> > We might use atomic_long_t only (and no spinlocks)
> > Something like this ?
> 
> Erk, complex and slow...  Try using local_t instead, which is substantially 
> cheaper on the P4 as it doesn't use the lock prefix and act as a memory 
> barrier.  See asm/local.h.
> 

local_t isn't much use until we get rid of asm-generic/local.h.  Bloaty,
racy with nested interrupts.


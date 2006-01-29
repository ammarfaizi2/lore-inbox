Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWA2BYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWA2BYM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 20:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWA2BYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 20:24:12 -0500
Received: from kanga.kvack.org ([66.96.29.28]:5093 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750800AbWA2BYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 20:24:10 -0500
Date: Sat, 28 Jan 2006 20:19:44 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andrew Morton <akpm@osdl.org>
Cc: dada1@cosmosbay.com, kiran@scalex86.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
Message-ID: <20060129011944.GB24099@kvack.org>
References: <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <20060127224433.GB3565@localhost.localdomain> <43DAA586.5050609@cosmosbay.com> <20060127151635.3a149fe2.akpm@osdl.org> <43DABAA4.8040208@cosmosbay.com> <20060129004459.GA24099@kvack.org> <20060128165549.262f2b90.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128165549.262f2b90.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 04:55:49PM -0800, Andrew Morton wrote:
> local_t isn't much use until we get rid of asm-generic/local.h.  Bloaty,
> racy with nested interrupts.

The overuse of atomics is horrific in what is being proposed.  All the
major architectures except powerpc (i386, x86-64, ia64, and sparc64) 
implement local_t.  It would make far more sense to push the last few 
stragglers (which mostly seem to be uniprocessor) into writing the 
appropriate implementations.  Perhaps it's time to add a #error in 
asm-generic/local.h?

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.

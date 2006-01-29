Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWA2BpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWA2BpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 20:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWA2BpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 20:45:03 -0500
Received: from cabal.ca ([134.117.69.58]:55247 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1750805AbWA2BpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 20:45:01 -0500
Date: Sat, 28 Jan 2006 20:45:14 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, dada1@cosmosbay.com, kiran@scalex86.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org, shai@scalex86.org,
       netdev@vger.kernel.org, pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
Message-ID: <20060129014514.GA32305@tachyon.int.mcmartin.ca>
References: <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <20060127224433.GB3565@localhost.localdomain> <43DAA586.5050609@cosmosbay.com> <20060127151635.3a149fe2.akpm@osdl.org> <43DABAA4.8040208@cosmosbay.com> <20060129004459.GA24099@kvack.org> <20060128165549.262f2b90.akpm@osdl.org> <20060129011944.GB24099@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129011944.GB24099@kvack.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 08:19:44PM -0500, Benjamin LaHaise wrote:
> The overuse of atomics is horrific in what is being proposed.  All the
> major architectures except powerpc (i386, x86-64, ia64, and sparc64) 
> implement local_t.  It would make far more sense to push the last few 
> stragglers (which mostly seem to be uniprocessor) into writing the 
> appropriate implementations.  Perhaps it's time to add a #error in 
> asm-generic/local.h?
>

Surely asm-generic/local.h could now be reimplemented using atomic_long_t
to kill that aberration that is the BITS_PER_LONG != 32 case currently...? 

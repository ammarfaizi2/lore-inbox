Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751847AbWHNFFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbWHNFFE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 01:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWHNFFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 01:05:03 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:48905 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751847AbWHNFFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 01:05:01 -0400
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Phillips <phillips@google.com>, David Miller <davem@davemloft.net>,
       riel@redhat.com, tgraf@suug.ch, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Mike Christie <michaelc@cs.wisc.edu>
In-Reply-To: <20060813215853.0ed0e973.akpm@osdl.org>
References: <20060808211731.GR14627@postel.suug.ch>
	 <44DBED4C.6040604@redhat.com> <44DFA225.1020508@google.com>
	 <20060813.165540.56347790.davem@davemloft.net>
	 <44DFD262.5060106@google.com> <20060813185309.928472f9.akpm@osdl.org>
	 <1155530453.5696.98.camel@twins>  <20060813215853.0ed0e973.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 07:03:55 +0200
Message-Id: <1155531835.5696.103.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-13 at 21:58 -0700, Andrew Morton wrote:
> On Mon, 14 Aug 2006 06:40:53 +0200
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > Testcase:
> > 
> > Mount an NBD device as sole swap device and mmap > physical RAM, then
> > loop through touching pages only once.
> 
> Fix: don't try to swap over the network.  Yes, there may be some scenarios
> where people have no local storage, but it's reasonable to expect anyone
> who is using Linux as an "enterprise storage platform" to stick a local
> disk on the thing for swap.

I wish you were right, however there seems to be a large demand to go
diskless and swap over iSCSI because disks seem to be the nr. 1 failing
piece of hardware in systems these days.

> That leaves MAP_SHARED, but mm-tracking-shared-dirty-pages.patch will fix
> that, will it not?

Will makes it less likely. One can still have memory pressure, the
remaining bits of memory can still get stuck in socket queues for
blocked processes.


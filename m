Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbVJQTwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVJQTwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVJQTwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:52:37 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:29631 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750980AbVJQTwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:52:36 -0400
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
From: Alex Williamson <alex.williamson@hp.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org, linville@tuxdriver.com
In-Reply-To: <20051017192637.GC4959@localhost.localdomain>
References: <20051017093654.GA7652@localhost.localdomain>
	 <200510171153.56063.ak@suse.de>
	 <Pine.LNX.4.64.0510170819290.23590@g5.osdl.org>
	 <200510171740.57614.ak@suse.de>
	 <20051017175231.GA4959@localhost.localdomain>
	 <Pine.LNX.4.62.0510171110450.1480@schroedinger.engr.sgi.com>
	 <1129575841.9621.15.camel@lts1.fc.hp.com>
	 <20051017192637.GC4959@localhost.localdomain>
Content-Type: text/plain
Organization: LOSL
Date: Mon, 17 Oct 2005 13:52:16 -0600
Message-Id: <1129578736.9621.25.camel@lts1.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 12:26 -0700, Ravikiran G Thirumalai wrote:

> This memory only node has a node id? Then how about a patch which iterates over 
> nodes in swiotlb.c, trying to allocate DMA'ble memory from node 0 and above
> until it gets proper memory for swiotlb?
> 
> Would that be accepatble?  I can quickly make a patch for that if it is
> acceptable..

   Yes, the memory-only node is just another node.  Iterating over all
nodes sounds a little brute force, but I guess it should work.  FWIW,
here's the results of the previous one-liner on an HP Superdome (booting
w/ machvec=dig to use the swiotlb instead of hardware iotlb):

2.6.14-rc4-mm1, before patch:
Placing software IO TLB between 0x4cdc000 - 0x8cdc000

after patch:
Placing software IO TLB between 0x74104e6b200 - 0x74108e6b200

Thanks,

	Alex

-- 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWGHBZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWGHBZo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 21:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWGHBZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 21:25:43 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:14553 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751276AbWGHBZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 21:25:43 -0400
Date: Fri, 7 Jul 2006 18:25:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, Martin Bligh <mbligh@google.com>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [RFC 5/8] x86_64 without ZONE_DMA
In-Reply-To: <200607080300.16931.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0607071820570.4530@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
 <200607080220.39100.ak@suse.de> <Pine.LNX.4.64.0607071742060.4352@schroedinger.engr.sgi.com>
 <200607080300.16931.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006, Andi Kleen wrote:

> > The savings are not only from the code paths. The VM itself is cleaner and 
> > the balancing issues are not that troublesome anymore.
> 
> Doesn't help - it has to be fixed anyways for NUMA and other architectures.

Some architectures like ours can run with a single zone since they have 
DMA that works anywhere. Same thing is true for my machines are home and 
at work.
 
> Also in my experience empty zones are not a significant problem for VM
> balancing.

The problem is that the zones are not even empty! We keep 16M in some 
weird ZONE_DMA that barely anyone one uses anymore and add slabs to it 
that are only used by some confused device drivers.

Also the empty zones are still a problem since they have to be scanned 
repeatedly (potentially on each allocation). They waste cachelines and 
result in loops where we could just have straight code.

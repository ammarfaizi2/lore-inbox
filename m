Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162020AbWKOWlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162020AbWKOWlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162024AbWKOWlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:41:10 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:17893 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1162020AbWKOWlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:41:08 -0500
Date: Wed, 15 Nov 2006 14:40:36 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Jack Steiner <steiner@sgi.com>
cc: Christian Krafft <krafft@de.ibm.com>, linux-mm@kvack.org,
       Martin Bligh <mbligh@mbligh.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
In-Reply-To: <20061115215845.GB20526@sgi.com>
Message-ID: <Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com>
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost>
 <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
 <20061115215845.GB20526@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, Jack Steiner wrote:

> A lot of the core infrastructure is currently missing that is required
> to describe IO nodes as regular nodes, but in principle, I don't
> see anything wrong with nodes w/o memory.

Every processor has a local node on which it runs. The kernel places 
memory used by the processor on the local node. Even if we allow
nodes without memory: We still need to associate a "local" node to the 
processor. If that is across some NUMA interlink then it is going to be 
slower but it will work.

AFAIK It seems to be better to explicitly associate a memory node with a 
processor during bootup in arch code. 

Various kernel optimizations rely on local memory. Would we create 
a  special case here of a pglist_data structure without a zones structure? 

It seems that the contents of pglist_data are targeted to a memory node. 
If we do not have a pglist_data structure then the node would not exist 
for the kernel.

What would the benefit or difference be of having nodes without memory?

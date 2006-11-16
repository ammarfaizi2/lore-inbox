Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162230AbWKPCfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162230AbWKPCfd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162233AbWKPCfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:35:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:472 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1162230AbWKPCfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:35:32 -0500
Date: Wed, 15 Nov 2006 18:35:04 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Bligh <mbligh@mbligh.org>
cc: Jack Steiner <steiner@sgi.com>, Christian Krafft <krafft@de.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
In-Reply-To: <455BC854.9070708@mbligh.org>
Message-ID: <Pine.LNX.4.64.0611151828490.24949@schroedinger.engr.sgi.com>
References: <20061115193049.3457b44c@localhost> <20061115193437.25cdc371@localhost>
 <Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
 <20061115215845.GB20526@sgi.com> <Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com>
 <20061116013534.GB1066@sgi.com> <Pine.LNX.4.64.0611151754480.24793@schroedinger.engr.sgi.com>
 <455BC854.9070708@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006, Martin Bligh wrote:

> A node without memory is a node without memory. Simply remapping the
> cpus to another node and pretending the world is different does not
> make much sense.

It avoids overhead both in terms of memory and processing in the kernel 
and it seems that is the way we have traditionally dealt with the issue?

Nodes without memory require the VM to allocate memory from different
nodes in order to build up management structures for the node (these
are useless since the node has no memory, caches will be split etc etc).

The cpus will allways fallback to the next node anyways since 
their zonelist begins with a zone in a node that has memory.

> Is there some fundamental problem you see with dealing with the nodes
> as is? Doesn't seem that hard to me. I'm not asking you to put the
> effort in to fixing it, just if you see some fundamental reason why
> it can't be fixed?

I am not sure how memoryless nodes would affect various subsystems. And it 
seems that this patch only fixes the first issue that they found (?). If 
we go down this route then we may have to add more special casing to the 
VM in order to cleanly handle memoryless nodes.

But maybe someone else has already experience with memoryless nodes?

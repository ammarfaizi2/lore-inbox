Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbUKSWpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbUKSWpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUKSWdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:33:37 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:23687 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261669AbUKSWdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:33:14 -0500
Date: Fri, 19 Nov 2004 15:18:35 -0600
From: Jack Steiner <steiner@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: SLIT and IO-only nodes
Message-ID: <20041119211835.GA21349@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An SGI Altix SSI system consists of a collection of nodes connected via a
high speed interconnect. Nodes come in several flavors:

        - memory, IO and cpus
        - memory & cpus
        - memory only
        - IO only
        -    (other combinations don't exist yet)

The first 2 types of nodes are typical.

You can think of the last 2 types of nodes as nodes that have been
partially depopulated.

We need to describe all these nodes in the SLIT table.
For example, when allocating memory on a memory-only node,
knowing the distance to the node is important.

When assigning cpus to service interrupts for IO nodes or when creating
driver memory structures for devices on IO nodes, it is important
to use the nearest node that has cpus & memory.

On IA64, memory-only nodes are described in the SRAT, have a proximity
domain number, NIDs, and appear in the SLIT. (ie., we don't have
a problem with memory-only nodes).

However, IO-only nodes (AFAICT) cannot be described in the SLIT.
The SLIT is indexed by proximity_domain_number (PXM).
Currently, there is no SRAT entry for IO-only nodes. These nodes do not
appear in the SLIT. It would seem that a new ACPI table is
needed for IO-only nodes. The SRAT would describe the node & identify
the IO buses that are attached to the node. I think this would give us 
what we need.


Before I start digging into the ACPI spec, has anyone already addressed
this problem? Is this the right approach to take to solve the problem?


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.



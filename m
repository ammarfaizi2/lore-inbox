Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVERRkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVERRkl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVERRj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:39:28 -0400
Received: from graphe.net ([209.204.138.32]:54544 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262196AbVERRjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:39:18 -0400
Date: Wed, 18 May 2005 10:39:11 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4-mm2 build failure
In-Reply-To: <428B7A5F.9090404@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0505181035140.6359@graphe.net>
References: <734820000.1116277209@flay> <Pine.LNX.4.62.0505161602460.20110@graphe.net>
 <428A8697.4010606@us.ibm.com> <Pine.LNX.4.62.0505171707100.18365@graphe.net>
 <428B7A5F.9090404@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Matthew Dobson wrote:

> I think you explained it well yourself.  If another function needs to be
> added for ALL ARCHES, then ALL ARCHES will need to add the function.  In
> most cases there is no single function that is both CORRECT and GENERIC
> across all arches.  The way that i386, ia64, ppc64, etc. will map PCI Buses
> to Nodes (for instance) will NOT be the same.  Anyone who adds a new
> topology function has the responsibility of
> 1) making sure it works for all arches which support topology, or
> 2) getting the arch maintainers involved and helping them make sure it
> works for all arches.

The topology function in generic may just do nothing
if not defined by the arch like pcibus_to_node. If the arch does not
define it return indeterminate and make all node specific allocations fall
back to unspecific allocation. This works for all arches and preserves
the existing behavior.

> New topology functions don't really get added all that often.  We've got
> the basics (CPU, Mem, I/O Buses, Nodes) mapped in various ways, so there
> shouldn't be tons of new functions added.  If someone wants to add a new
> function, it's their responsibility to make sure that it doesn't break
> anyone's arch.

Its best to have the kernel setup in such a way that functions can be 
added without having to cause breakage.

It is imaginable that someone will add more hardware something to node
functions in the near future given that pcibus_to_node is just for pci.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992751AbWJTWyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992751AbWJTWyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992752AbWJTWyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:54:38 -0400
Received: from ozlabs.org ([203.10.76.45]:44238 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S2992751AbWJTWyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:54:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17721.21412.931764.263941@cargo.ozlabs.ibm.com>
Date: Sat, 21 Oct 2006 08:54:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Anton Blanchard <anton@samba.org>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <Pine.LNX.4.64.0610201029190.16161@schroedinger.engr.sgi.com>
References: <1161026409.31903.15.camel@farscape>
	<Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
	<1161031821.31903.28.camel@farscape>
	<Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
	<17717.50596.248553.816155@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
	<17718.39522.456361.987639@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
	<17719.1849.245776.4501@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
	<20061019163044.GB5819@krispykreme>
	<Pine.LNX.4.64.0610190947110.8310@schroedinger.engr.sgi.com>
	<17719.64246.555371.701194@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610191527040.10880@schroedinger.engr.sgi.com>
	<17720.30804.180390.197567@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0610201029190.16161@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:

> I do not get it. You first mark all pages on node 0 then we run the bootup 
> code and later we shift those pages into node 0? So the slab bootstrap is 
> running when all pages are marked as being part of node 1 then later we 
> switch those pages under it to node 0?

No, the bootmem code correctly marks all the pages in node 0 as being
in node 0.  Then it goes through and marks *all* pages as being in
node 1, because it marks all pages between the first and last pages in
the node as being in the node.  The first page in node 1 is before all
the pages in node 0, and the last page in node 1 is after all the
pages in node 0.

So we end up with the system thinking all the memory is in node 1,
although in fact half the memory is in node 0.

Anyway, it looks like this problem wasn't introduced by your patches,
and is solved by the patch Andy Whitcroft posted, so thanks for your
assistance with this.

Paul.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbUDHSQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbUDHSQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:16:18 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:12168 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262110AbUDHSQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:16:16 -0400
Date: Thu, 8 Apr 2004 19:16:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       <colpatch@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: NUMA API for Linux
In-Reply-To: <5470000.1081443942@flay>
Message-ID: <Pine.LNX.4.44.0404081905510.7487-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004, Martin J. Bligh wrote:
> > On Wed, 7 Apr 2004, Andrew Morton wrote:
> >> 
> >> Your patch takes the CONFIG_NUMA vma from 64 bytes to 68.  It would be nice
> >> to pull those 4 bytes back somehow.
> > 
> > How significant is this vma size issue?
> > 
> > anon_vma objrmap will add 20 bytes to each vma (on 32-bit arches):
> > 8 for prio_tree, 12 for anon_vma linkage in vma,
> > sometimes another 12 for the anon_vma head itself.
> 
> Ewwww. Isn't some of that shared most of the time though?

The anon_vma head may well be shared with other vmas of the fork group.
But the anon_vma linkage is a list_head and a pointer within the vma.

prio_tree is already using a union as much as it can (and a pointer
where a list_head would simplify the code); Rajesh was thinking of
reusing vm_private_data for one pointer, but I've gone and used it
for nonlinear swapout.

> > anonmm objrmap adds just the 8 bytes for prio_tree,
> > remaining overhead 28 bytes per mm.
> 
> 28 bytes per *mm* is nothing, and I still think the prio_tree is 
> completely unneccesary. Nobody has ever demonstrated a real benchmark
> that needs it, as far as I recall.

I'm sure an Ingobench will shortly follow that observation.

Hugh


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbUCCRFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 12:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbUCCRFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 12:05:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35086
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262519AbUCCRFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 12:05:44 -0500
Date: Wed, 3 Mar 2004 18:06:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, hugh@veritas.com,
       wli@holomorphy.com
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040303170624.GP4922@dualathlon.random>
References: <20040303070933.GB4922@dualathlon.random> <20040303025820.2cf6078a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303025820.2cf6078a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 02:58:20AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > --- sles-objrmap/mm/rmap.c.~1~	2004-03-03 06:45:38.995594456 +0100
> >  +++ sles-objrmap/mm/rmap.c	2004-03-03 07:01:39.200621104 +0100
> >  @@ -470,7 +470,7 @@ try_to_unmap_obj_one(struct vm_area_stru
> >   	if (!pte)
> >   		goto out;
> >   
> >  -	if (vma->vm_flags & VM_LOCKED) {
> >  +	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
> >   		ret =  SWAP_FAIL;
> >   		goto out_unmap;
> 
> I keep on wanting to put that in there too.  But pages in a VM_RESERVED vma
> should not find their way onto the LRU.  Maybe we should be checking for
> that in do_no_page().

you're right, so we can turn this into a BUG_ON, I prefer it here, since
this is really the place that VM_RESERVED is mean to guard against (plus
the vma merging).

thanks for the explanation.

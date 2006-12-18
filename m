Return-Path: <linux-kernel-owner+w=401wt.eu-S1753330AbWLRBDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbWLRBDM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 20:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbWLRBDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 20:03:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45331 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331AbWLRBDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 20:03:12 -0500
Date: Sun, 17 Dec 2006 17:02:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <20061217154026.219b294f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612171701010.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2006, Andrew Morton wrote:
> 
> So this patch instead arranges for clear_page_dirty() to not clean the pte's
> when it is called on the try_to_free_buffers() path.

No. This is wrong.

It's wrong exactly because it now _breaks_ the whole thing that the 2.6.19 
PG_dirty changes were all about: keeping track of dirty pages. Now you 
have a page that is dirty, but it's no longer marked PG_dirty, and thus it 
doesn't participate in the dirty accounting.

> From my quick reading, all callers of try_to_free_buffers() have already
> unmapped the page from pagetables, and given that the reported ext3 corruption
> happens on uniprocessor, non-preempt kernels, I doubt if this patch will fix
> things.

So not only are you breaking this, you also claim that it cannot happen in 
the first place. So either the patch is buggy, or it's pointless. In 
neither case does it seem to be a good idea to do.

		Linus

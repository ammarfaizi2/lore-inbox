Return-Path: <linux-kernel-owner+w=401wt.eu-S932669AbWLMLNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbWLMLNk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWLMLNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:13:40 -0500
Received: from ns2.suse.de ([195.135.220.15]:51637 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932669AbWLMLNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:13:39 -0500
From: Neil Brown <neilb@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Date: Wed, 13 Dec 2006 22:13:55 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17791.57459.23780.747689@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 14] knfsd: Assorted nfsd patches for 2.6.20 - prepare
 for IPv6 and more
In-Reply-To: message from Jeff Garzik on Wednesday December 13
References: <20061213105528.21128.patches@notabene>
	<457F9243.9090701@garzik.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday December 13, jeff@garzik.org wrote:
> NeilBrown wrote:
> > Following are 14 patches for knfsd that are suitable for inclusion in 2.6.20.
> > First 13 are from Chuck Lever and make preparations for IPv6 support (I think we've
> > get them right this time).
> > 
> > Last is from Peter Staubach and fixes and issue with exclusive create
> > interacting badly with some ACLs.
> 
> 
> Any word on this 2.6.19 oops?
> 
> http://lkml.org/lkml/2006/12/8/110

Not yet... I've been spending my spare time looking for an md oops :-)

A quick look suggests that it cannot possibly happen ...

cancel_rearming_delayed_workqueue appears to be being called with a
bad "struct workqueue_struct *".  But that really must have been
initialised when the first nfsd thread started...

It looks like cwq in flush_cpu_workqueue is 0x0000040000000100.  Is
that the sort of address you would expect?  Where do alloc_percpu 
data structures live?  The '4' wouldn't be a single-bit memory error,
would it? (that would be too easy).

So: no, no real progress.   Is it repeatable?

NeilBrown

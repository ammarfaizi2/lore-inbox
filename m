Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945908AbWJaUjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945908AbWJaUjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945969AbWJaUjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:39:44 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:52624 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1945908AbWJaUjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:39:43 -0500
Date: Tue, 31 Oct 2006 12:39:22 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Andreas Gruenbacher <agruen@suse.de>
cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>, nfs@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] NFS: nfsaclsvc_encode_getaclres() - Fix potential NULL
 deref and tiny optimization.
In-Reply-To: <200610311726.00411.agruen@suse.de>
Message-ID: <Pine.LNX.4.64N.0610311232190.30578@attu4.cs.washington.edu>
References: <200610272316.47089.jesper.juhl@gmail.com>
 <Pine.LNX.4.64N.0610271443500.31179@attu2.cs.washington.edu>
 <200610280001.49272.jesper.juhl@gmail.com> <200610311726.00411.agruen@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006, Andreas Gruenbacher wrote:

> > > w should be an unsigned int.
> >
> > Makes sense.
> 
> No, this breaks the while loop further below: with an unsigned int, the loop 
> counter underflows and wraps.
> 

This is not a problem with w being an unsigned int, it's a problem with 
the while loop.  nfsacl_size() returns unsigned int as it should and the 
while loop can be written to respect that since integer division in C 
truncates:

	for (n = w / PAGE_SIZE; n > 0; n--)
		if (!rqstp->rq_respages[rqstp->rq_resused++];

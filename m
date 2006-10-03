Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWJCB7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWJCB7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 21:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWJCB7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 21:59:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56266 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030242AbWJCB7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 21:59:40 -0400
Date: Tue, 3 Oct 2006 11:59:20 +1000
From: Greg Banks <gnb@sgi.com>
To: Neil Brown <neilb@suse.de>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 008 of 11] knfsd: Prepare knfsd for support of rsize/wsize of up to 1MB, over TCP.
Message-ID: <20061003015920.GJ28796@sgi.com>
References: <20060824162917.3600.patches@notabene> <1060824063711.5008@suse.de> <20060925154316.GA17465@fieldses.org> <17697.48800.933642.581926@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17697.48800.933642.581926@cse.unsw.edu.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 11:36:32AM +1000, Neil Brown wrote:
> On Monday September 25, bfields@fieldses.org wrote:
> > 
> > We're reporting svc_max_payload(rqstp) as the server's maximum
> > read/write block size:
> 
> Yes.  So I'm going to change the number returned by
> svc_max_payload(rqstp) to mean the maximum read/write block size.
> i.e. when a service is created, the number passed isn't the maximum
> packet size, but is the maximum payload size.

I'm confused.  Last time I looked at the code that was
exactly what the semantics were?

> The assumption is that all of the request that is not payload will fit
> into one page, and all of the reply that is not payload will also fit
> into one page (though a different page).

This is a pretty good assumption for v3.

> It means that RPC services that have lots of non-payload data combined
> with payload data won't work, but making sunrpc code completely
> general when there are only two users is just too painful.
> 
> The only real problem is that NFSv4 can have arbitrarily large
> non-payload data, and arbitrarily many payloads.  But I guess any
> client that trying to send two full-sized payloads in the one request
> is asking for trouble (I don't suppose the RPC spells this out at
> all?).

Bruce and I briefly discussed this when I dropped into CITI the other
week.  The conclusion was that this is a non-issue in the short term
because all the clients do a single READ or WRITE per call.  In the
long term I hope to rewrite some parts of that code to do away with
one of the memcpy()s in the WRITE path, and handling multiple WRITEs
for v4 would be a natural extension of that.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1753194AbWLRFna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbWLRFna (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 00:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753196AbWLRFna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 00:43:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33939 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbWLRFna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 00:43:30 -0500
Date: Sun, 17 Dec 2006 21:43:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061217214308.62b9021a.akpm@osdl.org>
In-Reply-To: <45861E68.3060403@yahoo.com.au>
References: <1166314399.7018.6.camel@localhost>
	<20061217040620.91dac272.akpm@osdl.org>
	<1166362772.8593.2.camel@localhost>
	<20061217154026.219b294f.akpm@osdl.org>
	<Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612171744360.3479@woody.osdl.org>
	<45861E68.3060403@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 15:51:52 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> I think the problem Andrew identified is real.

I don't.  In fact I don't think I described any problem (well, I tried to,
but then I contradicted myself).

Six hours here of fsx-linux plus high memory pressure on SMP on 1k
blocksize ext3, mainline.  Zero failures.  It's unlikely that this testing
would pass, yet people running normal workloads are able to easily trigger
failures.  I suspect we're looking in the wrong place.

> The issue is the disconnect between the pte dirtiness and a filesystem
> bringing buffers clean.

Really?  The dirtying direction goes pte_dirty->PG_dirty->BH_Dirty and the
cleaning direction goes !BH_Dirty->!PG_dirty->!pte_dirty.  That's pretty
simple, setting aside races.

In the try_to_free_buffers case there's a large time inverval between
!BH_Dirty and !PG_dirty, but that shouldn't affect anything.

I don't think we even have a theory as to what's gone wrong yet.


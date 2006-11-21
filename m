Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756866AbWKUXvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866AbWKUXvo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 18:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756867AbWKUXvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 18:51:43 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:43410 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1756866AbWKUXvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 18:51:43 -0500
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
	 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
	 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 15:51:36 -0800
Message-Id: <1164153096.9131.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-21 at 23:43 +0000, Mel Gorman wrote:
> On Tue, 21 Nov 2006, Christoph Lameter wrote:
> > Are GFP_HIGHUSER allocations always movable? It would reduce the size of
> > the patch if this would be added to GFP_HIGHUSER.
> 
> No, they aren't. Page tables allocated with HIGHPTE are currently not 
> movable for example. A number of drivers (infiniband for example) also use 
> __GFP_HIGHMEM that are not movable.

I think Christoph was saying that it might reduce the size of the patch
to include it by _default_.  You could always go to the
weird^Wspecialized users and mask the bits back off.

We probably also need to start getting a nice list of those users which
are HIGH but not MOVABLE.  This would provide that by default, I think.

-- Dave


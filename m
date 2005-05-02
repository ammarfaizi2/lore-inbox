Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVEBVBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVEBVBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 17:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVEBVBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 17:01:00 -0400
Received: from gate.in-addr.de ([212.8.193.158]:19147 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261773AbVEBVAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 17:00:30 -0400
Date: Mon, 2 May 2005 22:51:35 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@istop.com>
Cc: Daniel McNeil <daniel@osdl.org>, David Teigland <teigland@redhat.com>,
       Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Patrick Caulfield <pcaulfie@redhat.com>
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050502205135.GC4722@marowsky-bree.de>
References: <20050425165826.GB11938@redhat.com> <200504300509.24887.phillips@istop.com> <20050430103221.GQ21645@marowsky-bree.de> <200504300712.46835.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200504300712.46835.phillips@istop.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-30T07:12:46, Daniel Phillips <phillips@istop.com> wrote:

> process.  And obviously, there already is some reliable starting point or 
> cman would not work.  So let's just expose that and have a better cluster 
> stack.

Most memberships internally construct such a fixed starting point from
voting or other 'chatty' techniques.

This is exposed by the membership (providing all nodes in the same order
on all nodes), however the node level membership does not necessarily
reflect the service/application level membership. So to get it right,
you essentially have to run such an algorithm at that level again too.

True enough it would be helpful if the group membership service provided
such, but here we're at the node level.

> But note that it _can_ use the oldest cluster member as a recovery
> master, or to designate a recovery master.  It can, and should - there
> is no excuse for making this any more complex than it needs to be.

The oldest node might not be running that particular service, or it
might not be healthy. To figure that out, you need to vote.

This is straying a bit from LKML issues, maybe it ought to be moved to
one of the clustering lists.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"


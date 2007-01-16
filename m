Return-Path: <linux-kernel-owner+w=401wt.eu-S1751682AbXAPWCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbXAPWCz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 17:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbXAPWCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 17:02:55 -0500
Received: from ns2.suse.de ([195.135.220.15]:33372 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbXAPWCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 17:02:54 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 0/8] Cpuset aware writeback
Date: Wed, 17 Jan 2007 09:01:58 +1100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701170901.58757.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Secondly we modify the dirty limit calculation to be based
> on the acctive cpuset.

The global dirty limit definitely seems to be a problem
in several cases, but my feeling is that the cpuset is the wrong unit
to keep track of it. Most likely it should be more fine grained.

> If we are in a cpuset then we select only inodes for writeback
> that have pages on the nodes of the cpuset.

Is there any indication this change helps on smaller systems
or is it purely a large system optimization?

> B. We add a new counter NR_UNRECLAIMABLE that is subtracted
>    from the available pages in a node. This allows us to
>    accurately calculate the dirty ratio even if large portions
>    of the node have been allocated for huge pages or for
>    slab pages.

That sounds like a useful change by itself.

-Andi

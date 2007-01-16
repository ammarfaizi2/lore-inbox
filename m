Return-Path: <linux-kernel-owner+w=401wt.eu-S1751638AbXAPUv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbXAPUv3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbXAPUv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:51:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50120 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751630AbXAPUv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:51:28 -0500
Date: Tue, 16 Jan 2007 12:51:14 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Menage <menage@google.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [RFC 8/8] Reduce inode memory usage for systems with a high
 MAX_NUMNODES
In-Reply-To: <6599ad830701161206w7dff0fa8y34f1e74f94ab9051@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701161249400.3074@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
  <20070116054825.15358.65020.sendpatchset@schroedinger.engr.sgi.com> 
 <6599ad830701161152q75ff29cdo7306c9b8df5c351b@mail.gmail.com> 
 <Pine.LNX.4.64.0701161152450.2780@schroedinger.engr.sgi.com>
 <6599ad830701161206w7dff0fa8y34f1e74f94ab9051@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Paul Menage wrote:

> I was thinking runtime, unless MAX_NUMNODES is less than 64 in which
> case you can make the decision at compile time.
> 
> > 
> > If done at compile time then we will end up with a pointer to an unsigned
> > long for a system with <= 64 nodes. If we allocate the nodemask via
> > kmalloc then we will always end up with a mininum allocation size of 64
> > bytes.
> 
> Can't we get less overhead with a slab cache with appropriate-sized objects?

Ok but then we are going to have quite small objects. Plus we will have 
additional slab overhead per node.

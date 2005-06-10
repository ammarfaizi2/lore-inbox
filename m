Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbVFJQUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVFJQUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVFJQUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:20:14 -0400
Received: from graphe.net ([209.204.138.32]:48050 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262597AbVFJQUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:20:10 -0400
Date: Fri, 10 Jun 2005 09:20:00 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Mel Gorman <mel@csn.ul.ie>, Nick Piggin <nickpiggin@yahoo.com.au>,
       jschopp@austin.ibm.com, linux-mm@kvack.org,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
In-Reply-To: <537960000.1118251081@[10.10.2.4]>
Message-ID: <Pine.LNX.4.62.0506100918460.10707@graphe.net>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie>
 <429E20B6.2000907@austin.ibm.com><429E4023.2010308@yahoo.com.au>
 <423970000.1117668514@flay><429E483D.8010106@yahoo.com.au>
 <434510000.1117670555@flay><429E50B8.1060405@yahoo.com.au>
 <429F2B26.9070509@austin.ibm.com><1117770488.5084.25.camel@npiggin-nld.site><Pine.LNX.4.58.0506031349280.10779@skynet>
 <370550000.1117807258@[10.10.2.4]> <Pine.LNX.4.58.0506081734480.10706@skynet>
 <537960000.1118251081@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2005, Martin J. Bligh wrote:

> Right. I agree that large allocs should be reliable. Whether we care so
> much about if they're performant or not, I don't know ... is an interesting
> question. I think the answer is maybe not, within reason. The cost of
> fishing in the allocator might well be irrelevant compared to the cost
> of freeing the necessary memory area?

Large consecutive page allocation is important for I/O. Lots of drivers 
are able to issue transfer requests spanning multiple pages which is only 
possible if the pages are in sequence. If memory is fragmented then this 
is no longer possible.

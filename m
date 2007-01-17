Return-Path: <linux-kernel-owner+w=401wt.eu-S1751703AbXAQEXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbXAQEXU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 23:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbXAQEXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 23:23:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40420 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751703AbXAQEXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 23:23:20 -0500
Date: Tue, 16 Jan 2007 20:23:04 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [RFC 5/8] Make writeout during reclaim cpuset aware
In-Reply-To: <200701170907.14670.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0701162021320.4849@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
 <20070116054809.15358.22246.sendpatchset@schroedinger.engr.sgi.com>
 <200701170907.14670.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2007, Andi Kleen wrote:

> On Tuesday 16 January 2007 16:48, Christoph Lameter wrote:
> > Direct reclaim: cpuset aware writeout
> >
> > During direct reclaim we traverse down a zonelist and are carefully
> > checking each zone if its a member of the active cpuset. But then we call
> > pdflush without enforcing the same restrictions. In a larger system this
> > may have the effect of a massive amount of pages being dirtied and then
> > either
> 
> Is there a reason this can't be just done by node, ignoring the cpusets? 

We want to writeout dirty pages that help our situation. Those are located 
on the nodes of the cpuset.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752464AbWCQAuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbWCQAuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbWCQAuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:50:16 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:5564 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1752464AbWCQAuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:50:15 -0500
Date: Thu, 16 Mar 2006 16:50:08 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Race in pagevec_strip?
In-Reply-To: <Pine.LNX.4.61.0603162000380.25033@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0603161644510.4748@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603161033120.2395@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603161056270.2518@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0603161934220.24837@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0603162000380.25033@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Hugh Dickins wrote:

> On Thu, 16 Mar 2006, Hugh Dickins wrote:
> > 
> > I can't see what protects the default drop_buffers case against this,
> > so can't argue that it's an XFS problem.
> 
> But I should add, I don't see what might be racing with what on the
> same page, to cause the problem in practice.

The page is on the inactive list at the time pagevec_strip is called 
(see refill_inactive_zone). So kswapd could get to it. Could filesystems 
get to the page via the mapping?


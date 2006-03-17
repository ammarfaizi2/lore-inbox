Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWCQSF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWCQSF1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWCQSF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:05:27 -0500
Received: from silver.veritas.com ([143.127.12.111]:3336 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030242AbWCQSF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:05:27 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.03,105,1141632000"; 
   d="scan'208"; a="36035570:sNHT24608768"
Date: Fri, 17 Mar 2006 18:05:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christoph Lameter <clameter@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Race in pagevec_strip?
In-Reply-To: <Pine.LNX.4.64.0603161644510.4748@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0603171757270.643@goblin.wat.veritas.com>
References: <Pine.LNX.4.64.0603161033120.2395@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603161056270.2518@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0603161934220.24837@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0603162000380.25033@goblin.wat.veritas.com>
 <Pine.LNX.4.64.0603161644510.4748@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Mar 2006 18:05:26.0603 (UTC) FILETIME=[5E5F79B0:01C649ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Christoph Lameter wrote:
> On Thu, 16 Mar 2006, Hugh Dickins wrote:
> > 
> > But I should add, I don't see what might be racing with what on the
> > same page, to cause the problem in practice.
> 
> The page is on the inactive list at the time pagevec_strip is called 
> (see refill_inactive_zone). So kswapd could get to it. Could filesystems 
> get to the page via the mapping?

A filesystem could get there, but I doubt it'd want to be releasing
buffers.  But now I see truncation's invalidate_complete_page,
that looks quite capable of racing with the kswapd instance.

Anyway, I don't disagree with your patch, and happy to see it now
in Linus' tree: was just wanting to make clear that I hadn't actually
seen the race in question, and didn't know if you were fixing a
potentiality or something actually seen.

Hugh

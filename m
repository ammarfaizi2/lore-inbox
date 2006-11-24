Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965904AbWKXSMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965904AbWKXSMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 13:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965906AbWKXSMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 13:12:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965904AbWKXSMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 13:12:17 -0500
Date: Fri, 24 Nov 2006 10:11:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Mel Gorman <mel@skynet.ie>, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <Pine.LNX.4.64.0611240955170.24649@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0611241009100.6991@woody.osdl.org>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org> <20061123163613.GA25818@skynet.ie>
 <Pine.LNX.4.64.0611230906110.27596@woody.osdl.org>
 <Pine.LNX.4.64.0611240955170.24649@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Nov 2006, Christoph Lameter wrote:
> 
> So please do not require movable pages to be user allocations.

I don't think you read the whole sentence I wrote.

Go back: USER just means "it it can fail much more eagerly". It really has 
nothing to do with user-mode per se. It's just not so core that the kernel 
cannot handle allocation failures, so it doesn't get to retry the 
allocation so eagerly.

THAT is why "movable" is almost guaranteed to also imply USER. Not because 
it's not a "kernel" allocation. After all, _all_ page allocations are 
kernel allocations, it's just that some are more likely to be associated 
with direct user requests, and some are more internal.

		Linus

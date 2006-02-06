Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWBFWLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWBFWLp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWBFWLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:11:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:32153 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932216AbWBFWLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:11:43 -0500
Date: Mon, 6 Feb 2006 14:11:40 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: ak@suse.de, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: OOM behavior in constrained memory situations
In-Reply-To: <20060206131026.53dbd8d5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0602061410160.18919@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
 <20060206131026.53dbd8d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Andrew Morton wrote:

> Do we really want to kill the application?  A more convetional response
> would be to return NULL from the page allocator and let that trickle back.

Ok. But ultimately that will lead to a application fault or the 
termination of the application .
 
> The hugepage thing is special, because it's a pagefault, not a syscall.

The same can happen if a pagefault occurs in the application but the page 
allocator cannot satisfy the allocation. At that point we need to 
determine if the allocation was restricted. If so then we are not really 
in an OOM situation and the app could be terminated.
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVKWTaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVKWTaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVKWTaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:30:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36024 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932233AbVKWTaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:30:18 -0500
Date: Wed, 23 Nov 2005 11:30:10 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Rohit Seth <rohit.seth@intel.com>
cc: akpm@osdl.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
 conditions
In-Reply-To: <20051122161000.A22430@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0511231128090.22710@schroedinger.engr.sgi.com>
References: <20051122161000.A22430@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Rohit Seth wrote:

> [PATCH]: This patch free pages (pcp->batch from each list at a time) from
> local pcp lists when a higher order allocation request is not able to 
> get serviced from global free_list.

Ummm.. One controversial idea: How about removing the complete pcp 
subsystem? Last time we disabled pcps we saw that the effect 
that it had was within noise ratio on AIM7. The lru lock taken without 
pcp is in the local zone and thus rarely contended.

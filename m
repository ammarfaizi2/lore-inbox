Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWAIUxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWAIUxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWAIUxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:53:08 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:2260 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751329AbWAIUxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:53:06 -0500
Date: Mon, 9 Jan 2006 12:52:45 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] use local_t for page statistics
In-Reply-To: <20060109182622.GC16451@kvack.org>
Message-ID: <Pine.LNX.4.62.0601091249140.4061@schroedinger.engr.sgi.com>
References: <20060106215332.GH8979@kvack.org> <20060106163313.38c08e37.akpm@osdl.org>
 <20060109182622.GC16451@kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Benjamin LaHaise wrote:

> On Fri, Jan 06, 2006 at 04:33:13PM -0800, Andrew Morton wrote:
> > Bah.  I think this is a better approach than the just-merged
> > mm-page_state-opt.patch, so I should revert that patch first?
> 
> After going over things, I think that I'll redo my patch on top of that 
> one, as it means that architectures that can optimize away the save/restore 
> of irq flags will be able to benefit from that.  Maybe after all this is 
> said and done we can clean things up sufficiently to be able to inline the 
> inc/dec where it is simple enough to do so.

Could you also have a look at my zone counters and event counter 
patchsets? This will split up the page statistics into important 
counters that we use (which are then per zone) and the ones that are
only displayed via proc). It would really help to implement numa 
awareness in the VM if we could have per zone vm counters. The zone 
reclaim patchset would already benefit from it.

Zoned counters:

http://marc.theaimsgroup.com/?l=linux-kernel&m=113511649910826&w=2

Fast event counters:

http://marc.theaimsgroup.com/?l=linux-mm&m=113512324804851&w=2

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWFFSVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWFFSVQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWFFSVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:21:16 -0400
Received: from silver.veritas.com ([143.127.12.111]:35694 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750789AbWFFSVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:21:16 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,214,1146466800"; 
   d="scan'208"; a="38885801:sNHT25826028"
Date: Tue, 6 Jun 2006 19:21:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Christoph Lameter <clameter@sgi.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       mbligh@google.com, apw@shadowen.org, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <Pine.LNX.4.64.0606061039570.27969@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0606061915370.31871@blonde.wat.veritas.com>
References: <447DEF49.9070401@google.com>  <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org>  <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org>  <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org>  <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
  <44848DD2.7010506@shadowen.org>  <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
  <44848F45.1070205@shadowen.org> <44849075.5070802@google.com> 
 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com> 
 <20060605135812.30138205.akpm@osdl.org>  <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com>
  <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com>
 <1149614184.29059.47.camel@localhost> <Pine.LNX.4.64.0606061039570.27969@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Jun 2006 18:21:15.0718 (UTC) FILETIME=[FF8CAE60:01C68995]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006, Christoph Lameter wrote:
> 
> It evaluates to 31 it seems for all platforms. Could we replace this 
> expression with MAX_SWAPFILES? While we at it get rid of the "type" 
> variable because we are usually using pointers to swap_info.

Well, if you want to go through all of swapfile.c, changing it over
to use pointers rather than type/indexes.  But I don't think it's
worth it, and I don't think it should be mixed in with this fix.

> Note that there is  still another similar check in there for an arch 
> specific test of the number of pages available per swap device.

And that check, also Martin's I believe, has very good justification:
it will vary from arch to arch how big a swap area they can handle, and
his check is the right way to do it - no more obscure than it has to be.

Hugh

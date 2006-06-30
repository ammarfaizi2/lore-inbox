Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWF3RPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWF3RPZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 13:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWF3RPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 13:15:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:62631 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932253AbWF3RPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 13:15:24 -0400
Date: Fri, 30 Jun 2006 10:15:19 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ZVC: Increase threshold for larger processor configurationss
In-Reply-To: <20060629115705.ede2c63c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606301010200.2955@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606281038530.22262@schroedinger.engr.sgi.com>
 <20060628154911.6e035153.akpm@osdl.org> <Pine.LNX.4.64.0606291116500.27926@schroedinger.engr.sgi.com>
 <20060629115705.ede2c63c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006, Andrew Morton wrote:

> A lot of the counters only ever count in one direction!  So we could even
> skew them by an entire STAT_THRESHOLD.

I just tested both approaches separately. If I leave the STAT_THRESHOLD at 
32 and just add the STAT_THRESHOLD / 2 trick we can scale cleanly up to 
160p in the synthetic test.

I have a bad feeling though for 512p 1024p and 4096p with the static 
approach with STAT_THRESHOLD /2 but it will take some time to get tests 
done on those.

I think the best right now is to just take the dynamic threshold patch. I 
expect that to do just fine at the higher numbers. If we have more trouble 
at 1024p then maybe try STAT_THRESHOLD/2 before going to 
aggregate counter consolidation.


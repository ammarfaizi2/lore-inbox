Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVBPOwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVBPOwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 09:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVBPOws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 09:52:48 -0500
Received: from kanga.kvack.org ([66.96.29.28]:1936 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262031AbVBPOwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 09:52:42 -0500
Date: Wed, 16 Feb 2005 09:52:20 -0500
From: Benjamin LaHaise <bcrl@bcrl.kvack.org>
To: "Richard F. Rebel" <rrebel@whenu.com>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/*/statm, exactly what does "shared" mean?
Message-ID: <20050216145220.GA10400@kvack.org>
References: <1108161173.32711.41.camel@rebel.corp.whenu.com> <Pine.LNX.4.61.0502121158190.18829@goblin.wat.veritas.com> <1108219160.12693.184.camel@blue.obulous.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108219160.12693.184.camel@blue.obulous.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 09:39:20AM -0500, Richard F. Rebel wrote:
> That said, many mod_perl users are *VERY* interested in being able to
> detect and observe how "shared" our forked children are.  Shared meaning
> private pages shared with children (copy on write).  Is it even possible
> to do this in 2.6 kernels?  If so, any pointers would be very helpful.

One thing Hugh didn't mention is the background as to why the shared 
statistic was changed: it comes back to the fact that it was a very 
expensive statistic to calculate.  People running top on systems with 
lots of virtual memory in use (ie lots of processes, applications with 
shared memory segments) were seeing ridiculous cpu usage (100% for seconds 
at a time) by top.  As a result, the statistics available from the statm 
file were changed to counters making the read of statm an O(1) operation.  
This dropped top's cpu usage on a busy system to a much more reasonable 
<1%, making it possible to get an idea what a busy system is actually 
busy with.

		-ben

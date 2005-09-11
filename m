Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVIKHLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVIKHLp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 03:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVIKHLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 03:11:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:12715 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964795AbVIKHLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 03:11:44 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: NUMA mempolicy /proc code in mainline shouldn't have been merged
Date: Sun, 11 Sep 2005 09:11:20 +0200
User-Agent: KMail/1.8
Cc: Christoph Lameter <clameter@engr.sgi.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200509101120.19236.ak@suse.de> <Pine.LNX.4.62.0509101904070.20145@schroedinger.engr.sgi.com> <20050910235139.4a8865c2.akpm@osdl.org>
In-Reply-To: <20050910235139.4a8865c2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509110911.22212.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 September 2005 08:51, Andrew Morton wrote:

> Certainly I can see value in that.  How can a developer test his
> code without any form of runtime feedback?

There are already several ways to do that: first the counters output
by numastat (local_node, other_node, interleave_hit etc.), which tells you 
exactly how the allocation strategy ended up. And a process can find out
on which node a specific page is using get_mempolicy()

If you really want to know what's going on you can use performance counters
of the machine to tell you the amount of cross node traffic
(e.g. see numamon in the numactl source tree as an example) 

I don't think the /proc information gives additional information
to the programmers. Externally you shouldn't know about the 
individual addresses anyways.

All it does is to open the flood gates of external mempolicy management, which 
is wrong.

> It's easy to parse and it is extensible.  It needs documenting though.

Extensible yes, but I have my doubts on easy to parse. User processes
very likely will get it wrong like they traditionally did with anything
more complicated in /proc. /proc/*/maps has been a similar disaster too.

-Andi

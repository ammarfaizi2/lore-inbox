Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVKRDAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVKRDAG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVKRDAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:00:05 -0500
Received: from ns2.suse.de ([195.135.220.15]:26252 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750785AbVKRDAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:00:03 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH] NUMA policies in the slab allocator V2
Date: Fri, 18 Nov 2005 03:59:17 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@osdl.org
References: <Pine.LNX.4.62.0511171745410.22486@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0511171745410.22486@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180359.17598.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 November 2005 02:51, Christoph Lameter wrote:
> This patch fixes a regression in 2.6.14 against 2.6.13 that causes an
> imbalance in memory allocation during bootup.

I still think it's wrongly implemented. We shouldn't be slowing down the slab 
fast path for this. Also BTW if anything your check would need to be 
dependent on !in_interrupt(), otherwise the policy of slab allocations
in interrupt context will change randomly based on what the current
process is doing (that's wrong, interrupts should be always local)
But of course that would make the fast path even slower ...

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWCHVjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWCHVjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWCHVjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:39:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:32136 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750720AbWCHVjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:39:08 -0500
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store
	buffers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: akpm@osdl.org, ak@suse.de, paulus@samba.org, bcrl@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain>
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 08:38:39 +1100
Message-Id: <1141853919.11221.183.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 13:31 -0800, Bryan O'Sullivan wrote:
> In some circumstances, a CPU may perform stores to memory in non-program
> order, or held in on-chip store buffers for a potentially long time.
> These kinds of circumstances include:
> 
> - Stores to a PCI MMIO region that has write combining enabled
> 
> - Use of non-temporal store instructions
> 
> - The CPU's memory model permitting weak store ordering
> 
> This patch introduces a new macro, flush_wc(), that flushes any pending
> stores from the local CPU's write combining store buffers, if the CPU has
> such a capability.  If the CPU doesn't provide explicit control over write
> combining, flush_wc() is simply an alias for wmb().  Here is an example:

I think people already don't undersatnd the existing gazillion of
barriers we have with quite unclear semantics in some cases, it's not
time to add a new one ...

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUCNWeD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 17:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUCNWeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 17:34:02 -0500
Received: from [64.62.253.241] ([64.62.253.241]:28429 "EHLO staidm.org")
	by vger.kernel.org with ESMTP id S261960AbUCNWeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 17:34:01 -0500
Date: Sun, 14 Mar 2004 14:35:51 -0800
From: Bryan Rittmeyer <bryan@staidm.org>
To: Danjel McGougan <danjel.mcgougan@comhem.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32 copy_to_user dcbt fixup
Message-ID: <20040314223549.GA18082@staidm.org>
References: <1z8Na-5hH-1@gated-at.bofh.it> <40531D3D.2090702@comhem.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40531D3D.2090702@comhem.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 03:39:57PM +0100, Danjel McGougan wrote:
> The obvious solution is to invalidate the dcache 
> *after* DMA completion. It seems hard to guarantee that nobody will 
> touch the memory area in question during the DMA.

You need to invalidate prior to submitting for DMA. Otherwise if the
region is dirty the CPU may write back after DMA has begun, causing a 
data corrupting race.

Invalidating before _and_ after is expensive; better to fix the misreads.

-Bryan


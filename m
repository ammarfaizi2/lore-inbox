Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVKURVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVKURVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVKURVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:21:38 -0500
Received: from graphe.net ([209.204.138.32]:5077 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932093AbVKURVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:21:37 -0500
Date: Mon, 21 Nov 2005 09:21:32 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [PATCH] slab: minor cleanup to kmem_cache_alloc_node
In-Reply-To: <Pine.LNX.4.58.0511211627460.18869@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.62.0511210919001.6497@graphe.net>
References: <Pine.LNX.4.58.0511211627460.18869@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Pekka J Enberg wrote:

> This patch gets rid of one if-else statement by moving current node allocation
> check at the beginning of kmem_cache_alloc_node().

The problem with this is that the numa_node may change if irqs are still 
active and your patch moves the check for the numa node outside of the 
section where irqs are enabled.

You could move the check for -1 into the section where interrupts are 
disabled.

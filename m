Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965261AbVIIFgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbVIIFgd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 01:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbVIIFgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 01:36:33 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:45441 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965261AbVIIFgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 01:36:33 -0400
Date: Thu, 8 Sep 2005 22:36:25 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] lockless pagecache 5/7
In-Reply-To: <4317F1BD.8060808@yahoo.com.au>
Message-ID: <Pine.LNX.4.62.0509082227550.6098@schroedinger.engr.sgi.com>
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>
 <4317F136.4040601@yahoo.com.au> <4317F17F.5050306@yahoo.com.au>
 <4317F1A2.8030605@yahoo.com.au> <4317F1BD.8060808@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if it may not be better to use a seqlock for the tree_lock? A
seqlock requires no writes at all if the tree has not been changed. RCU 
still requires the incrementing of a (local) counter.

Using seqlocks would require reworking the readers so that they can 
retry. Seqlocks provide already a verification that no update took place
while the operation was in process. Thus we would be using an established 
framework that insures that the speculation was successful.

The problem is then though to guarantee that the radix trees are always 
traversable since the seqlock's retry rather than block. This would 
require sequencing of inserts and pose a big problem for deletes and 
updates.

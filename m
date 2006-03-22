Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751931AbWCVBfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWCVBfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 20:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWCVBfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 20:35:38 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:13952 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751931AbWCVBfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 20:35:36 -0500
Date: Tue, 21 Mar 2006 17:35:25 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()  (try
 #3)
In-Reply-To: <200603220154.16266.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64.0603211732420.14503@schroedinger.engr.sgi.com>
References: <200603182137.08521.jesper.juhl@gmail.com>
 <84144f020603191040h9b07b10w418b6cdd73f8b114@mail.gmail.com>
 <9a8748490603200055p7be38dc8lac2e78f4798e6def@mail.gmail.com>
 <200603220154.16266.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006, Jesper Juhl wrote:

> Fix memory leak in mm/slab.c::alloc_kmemlist().
> If one allocation fails we have to roll-back all allocations made up to the 
> point of failure.

Sorry but you cannot roll back. alloc_kmemlist() could have been used for
tuning the cpucache while accesses to the slab continue. "Rolling back" 
would partially destroy the slab for some nodes and likely cause the 
system to crash. We can only roll back if this is actually an initial 
allocation and we are assured that the whole thing is not yet in use.


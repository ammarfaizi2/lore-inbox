Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751946AbWCVBtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbWCVBtn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 20:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbWCVBtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 20:49:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51175 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751946AbWCVBtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 20:49:42 -0500
Date: Tue, 21 Mar 2006 17:46:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: jesper.juhl@gmail.com, penberg@cs.helsinki.fi,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix memory leak in mm/slab.c::alloc_kmemlist()  (try
 #3)
Message-Id: <20060321174623.2f92331b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603211732420.14503@schroedinger.engr.sgi.com>
References: <200603182137.08521.jesper.juhl@gmail.com>
	<84144f020603191040h9b07b10w418b6cdd73f8b114@mail.gmail.com>
	<9a8748490603200055p7be38dc8lac2e78f4798e6def@mail.gmail.com>
	<200603220154.16266.jesper.juhl@gmail.com>
	<Pine.LNX.4.64.0603211732420.14503@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Wed, 22 Mar 2006, Jesper Juhl wrote:
> 
> > Fix memory leak in mm/slab.c::alloc_kmemlist().
> > If one allocation fails we have to roll-back all allocations made up to the 
> > point of failure.
> 
> Sorry but you cannot roll back. alloc_kmemlist() could have been used for
> tuning the cpucache while accesses to the slab continue. "Rolling back" 
> would partially destroy the slab for some nodes and likely cause the 
> system to crash. We can only roll back if this is actually an initial 
> allocation and we are assured that the whole thing is not yet in use.

Well that's a big pickle.  How about allocating everything first, saving it
locally then, if that all worked out, install it?


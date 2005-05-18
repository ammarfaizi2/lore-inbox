Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVERCxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVERCxB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 22:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVERCxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 22:53:01 -0400
Received: from graphe.net ([209.204.138.32]:5896 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262064AbVERCwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 22:52:46 -0400
Date: Tue, 17 May 2005 19:52:38 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] NUMA aware allocation of transmit and receive buffers
 for e1000
In-Reply-To: <20050517190343.2e57fdd7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505171941340.21153@graphe.net>
References: <Pine.LNX.4.62.0505171854490.20408@graphe.net>
 <20050517190343.2e57fdd7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Andrew Morton wrote:

> Christoph Lameter <christoph@graphe.net> wrote:
> >
> > NUMA awareness for the e1000 driver. Allocate transmit and receive buffers
> > on the node of the device.
> 
> Hast thou any benchmarking results?

Yes, your honor. Just a second .... The patch has been around for a long 
time.

No benchmarks results in my email archive. Would need to talk to some 
folks tomorrow and maybe we would have to run some new 
benchmarks.

> > -	txdr->buffer_info = vmalloc(size);
> > +	txdr->buffer_info = kmalloc_node(size, GFP_KERNEL, node);
> 
> How come that this is safe to do

Because physically contiguous memory is usually better than virtually 
contiguous memory? Any reason that physically contiguous memory will 
break the driver?


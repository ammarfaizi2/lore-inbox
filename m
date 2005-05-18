Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVERUnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVERUnU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVERUnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:43:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:3208 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262356AbVERUnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 16:43:14 -0400
Date: Wed, 18 May 2005 13:42:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Cc: christoph@lameter.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, shai@scalex86.org
Subject: Re: [PATCH] NUMA aware allocation of transmit and receive buffers
 for e1000
Message-Id: <20050518134250.3ee2703f.akpm@osdl.org>
In-Reply-To: <5fc59ff305051808558f1ce59@mail.gmail.com>
References: <Pine.LNX.4.62.0505171854490.20408@graphe.net>
	<20050517190343.2e57fdd7.akpm@osdl.org>
	<Pine.LNX.4.62.0505171941340.21153@graphe.net>
	<20050517.195703.104034854.davem@davemloft.net>
	<Pine.LNX.4.62.0505172125210.22920@graphe.net>
	<20050517215845.2f87be2f.akpm@osdl.org>
	<5fc59ff305051808558f1ce59@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ganesh Venkatesan <ganesh.venkatesan@gmail.com> wrote:
>
> On 5/17/05, Andrew Morton <akpm@osdl.org> wrote:
> > I think the e1000 driver is being a bit insane there.  I figure that
> Do you mean insane to use vmalloc?
> 
> > sizeof(struct e1000_buffer) is 28 on 64-bit, so even with 4k pagesize we'll
> > always succeed in being able to support a 32k/32 = 1024-entry Tx ring.
> > 
> > Is there any real-world reason for wanting larger ring sizes than that?
> > 
> > 
> We have had cases where allocation of 32K of memory (via kmalloc) fails. 
> 

Are you sure?  The current page allocator will infinitely loop until
success for <=32k GFP_KERNEL allocations - the only way it can fail is if
the calling process gets oom-killed.

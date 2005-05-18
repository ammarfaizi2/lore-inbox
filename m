Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVERE7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVERE7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVERE7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:59:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:4776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262086AbVERE7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:59:34 -0400
Date: Tue, 17 May 2005 21:58:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       shai@scalex86.org
Subject: Re: [PATCH] NUMA aware allocation of transmit and receive buffers
 for e1000
Message-Id: <20050517215845.2f87be2f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505172125210.22920@graphe.net>
References: <Pine.LNX.4.62.0505171854490.20408@graphe.net>
	<20050517190343.2e57fdd7.akpm@osdl.org>
	<Pine.LNX.4.62.0505171941340.21153@graphe.net>
	<20050517.195703.104034854.davem@davemloft.net>
	<Pine.LNX.4.62.0505172125210.22920@graphe.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
> On Tue, 17 May 2005, David S. Miller wrote:
> 
> > > Because physically contiguous memory is usually better than virtually 
> > > contiguous memory? Any reason that physically contiguous memory will 
> > > break the driver?
> > 
> > The issue is whether size can end up being too large for
> > kmalloc() to satisfy, whereas vmalloc() would be able to
> > handle it.
> 
> Oww.. We need a NUMA aware vmalloc for this?  

I think the e1000 driver is being a bit insane there.  I figure that
sizeof(struct e1000_buffer) is 28 on 64-bit, so even with 4k pagesize we'll
always succeed in being able to support a 32k/32 = 1024-entry Tx ring.  

Is there any real-world reason for wanting larger ring sizes than that?

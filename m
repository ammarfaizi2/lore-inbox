Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262922AbSIPU6F>; Mon, 16 Sep 2002 16:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262942AbSIPU6F>; Mon, 16 Sep 2002 16:58:05 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:5643 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S262922AbSIPU6E>; Mon, 16 Sep 2002 16:58:04 -0400
Date: Mon, 16 Sep 2002 23:06:35 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: "David S. Miller" <davem@redhat.com>
cc: akropel1@rochester.rr.com, linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Streaming DMA mapping question
In-Reply-To: <20020915.203006.123845370.davem@redhat.com>
Message-ID: <Pine.LNX.4.21.0209162144550.6230-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, David S. Miller wrote:

>    From: Adam Kropelin <akropel1@rochester.rr.com>
>    Date: Fri, 13 Sep 2002 23:51:13 -0400
>    
>    It seems that pci_dma_sync_*() transfers ownership in either direction.
> 
> That's a bug in the documentation, and no platform which has to care
> about this area actually does what you imply.
> 
> A new interface needs to be added to transfer control in the other
> direction.  pci_dma_sync_*() only handles transferring control from
> device to CPU..
> 
> I know this makes drivers like eepro100 buggy, this was discussed
> a month or two ago wrt. MIPS on linux-kernel, check the archives
> for the thread.

Wasn't there a patch submitted which suggested to add pci_dma_prep_*()
calls in order to sync the cpu-driven changes back to the bus? I'm asking
because I'm dealing with a driver that needs to reuse streaming pci maps.

IIRC my impression was you might be willing to accept this for inclusion
but maybe I'm wrong or it got lost during the long "dmabuf inside struct
may cross cacheline" thread shortly thereafter.

Do you think it would be a good idea to add some nooped pci_dma_prep_*()
calls at the right place and expect them to represent some future 
solution?

Martin


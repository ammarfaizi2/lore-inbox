Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbTJUHRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 03:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbTJUHRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 03:17:46 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:23566 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S262979AbTJUHRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 03:17:45 -0400
Date: Tue, 21 Oct 2003 09:12:53 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: "David S. Miller" <davem@redhat.com>
cc: Martin Diehl <lists@mdiehl.de>, <noah@caltech.edu>,
       <irda-users@lists.sourceforge.net>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [irda-users] [PATCH] Make VLSI FIR depend on X86
In-Reply-To: <20031020211706.5be33474.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0310210858550.4246-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Oct 2003, David S. Miller wrote:

> On Mon, 20 Oct 2003 19:30:33 +0200 (CEST)
> Martin Diehl <lists@mdiehl.de> wrote:
> 
> > Well, it would work with any arch, _if_ there was a way to sync the 
> > streaming pci dma buffers before giving them back to hardware.
> 
> If pci_dma_sync() doesn't perform the operation you want, please
> describe what that operation is.
> 

Last time I checked pci_dma_sync was meant to sync the mapping when 
ownership gets transferred from busmaster to cpu, i.e. after hardware 
used/modified the buffer. What about the other direction when the cpu 
filled a reused streaming map to device and wants to pass ownership to the 
busmaster - we need to flush cpu caches to make sure the busmaster sees 
the modified data.

<http://marc.theaimsgroup.com/?l=linux-kernel&amp;m=103221032617171&amp;w=2>
<http://marc.theaimsgroup.com/?l=linux-kernel&amp;m=103221300019951&amp;w=2>

Did I miss something?

Thanks,
Martin


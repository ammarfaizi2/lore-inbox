Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUAEVJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265892AbUAEVJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:09:35 -0500
Received: from colin2.muc.de ([193.149.48.15]:19979 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265851AbUAEVJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:09:23 -0500
Date: 5 Jan 2004 22:10:16 +0100
Date: Mon, 5 Jan 2004 22:10:16 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@muc.de>, gibbs@scsiguy.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple map/unmaps
Message-ID: <20040105211016.GA52683@colin2.muc.de>
References: <2938942704.1073325455@aslan.btc.adaptec.com> <m3brpi41q0.fsf@averell.firstfloor.org> <20040105123509.4bacf670.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105123509.4bacf670.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 12:35:09PM -0800, David S. Miller wrote:
> On Mon, 05 Jan 2004 20:47:19 +0100
> Andi Kleen <ak@muc.de> wrote:
> 
> > Actually I disabled merging by default in the latest x86-64 code,
> > but it can be still enabled by the user using options (it makes some
> > adapters run several percent faster). I would appreciate if you could
> > fix the problem anyways.
> > 
> > I was actually planning to add a BUG() for this. Should do that.
> > There is already one that triggers often when the problem occurs.
> 
> Andi, you must not modify sg->length in any way shape or form.
> 
> The following is legal:
> 
> 	pci_map_sg(..&sg);
> 	pci_unmap_sg(...&sg);
> 	pci_map_sg(..&sg);

Well, on x86-64 it is not legal.

> If you must modify the length field for DMA, you must have a seperate
> dma_length member of the scatterlist structure on your platform, see what
> sparc64 does here.
> 
> If the documentation states this wrongly, it's a doc bug.

The documentation doesn't allow it so I didn't implement it.

-Andi

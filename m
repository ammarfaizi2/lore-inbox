Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273034AbTHPOjz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273049AbTHPOjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:39:55 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:18289 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S273034AbTHPOjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:39:54 -0400
Date: Sat, 16 Aug 2003 17:39:52 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] slab debug vs. L1 alignement
In-Reply-To: <1061033789.582.126.camel@gaston>
Message-ID: <Pine.LNX.4.56.0308161717480.3426@kai.makisara.local>
References: <3F3D558D.5050803@colorfullife.com>  <1060990883.581.87.camel@gaston>
 <3F3D8D3B.3020708@colorfullife.com>  <1061026667.881.100.camel@gaston> 
 <3F3E02EE.8080909@colorfullife.com>  <1061030600.582.121.camel@gaston> 
 <Pine.LNX.4.56.0308161359460.1703@kai.makisara.local> <1061033789.582.126.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003, Benjamin Herrenschmidt wrote:

...
> THe low level driver can't do the bounce buffer thing, it has to be
> done at higher layers.
>
Agreed. A high-level driver must be able to handle this anyway because of
other constraints. The point is that this costs cpu cycles and bouncing
should be avoided if possible.

> > If an architecture has restrictions, they must, of course, be taken into
> > account. However, this should not punish architectures that don't have the
...
> > sizes. This would mean adding two more masks for each device (like the
> > current DMA address mask for a device).
>
> That won't help for buffers coming from higher layers that don't know
> the device they'll end up to
>
Agreed. This just enables the high-level driver to avoid bouncing. For
instance, in a P4 system it is usually not necessary to require 128 byte
alignment for DMA.

-- 
Kai

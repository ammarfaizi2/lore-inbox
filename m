Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272836AbTHPLhP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 07:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272837AbTHPLhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 07:37:15 -0400
Received: from AMarseille-201-1-3-2.w193-253.abo.wanadoo.fr ([193.253.250.2]:29735
	"EHLO gaston") by vger.kernel.org with ESMTP id S272836AbTHPLhO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 07:37:14 -0400
Subject: Re: [BUG] slab debug vs. L1 alignement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0308161359460.1703@kai.makisara.local>
References: <3F3D558D.5050803@colorfullife.com>
	 <1060990883.581.87.camel@gaston> <3F3D8D3B.3020708@colorfullife.com>
	 <1061026667.881.100.camel@gaston>  <3F3E02EE.8080909@colorfullife.com>
	 <1061030600.582.121.camel@gaston>
	 <Pine.LNX.4.56.0308161359460.1703@kai.makisara.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061033789.582.126.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Aug 2003 13:36:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ->
> A character device (like st) doing direct i/o from user buffer to/from a
> SCSI device does not currently have any alignment restrictions. I think
> restricted alignment can't be required from a user of an ordinary
> character device. This must then be handled by the driver. The solution is
> to use bounce buffers in the driver if the alignment does not meet the
> lower level requirements. This leads to surprises with performance if the
> user buffer alignment does not satisfy the requirements (e.g., malloc()
> may or may not return properly aligned blocks). These surprises should be
> avoided as far as the hardware allows.

THe low level driver can't do the bounce buffer thing, it has to be
done at higher layers. 

> If an architecture has restrictions, they must, of course, be taken into
> account. However, this should not punish architectures that don't have the
> restrictions. Specifying that DMA buffers must be cache-line aligned would
> be too strict. A separate alignment constraint for DMA in general and for
> a device in specific would be a better alternative (a device may have
> tighter restrictions than an architecture). The same applies to buffer
> sizes. This would mean adding two more masks for each device (like the
> current DMA address mask for a device).

That won't help for buffers coming from higher layers that don't know
the device they'll end up to

Ben.

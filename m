Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUAURI2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 12:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbUAURI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 12:08:28 -0500
Received: from mail0.lsil.com ([147.145.40.20]:34282 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S266039AbUAURHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 12:07:52 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703A75F51@exa-atlanta.se.lsil.com>
From: "Moore, Eric Dean" <Emoore@lsil.com>
To: Christoph Hellwig <hch@infradead.org>, Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: RE: [2.6 patch] show "Fusion MPT device support" menu only if BLK
	_DEV_SD
Date: Wed, 21 Jan 2004 12:00:09 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "config FUSION" entry in Kconfig is handling both mptbase.ko 
and mptscsih.ko for some reason?

The mptbase.ko driver is the lower layer driver which configures
the adapters and is transport layer to and from the chip. It doesn't
depend on anything in the scsi mid layer.  

The mptscsih.ko does depend on scsi_mod.ko, but not sd.ko  

Therefore - maybe we could have separate entries in Kconfig for
both mptbase and mptscsih.  mptbase depend on PCI, and mptscsih
depend on SCSI. What do you think?

Eric Moore
LSI Logic

On Tuesday, January 20, 2004 4:36 PM, Christoph Hellwig wrote:
> On Wed, Jan 21, 2004 at 12:25:07AM +0100, Adrian Bunk wrote:
> > With BLK_DEV_SD=n, I see a "Fusion MPT device support" menu I can't 
> > enter.
> > 
> > The simple patch below removes the "Fusion MPT device 
> support" menu if 
> > BLK_DEV_SD=n.
> 
> I'd rather see an explanation from LSI why a scsi LLDD depens 
> on a uper
> driver.  This can't be right.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTKQT0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 14:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTKQT0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 14:26:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:26010 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263619AbTKQT02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 14:26:28 -0500
X-Authenticated: #20450766
Date: Mon, 17 Nov 2003 20:25:19 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: DMA_NONE data_direction in scsi
Message-ID: <Pine.LNX.4.44.0311172013230.2258-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

While trying to fix tmscsim for 2.6, I've arrived at the Oops below, which
is caused by the BUG_ON() in dma_map_page(). In the backtrace below,
data_direction is set to DMA_BIDIRECTIONAL in sd_revalidate_disk(),

                sreq->sr_data_direction = DMA_BIDIRECTIONAL;

, but already in sd_spinup_disk() it is reset to DMA_NONE:

                        SRpnt->sr_data_direction = DMA_NONE;

So, the question is: is this the correct behaviour, and, if so - how is
the driver supposed to map this request - which direction to pass to
dma_map_*?

Thanks
Guennadi
---
Guennadi Liakhovetski


-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



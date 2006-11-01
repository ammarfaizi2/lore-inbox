Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752578AbWKAXxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbWKAXxf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbWKAXxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:53:35 -0500
Received: from junsun.net ([66.29.16.26]:22540 "EHLO junsun.net")
	by vger.kernel.org with ESMTP id S1752578AbWKAXxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:53:34 -0500
Date: Wed, 1 Nov 2006 15:53:30 -0800
From: Jun Sun <jsun@junsun.net>
To: linux-kernel@vger.kernel.org
Subject: unchecked_isa_dma and BusLogic SCSI controller
Message-ID: <20061101235330.GA30843@srv.junsun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can someone enlighten me on what "unchecked_isa_dma" means in the
struct scsi_host_template?  Specifically why Bus_Logic_template has
it set to 1?

I am trying to reserve a block of memory (>16MB) starting from 0 and hide
it from kernel.  As a result, the DMA zone becomes 0 in size.

Because Bus_Logic_template has unchecked_isa_dma set to 1, the driver
will attempt to allocate a block of memory from DMA zone and thus
causes OOMs during its initialization.

It is hard for me to see why BusLogic controller would only do DMA
in low 16MB.  Is there a fix for this?

BTW, I also tried to increase MAX_DMA_ADDRESS to cover the whole memory
area.  While the OOMs are gone during BusLogic driver initialization, 
kernel fails to find labelled root partition or fail to open
the initial console.  It appears the disk (or the scsi) is not working
properly after increasing MAX_DMA_ADDRESS.

My platform is vmplayer.  Pretty cool for devel.

Cheers.

Jun

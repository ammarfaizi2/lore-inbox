Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbVIVPPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbVIVPPD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbVIVPPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:15:03 -0400
Received: from web88002.mail.re2.yahoo.com ([206.190.37.189]:58983 "HELO
	web88002.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030396AbVIVPPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:15:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=aoZF6Hke/Q3DhHtnU/DPKhxf++eAX8Sojnxn9klD0l8WFsopEpwPGLSLAtNnVK2CaOTrdRWeavU1F9iVmty2py/s0LWqFsTKm9Z9a3ubq4ChiXwAe1tchcMPv78i0E7sZ5OpsSONBWpi67nkJb5DNZen7GQpHF7RrHXyPKzasHM=  ;
Message-ID: <20050922151500.87532.qmail@web88002.mail.re2.yahoo.com>
Date: Thu, 22 Sep 2005 11:15:00 -0400 (EDT)
From: Andre Straker-Payne <andre_straker@yahoo.com>
Reply-To: andre_straker@strakerpayne.com
Subject: scsi_scan.c
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With regards to Linux 2.6, file "drivers/scsi/scsi_scan.c", lines 691 and 928.

691         result = kmalloc(256, GFP_ATOMIC |
692                         (host->unchecked_isa_dma) ? __GFP_DMA : 0);

928         lun_data = kmalloc(length, GFP_ATOMIC |
929                            (sdev->host->unchecked_isa_dma ? __GFP_DMA :
0));

In line 691, the evaluation done to fill the priority field for the kmalloc is
ambiguous. If your system does not support the GFP_DMA type, this call will
fail, since it always evaluates true. I imagine that 928 is shows what this 691
should look like.

Andre Straker-Payne

"There are known knowns. These are things we know that we know. There are known unknowns. That is to say, there are things that we know we don't know. But there are also unknown unknowns. There are things we don't know we don't know. "

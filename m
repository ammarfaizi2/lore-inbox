Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVC3NFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVC3NFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 08:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVC3NFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 08:05:17 -0500
Received: from main.gmane.org ([80.91.229.2]:1211 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261885AbVC3NFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 08:05:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Call chain analysis
Date: Wed, 30 Mar 2005 15:04:28 +0200
Organization: {M:U} IT-Consulting
Message-ID: <pan.2005.03.30.13.04.25.128572@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4E   G?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running into an IRQ problem while removing USB adapters (e.g., when
pulling a PCMCIA card with an OHCI on it).

Specifically, this call chain
  usb_hcd_pci_remove -> hcd_buffer_destroy -> dma_pool_destroy
    -> pool_free_page -> free_hot_cold_page -> IRQ -> usb_hcd_irq
results in a crash. That's not the immediate problem, though.

The problem is that wrapping usb_hcd_pci_remove() in a local_irq_save/
/restore *still* allows that interrupt to happen. I suspect that something
in that call chain sometimes calls the scheduler ..?

I assume that there are nice tools which find that call for me, and save
me from plowing through a lot of kernel code ..? I've never needed one of
those before. :-/

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de



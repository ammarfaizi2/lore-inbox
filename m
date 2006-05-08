Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWEHV6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWEHV6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWEHV6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:58:11 -0400
Received: from main.gmane.org ([80.91.229.2]:64936 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751162AbWEHV6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:58:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: libata PATA patch update
Date: Mon, 08 May 2006 23:57:54 +0200
Message-ID: <pan.2006.05.08.21.57.53.522263@free.fr>
References: <1147104400.3172.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Le Mon, 08 May 2006 17:06:40 +0100, Alan Cox a écrit :

> I've posted a new patch versus 2.6.17-rc3 up at the usual location.
> 
> http://zeniv.linux.org.uk/~alan/IDE
> 
Aren't there a bug in via cable detect ?

The via ide driver do
pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
for (i = 24; i >= 0; i -= 8)
                                if (((u >> i) & 0x10) ||
                                    (((u >> i) & 0x20) &&
                                     (((u >> i) & 7) < 6))) {
                                        /* BIOS 80-wire bit or
                                         * UDMA w/ < 60ns/cycle
                                         */
                                        vdev->via_80w |= (1 << (1 - (i >> 4)));
                                }
80w = (vdev->via_80w >> hwif->channel) & 1;

upper bit are for channel 0 and lower bit for channel 1.
the pata driver do
pci_read_config_dword(pdev, 0x50, &ata66);
80w = ata66 & (0x1010 << (16 * ap->hard_port_no))
upper bit are for channel 1 and lower bit for channel 0.

at boot VIA_UDMA_TIMING is 0xf1f1e6e6 for a 80w cable on channel 0 and 40w
cable on channel 1.
Pata driver set my UDMA100 disk at UDMA33.

Matthieu.

PS : any idea in order to allow to work my cdrw drive, that don't return
interrupt when setting xfermode ?


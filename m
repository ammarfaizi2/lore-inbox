Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWEQTJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWEQTJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 15:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWEQTJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 15:09:59 -0400
Received: from main.gmane.org ([80.91.229.2]:58284 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750986AbWEQTJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 15:09:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: libata PATA updated patch
Date: Wed, 17 May 2006 21:09:19 +0200
Message-ID: <pan.2006.05.17.19.09.14.685473@free.fr>
References: <1147796037.2151.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 16 May 2006 17:13:57 +0100, Alan Cox a écrit :

> I've put a patch versus -rc4 in the usual place. This should sort out
> the PIO problems and a few other glitches
> 
> Alan
> 
> http://zeniv.linux.org.uk/~alan/IDE
Ok the via timing are ok now.

If I had in ata_host_intr someting like [1] for checking the altstatus, my
ATAPI drive works.
It report "ata_altstatus take 3us", for driver that wasn't worked before.

I don't know if it is a correct fix and where it should be putted (in
libata-core or in the pata_via check_altstatus callback).
I don't know if it should be used only for ATA_CMD_SET_FEATURES &&
SETFEATURES_XFER.

Now real testing could begging.

Matthieu



[1]
		for (i=0; ata_altstatus(ap) & ATA_BUSY; i++) {
                        if (i > 10)
                                goto idle_irq;
                udelay(1);
                }
                if (i)
                        printk("ata_altstatus take %dus\n", i);


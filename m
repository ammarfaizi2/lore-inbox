Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbVKHMIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbVKHMIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbVKHMIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:08:30 -0500
Received: from onyx.ip.pt ([195.23.92.252]:41695 "EHLO mail.isp.novis.pt")
	by vger.kernel.org with ESMTP id S965006AbVKHMI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:08:29 -0500
Subject: Re: [Patch 1/1] V4L (926) Saa7134 alsa can only be autoloaded
	after	saa7134 is active
From: R C <v4l@cerqueira.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: mchehab@brturbo.com.br, linux-kernel@vger.kernel.org, akpm@osdl.org,
       video4linux-list@redhat.com, rlrevell@joe-job.com,
       alsa-devel@lists.sourceforge.net, nshmyrev@yandex.ru
In-Reply-To: <s5hd5lbnzg6.wl%tiwai@suse.de>
References: <1131397121.6632.127.camel@localhost>
	 <s5hd5lbnzg6.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 12:07:50 +0000
Message-Id: <1131451671.2863.4.camel@frolic>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 12:36 +0100, Takashi Iwai wrote:
[...]

>   Note that "goto done" may
> require the lock again.  Also, the succeeding saa7134_dma_stop() is
> superfluous.
> 

No, it's not. dma_stop also affects the main saa7134 module, and it's
needed there.

[...]


> @@ -973,18 +963,17 @@ int alsa_card_saa7134_create (struct saa
> >  	chip->irq = saadev->pci->irq;
> >  	chip->iobase = pci_resource_start(saadev->pci, 0);
> >  
> > -	err = request_irq(chip->pci->irq, saa7134_alsa_irq,
> > +	err = request_irq(saadev->pci->irq, saa7134_alsa_irq,
> >  				SA_SHIRQ | SA_INTERRUPT, saadev->name, saadev);
> 
> Hmm, still I don't see any call of free_irq() in the driver?
> 

It was added to v4l CVS shortly after Mauro sent the last patchset,
should be sent upstream in the next patchset.
[...]


--
RC


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVCRXiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVCRXiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVCRXiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:38:18 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:42380 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262082AbVCRXhu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:37:50 -0500
Date: Sat, 19 Mar 2005 00:34:29 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jonas Oreland <jonas.oreland@mysql.com>
Cc: daniel.ritz@gmx.ch, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
Subject: Re: yenta_socket "nobody cared - Disabling IRQ #4"
Message-ID: <20050318233429.GA24460@electric-eye.fr.zoreil.com>
References: <200503182243.24174.daniel.ritz@gmx.ch> <423B5D7A.1060304@mysql.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423B5D7A.1060304@mysql.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonas Oreland <jonas.oreland@mysql.com> :
[...]
> Report:
> 1) It works somewhat better. irq doesn't get disabled.
> 2) however wlan card get disfunctional. I haven't been able to contact my 
> wap
>   even if i'm standing on it...
> 3) unplug has resulted in kernel panic (twice)
>   (btw: how do I do to capture and report those)
> 4) when unlug don't produce kernel panic, then there is no way of 
> power-oning that card again.
> 5) booting with the card inserted makes it not power on when yenta_socket 
> is loaded (module)
> 
> comment: the card being disfunction could have something to with the driver.
> but before it worked sometimes...

static int
ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
[...]
        if (request_irq(dev->irq, ath_intr, SA_SHIRQ, dev->name, dev)) {
                printk(KERN_WARNING "%s: request_irq failed\n", dev->name);
                goto bad3;
        }
[...]
        athname = ath_hal_probe(id->vendor, id->device);
        printk(KERN_INFO "%s: %s: mem=0x%lx, irq=%d\n",
                dev->name, athname ? athname : "Atheros ???", phymem, dev->irq);

        /* ready to process interrupts */
        sc->aps_sc.sc_invalid = 0;

No sources for ath_hal_probe, too bad.

However, even without any sources, a driver which includes an "I am not ready
to process interrupts" flag and issue request_irq() without having disabled
the device first makes me a bit nervous.

--
Ueimor

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163743AbWLGXIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163743AbWLGXIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163834AbWLGXIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:08:52 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52919 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163743AbWLGXIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:08:51 -0500
Date: Thu, 7 Dec 2006 15:08:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, barkalow@iabervon.org
Subject: Re: [git patch] improve INTx toggle for PCI MSI
Message-Id: <20061207150831.7f898ce1.akpm@osdl.org>
In-Reply-To: <20061207225812.GA13917@havoc.gtf.org>
References: <20061207225812.GA13917@havoc.gtf.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 17:58:12 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> 
> "it boots" on ICH7 at least.

That's a rave review ;)

> Please pull from 'intx' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git intx
> 
> to receive the following updates:
> 
>  drivers/pci/msi.c |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)
> 
> Jeff Garzik:
>       PCI MSI: always toggle legacy-INTx-enable bit upon MSI entry/exit

Why?

> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 9fc9a34..c2828a3 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -255,10 +255,8 @@ static void enable_msi_mode(struct pci_d
>  		pci_write_config_word(dev, msi_control_reg(pos), control);
>  		dev->msix_enabled = 1;
>  	}
> -    	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
> -		/* PCI Express Endpoint device detected */
> -		pci_intx(dev, 0);  /* disable intx */
> -	}
> +
> +	pci_intx(dev, 0);  /* disable intx */
>  }
>  
>  void disable_msi_mode(struct pci_dev *dev, int pos, int type)
> @@ -276,10 +274,8 @@ void disable_msi_mode(struct pci_dev *de
>  		pci_write_config_word(dev, msi_control_reg(pos), control);
>  		dev->msix_enabled = 0;
>  	}
> -    	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
> -		/* PCI Express Endpoint device detected */
> -		pci_intx(dev, 1);  /* enable intx */
> -	}
> +
> +	pci_intx(dev, 1);  /* enable intx */
>  }
>  
>  static int msi_lookup_irq(struct pci_dev *dev, int type)

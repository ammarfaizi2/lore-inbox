Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265319AbRGBQD3>; Mon, 2 Jul 2001 12:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265323AbRGBQDT>; Mon, 2 Jul 2001 12:03:19 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55453 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265319AbRGBQDB>;
	Mon, 2 Jul 2001 12:03:01 -0400
Message-ID: <3B409B33.E672C5BC@mandrakesoft.com>
Date: Mon, 02 Jul 2001 12:02:59 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Tobias Ringstrom <tori@unhappy.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mochel@transmeta.com, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: WOL with 3c59x and 2.4.6-pre6 breaks WOL
In-Reply-To: <Pine.LNX.4.33.0106291257180.3935-200000@boris.prodako.se> <3B4096D9.36F40BF4@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> --- linux-2.4.6-pre8/drivers/pci/pci.c  Sun Jul  1 16:11:25 2001
> +++ linux-akpm/drivers/pci/pci.c        Tue Jul  3 01:28:35 2001
> @@ -425,7 +425,7 @@ int pci_enable_wake(struct pci_dev *dev,
> 
>         if (enable) value |= PCI_PM_CTRL_PME_STATUS;
>         else value &= ~PCI_PM_CTRL_PME_STATUS;
> -
> +       value |= PCI_PM_CTRL_PME_ENABLE;
>         pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
> 
>         return 0;

wrong but it seems you spotted a bug in the code -- set/clear _ENABLE
right above your change here.  maybe read and write _STATUS
unconditionally, for paranoia.

-- 
Jeff Garzik      | The LSB is a bunch of crap.
Building 1024    | E-mail for details.
MandrakeSoft     |

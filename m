Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbRGJMhk>; Tue, 10 Jul 2001 08:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266259AbRGJMha>; Tue, 10 Jul 2001 08:37:30 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54231 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266256AbRGJMhL>;
	Tue, 10 Jul 2001 08:37:11 -0400
Message-ID: <3B4AF6F5.D7F41BDB@mandrakesoft.com>
Date: Tue, 10 Jul 2001 08:37:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>
Cc: mj@ucw.cz, alan@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  PCI probing status cleanup
In-Reply-To: <3B4AA705.29150671@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
>         /* some broken boards return 0 or ~0 if a slot is empty: */
> -       if (l == 0xffffffff || l == 0x00000000 || l == 0x0000ffff || l == 0xffff0000)
> +       if (l == 0xffffffff || l == 0x00000000
> +        || l == 0x0000ffff || l == 0xffff0000) {
> +               /*
> +                * host/pci and pci/pci bridges will set Received Master Abort
> +                * (bit 13) on failed configuration access (happens when
> +                * searching for devices).  To be safe, clear the status
> +                * register.
> +                */
> +               unsigned short st;
> +               pci_read_config_word(temp, PCI_STATUS, &st);
> +               pci_write_config_word(temp, PCI_STATUS, st);
>                 return NULL;
> +       }

ok, though I wonder if we shouldn't just clear status for all PCI
devices on boot for paranoia's sake.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287946AbSCDKp0>; Mon, 4 Mar 2002 05:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSCDKpR>; Mon, 4 Mar 2002 05:45:17 -0500
Received: from [195.63.194.11] ([195.63.194.11]:53257 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287946AbSCDKpC>; Mon, 4 Mar 2002 05:45:02 -0500
Message-ID: <3C834FF8.4040405@evision-ventures.com>
Date: Mon, 04 Mar 2002 11:44:08 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: IDE cleanup eats disks
In-Reply-To: <UTC200203032202.WAA145534.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> On one of my machines I lose two disk drives with
> 2.5.6-pre2 that still were present with 2.5.6-pre1.
> Looking why, I see that the cleanup of ide-pci.c
> cleaned them away.
> 
> This is not necessarily bad, leaving things as they are is
> certainly an option, although maybe I prefer the old situation,
> but I just report the fact that the cleanup changes behaviour.
> 
> In this case I had two disks hanging off a HPT366 card
> but no CONFIG_BLK_DEV_HPT366 selected. Until now this
> worked: the values {PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366}
> were always compiled in. On the other hand, 2.5.6-pre2 only
> knows about them when CONFIG_BLK_DEV_HPT366 is selected,
> so does not recognize the card and does not see the disks.
> 
> As a check I changed 2.5.6-pre2 by
> 
>  #ifdef CONFIG_BLK_DEV_HPT366
>         {PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, pci_init_hpt366, ...
> +#else
> +       {PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, NULL, NULL,
> +        IDE_NO_DRIVER, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
> +	 OFF_BOARD, 240, ATA_F_IRQ | ATA_F_HPTHACK },
>  #endif
> 
> and indeed, this brings the drives back to life.

Well unfortunately there where ton's of changes there, so I would
rather wonder myself if anything didn't break.

Thank you for fixing this! But instead of making the above addtional
entries an preprocessor else, it would be better to just add them at the
end of the list as duplicated fall-back cases.



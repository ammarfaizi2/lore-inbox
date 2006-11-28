Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935775AbWK1IZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935775AbWK1IZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 03:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935774AbWK1IZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 03:25:44 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:27777 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935771AbWK1IZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 03:25:43 -0500
Message-ID: <456BF26B.6040607@garzik.org>
Date: Tue, 28 Nov 2006 03:25:15 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: akpm@osdl.org, davem@davemloft.net, htejun@gmail.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6] sata_promise updates
References: <200611222100.kAML0FlK010399@alkaid.it.uu.se>
In-Reply-To: <200611222100.kAML0FlK010399@alkaid.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> On Tue, 21 Nov 2006 16:07:17 -0500, Jeff Garzik wrote:
>> Mikael Pettersson wrote:
>>> This patch updates the sata_promise driver as follows:
> ...
>> Looks pretty decent to me.  Two small nits:
>>
>> 1) no_tbg_slew_init should be a bit flag ("1 << 0") inside a 'flags' 
>> variable in struct pdc_host_priv.
>>
>> 2) Check pdc_ulsata2 again, I think the flash control register is 
>> programmed with a different value on SATAI versus SATAII.
> 
> Done. Updated patch below.
> 
> This patch updates the sata_promise driver as follows:
> - Correct typo in definition of PDC_TBG_MODE: it's at 0x41C not 0x41
>   in first-generation chips. This error caused PCI access alignment
>   exceptions on SPARC64, and on all platforms it disabled the expected
>   initialisation of TBG mode.
> - Add flags field to struct pdc_host_priv. Define PDC_FLAG_GEN_II
>   and use it to distinguish first- and second-generation chips.
> - Prevent the FLASH_CTL FIFO_SHD bit from being set to 1 on second-
>   generation chips. This matches Promises' ulsata2 driver.
> - Prevent TBG mode and SLEW rate initialisation in second-generation chips.
>   These two registers have moved, TBG mode has been redefined, and
>   Promise's ulsata2 driver no longer attempts to initialise them.
> - Correct PCI device table so devices 0x3570, 0x3571, and 0x3d73 are
>   marked as 2057x (2nd gen) not 2037x (1st gen).
> - Correct PCI device table so device 0x3d17 is marked as 40518
>   (2nd gen 4 ports) not 20319 (1st gen 4 ports).
> - Correct pdc_ata_init_one() to treat 20771 as a second-generation chip.
> 
> Tested on 0x3d75 (2nd gen), 0x3d73 (2nd gen), and 0x3373 (1st gen) chips.
> The information comes from the newly uploaded Promise SATA HW specs,
> Promise's ultra and ulsata2 drivers, and debugging on 3d75/3d73/3373 chips.
> 
> hp->hotplug_offset could now be removed and its value recomputed
> in pdc_host_init() using hp->flags, but that would be a cleanup
> not a functional change, so I'm ignoring it for now.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

applied to libata-dev.git#upstream (queued for 2.6.20)



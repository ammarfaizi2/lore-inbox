Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWKUVHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWKUVHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWKUVHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:07:35 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:38878 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161051AbWKUVHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:07:33 -0500
Message-ID: <45636A85.40700@garzik.org>
Date: Tue, 21 Nov 2006 16:07:17 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, htejun@gmail.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6] sata_promise updates
References: <200611212057.kALKvL8n009798@harpo.it.uu.se>
In-Reply-To: <200611212057.kALKvL8n009798@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch updates the sata_promise driver as follows:
> - Correct typo in definition of PDC_TBG_MODE: it's at 0x41C not 0x41
>   in first-generation chips. This error caused PCI access alignment
>   exceptions on SPARC64, and on all platforms it disabled the expected
>   initialisation of TBG mode.
> - Prevent TBG mode and SLEW rate initialisation in second-generation chips.
>   These two registers have moved, TBG mode has been redefined, and
>   Promise's ulsata2 driver no longer attempts to initialise them.
> - Correct PCI device table so devices 0x3570, 0x3571, and 0x3d73 are
>   marked as 2057x (2nd gen) not 2037x (1st gen).
> - Correct PCI device table so device 0x3d17 is marked as 40518
>   (2nd gen 4 ports) not 20319 (1st gen 4 ports).
> - Correct pdc_ata_init_one() to treat 20771 as a second-generation chip.
>   (The 20771 classification is redundant as it is equivalent to 2057x.)
> 
> Tested on 0x3d75 (2nd gen), 0x3d73 (2nd gen), and 0x3373 (1st gen) chips.
> The information comes from the newly uploaded Promise SATA HW specs,
> Promise's ultra and ulsata2 drivers, and debugging on 3d75/3d73/3373 chips.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Looks pretty decent to me.  Two small nits:

1) no_tbg_slew_init should be a bit flag ("1 << 0") inside a 'flags' 
variable in struct pdc_host_priv.

2) Check pdc_ulsata2 again, I think the flash control register is 
programmed with a different value on SATAI versus SATAII.

	Jeff



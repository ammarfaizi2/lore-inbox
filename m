Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161666AbWKAFH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161666AbWKAFH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161665AbWKAFH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:07:56 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:16603 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161663AbWKAFHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:07:55 -0500
Message-ID: <45482BA7.6070904@pobox.com>
Date: Wed, 01 Nov 2006 00:07:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Conke Hu <conke.hu@amd.com>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: AHCI should try to claim all AHCI controllers
References: <FFECF24D2A7F6D418B9511AF6F358602F2CE9E@shacnexch2.atitech.com>
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F358602F2CE9E@shacnexch2.atitech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conke Hu wrote:
> Hi all,
> 	According to PCI 3.0 spec, ACHI's PCI class code is 0x010601,
> and I suggest the ahci driver had better try to claim all ahci
> controllers, pls see the following patch:
> 
> diff -Nur linux-2.6.17/drivers/scsi/ahci.c
> linux-2.6.17-ahci/drivers/scsi/ahci.c
> --- linux-2.6.17/drivers/scsi/ahci.c	2006-06-18 09:49:35.000000000
> +0800
> +++ linux-2.6.17-ahci/drivers/scsi/ahci.c	2006-10-31
> 22:50:54.000000000 +0800
> @@ -296,6 +296,11 @@
>  	  board_ahci }, /* ATI SB600 non-raid */
>  	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_ahci }, /* ATI SB600 raid */
> +	/* Claim all AHCI controllers not listed above. 
> +	 * According to PCI 3.0, AHCI's class code is 0x010601 
> +        */
> +	{ PCI_AND_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, 0x010601,
> 0xffffff, 
> +	board_ahci },
>  	{ }	/* terminate list */
>  };

Since things have settled in this area, yes, this would probably be a 
good thing to add.

For the benefit of others, some background:  we should not be -removing- 
any PCI IDs due to this, because quite often the PCI class code will be 
RAID or something else, yet still be drive-able with this ahci driver.

	Jeff




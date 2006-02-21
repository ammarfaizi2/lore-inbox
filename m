Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWBUSZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWBUSZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWBUSZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:25:14 -0500
Received: from mms2.broadcom.com ([216.31.210.18]:10512 "EHLO
	mms2.broadcom.com") by vger.kernel.org with ESMTP id S932260AbWBUSZM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:25:12 -0500
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Subject: Re: [PATCH] tg3: netif_carrier_off runs too early; could still
 be queued when init fails
From: "Michael Chan" <mchan@broadcom.com>
To: "Jeff Mahoney" <jeffm@suse.com>
cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Jeff Garzik" <jgarzik@pobox.com>, netdev@vger.kernel.org
In-Reply-To: <20060220194337.GA21719@locomotive.unixthugs.org>
References: <20060220194337.GA21719@locomotive.unixthugs.org>
Date: Tue, 21 Feb 2006 08:44:20 -0800
Message-ID: <1140540260.20584.6.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006022107; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230312E34334642354145412E303038452D412D;
 ENG=IBF; TS=20060221182521; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006022107_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FE5849A36S1042721-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 14:43 -0500, Jeff Mahoney wrote:
>  This patch moves the netif_carrier_off() call from tg3_init_one()->
>  tg3_init_link_config() to tg3_open() as is the convention for most
>  other network drivers.

I think moving netif_carrier_off() later is the right thing to do. We
can also move it to the end of tg3_init_one() just before returning 0.

> 
>  I was getting a panic after a tg3 device failed to initialize due to DMA
>  failure. The oops pointed to the link watch queue with spinlock debugging
>  enabled. Without spinlock debugging, the Oops didn't occur.
> 
>  I suspect that the link event was getting queued but not executed until
>  after the DMA test had failed and the device was freed. The link event
>  was then operating on freed memory, which could contain anything. With this
>  patch applied, the Oops no longer occurs. 

DMA test failed? What NIC device do you have? How did it fail?

Thanks.



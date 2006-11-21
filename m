Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966900AbWKUCwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966900AbWKUCwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 21:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966901AbWKUCwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 21:52:25 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:30097 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966900AbWKUCwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 21:52:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=5XNeef/wl1lqmKuSOaSggs36zVSZA74m/+kCfAPE5xzcgtFd3MQbOQOKNdGksdF/V/eH8ulIG5PcssOM7Ywa56JsemhAf70yIwlQIsm4ICyh5APvYt0NxnNN9vyshDCwWZoN6XVeZctpIE1FpqvRxg9xBURBxqw0YC8tCAfRjIw=  ;
X-YMail-OSG: ayHcAkwVM1m61i1xDq41q6r2D0P_1.YBbID5KYEw4ArDMHMeGtOp6bK.xTRhuY46Taxcw00jyfLmkqXZs2IoH0QlQoExLhMr63_lm1BDnIs4iP0FyzTmJ5keURaY56AsGXguzveY_nxuGbDU_CZTuqkf6eoJRDuVCv4-
From: David Brownell <david-b@pacbell.net>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] fix "&& 0x03" obvious typo in net1080
Date: Mon, 20 Nov 2006 18:52:19 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20061119143301.GA2633@1wt.eu>
In-Reply-To: <20061119143301.GA2633@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201852.20407.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 November 2006 6:33 am, Willy Tarreau wrote:
> Hi David,
> 
> I found this bug while grepping for "&& 0x" in drivers.
> Care to forward upstream ?

I thought this already _was_ upstream ... Greg?


> Regards,
> Willy
> 
> >From e9b19b98763726db99237ccfea907cf88d3572ac Mon Sep 17 00:00:00 2001
> From: Willy Tarreau <w@1wt.eu>
> Date: Sun, 19 Nov 2006 15:30:11 +0100
> Subject: [PATCH] fix "&& 0x03" obvious typo in net1080
> 
> Another obvious occurrence of this typo.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  drivers/usb/net/net1080.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/net/net1080.c b/drivers/usb/net/net1080.c
> index ce00de8..a774105 100644
> --- a/drivers/usb/net/net1080.c
> +++ b/drivers/usb/net/net1080.c
> @@ -237,12 +237,12 @@ #define	STATUS_PORT_A		(1 << 15)
>  #define	STATUS_CONN_OTHER	(1 << 14)
>  #define	STATUS_SUSPEND_OTHER	(1 << 13)
>  #define	STATUS_MAILBOX_OTHER	(1 << 12)
> -#define	STATUS_PACKETS_OTHER(n)	(((n) >> 8) && 0x03)
> +#define	STATUS_PACKETS_OTHER(n)	(((n) >> 8) & 0x03)
>  
>  #define	STATUS_CONN_THIS	(1 << 6)
>  #define	STATUS_SUSPEND_THIS	(1 << 5)
>  #define	STATUS_MAILBOX_THIS	(1 << 4)
> -#define	STATUS_PACKETS_THIS(n)	(((n) >> 0) && 0x03)
> +#define	STATUS_PACKETS_THIS(n)	(((n) >> 0) & 0x03)
>  
>  #define	STATUS_UNSPEC_MASK	0x0c8c
>  #define	STATUS_NOISE_MASK 	((u16)~(0x0303|STATUS_UNSPEC_MASK))
> -- 
> 1.4.2.4
> 

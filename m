Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUKQQt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUKQQt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUKQQsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:48:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:39660 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262415AbUKQQr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:47:29 -0500
Message-ID: <419B7D9B.9050302@osdl.org>
Date: Wed, 17 Nov 2004 08:34:35 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hirokazu Takata <takata@linux-m32r.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc2-bk1] media: Update drivers/media/video/arv.c
References: <20041117.153201.27776357.takata.hirokazu@renesas.com>
In-Reply-To: <20041117.153201.27776357.takata.hirokazu@renesas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takata wrote:
> Hi,
> 
> Here is a patch to update AR camera device driver.
> Please apply.
> 
> 	* drivers/media/video/arv.c:
> 	- Remove warnings; use module_param() instead of MODULE_PARM(),
>           because MODULE_PARM() is deprecated.
> 	- Fix white-space damages.
> 
> Thanks.
> 
> Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
> ---
> 
>  arv.c |  118 +++++++++++++++++++++++++++++++++---------------------------------
>  1 files changed, 59 insertions(+), 59 deletions(-)
> 
> 
> diff -ruNp a/drivers/media/video/arv.c b/drivers/media/video/arv.c
> --- a/drivers/media/video/arv.c	2004-11-15 12:17:04.000000000 +0900
> +++ b/drivers/media/video/arv.c	2004-11-17 15:11:17.000000000 +0900
> @@ -127,12 +127,12 @@ static unsigned char	yuv[MAX_AR_FRAME_BY
>  /* module parameters */
>  /* default frequency */
>  #define DEFAULT_FREQ	50	// 50 or 75 (MHz) is available as BCLK
> -static int freq = DEFAULT_FREQ;	/* BCLK: available 50 or 70 (MHz) */
> +static int freq = DEFAULT_FREQ;	/* BCLK: available 50 or 75 (MHz) */
>  static int vga = 0;		/* default mode(0:QVGA mode, other:VGA mode) */
>  static int vga_interlace = 0;	/* 0 is normal mode for, else interlace mode */
> -MODULE_PARM(freq, "i");
> -MODULE_PARM(vga, "i");
> -MODULE_PARM(vga_interlace, "i");
> +module_param(freq, int, 0644);
> +module_param(vga, bool, 0644);
> +module_param(vga_interlace, bool, 0644);

Do you want freq, vga, and vga_interface to be writeable _after_ the
driver is loaded?  (i.e., dynamic)

> -  	for(i=0; i<1000; i++);
> -  	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
> +	for(i=0; i<1000; i++);
> +	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );

That "while( " is still whitespace-damaged.
It should be "while (", with no space before the final ')' also.
similar for several others below here, with "while" or "for".

> -  	/* Trasfer data 1 */
> -  	ar_outl(data1, PLDI2CDATA);
> +	/* Trasfer data 1 */
            Transfer
> +	ar_outl(data1, PLDI2CDATA);

> +	/* Ack wait */
> +	for(i=0; i<1000; i++);
Looks like you need a busy wait or a timed wait here since
the compiler should be (or at least could be) optimizing away
that for loop.
(same for other similar loops below)
Someone else said that a cpu_relax() or barrier() in the for-loop
would also work.

> +	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );

I would combine the delay loop (above) with the while condition loop.

> -  	/* Trasfer data 2 */
> -  	ar_outl(data2, PLDI2CDATA);
> +	/* Trasfer data 2 */
            Transfer
> +	ar_outl(data2, PLDI2CDATA);

> +	if(n==3){
         if (n == 3) {
> +		/* Trasfer data 3 */
                    Transfer
> +		ar_outl(data3, PLDI2CDATA);
>  		while ( ar_inl(ARVCR0) & ARVCR0_VDS );    // wait for VSYNC
>  		while ( !(ar_inl(ARVCR0) & ARVCR0_VDS) ); // wait for VSYNC
> -	  	ar_outl(PLDI2CSTEN_STEN, PLDI2CSTEN);
> +		ar_outl(PLDI2CSTEN_STEN, PLDI2CSTEN);

> @@ -233,8 +233,8 @@ static inline void wait_for_vertical_syn
>  	int l;
>  
>  	/*
> - 	 * check HCOUNT because we can not check vertual sync.
> - 	 */
> +	 * check HCOUNT because we can not check vertual sync.
                                    cannot        virtual (or
                                                  vertical ?)
> +	 */

-- 
~Randy

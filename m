Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWJOQft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWJOQft (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 12:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWJOQft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 12:35:49 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:1829 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161008AbWJOQfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 12:35:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sTFa/lRxYCgsU41PxmwKXTH1CAPV70/dJWzcBd1WxsFY/1bNnuAXwA3smNR0Bq2x9FbW+xwVZQelvSkrxbOWFA+gjZiGxMICzUvfgmEv7v8e2YXR4SC/EA9R8bbP07PGhJPTEXnU/2tNjFhacXTSgQCdU7KvCFJvj9W3RaC1YTY=
Message-ID: <45326359.4000502@gmail.com>
Date: Sun, 15 Oct 2006 20:35:37 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Florin Malita <fmalita@gmail.com>
CC: Trent Piepho <xyzzy@speakeasy.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [v4l-dvb-maintainer] [PATCH] V4L/DVB: potential leak in dvb-bt8xx
References: <453120EC.8030503@gmail.com>	<Pine.LNX.4.58.0610141720560.13331@shell2.speakeasy.net> <45325B9E.1030808@gmail.com>
In-Reply-To: <45325B9E.1030808@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florin Malita wrote:
> Trent Piepho wrote:
>> I believe that 'state' will be kfree'd by the dst_attach() function if there
>> is a failure.  Not what you would expect, to have it allocated in the bt8xx
>> driver (why do is there??) and freed on error in a different function.
>>   
> 
> Hm, you're right - it is kfreed in dst_attach(). But we're still missing
> the kmalloc result check...
> 
> Signed-off-by: Florin Malita <fmalita@gmail.com>
> ---
> 
>  dvb-bt8xx.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> index fb6c4cc..d22ba4e 100644
> --- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> +++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> @@ -665,6 +665,9 @@ static void frontend_init(struct dvb_bt8
>  	case BTTV_BOARD_TWINHAN_DST:
>  		/*	DST is not a frontend driver !!!		*/
>  		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
> +		if (!state)
> +			break;
> +
>  		/*	Setup the Card					*/
>  		state->config = &dst_config;
>  		state->i2c = card->i2c_adapter;
> 



This patch was applied a few days back

Manu

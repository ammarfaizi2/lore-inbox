Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263272AbVGOLKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbVGOLKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbVGOLIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:08:37 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:902 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261177AbVGOLHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:07:11 -0400
Date: Fri, 15 Jul 2005 13:09:38 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Benton <b3nt@ukonline.co.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Patrick Boettcher <pb@linuxtv.org>, Michael Krufky <mkrufky@m1k.net>
Message-ID: <20050715110938.GB9976@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Andrew Benton <b3nt@ukonline.co.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Patrick Boettcher <pb@linuxtv.org>,
	Michael Krufky <mkrufky@m1k.net>
References: <42D77E37.5010908@ukonline.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D77E37.5010908@ukonline.co.uk>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.232.111
Subject: Re: cx22702.c, 2.6.13-rc3 and a pci Hauppauge Nova-T DVB-T TV card
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Benton wrote:
> My pci TV card (a Hauppauge Nova-T DVB-T) works fine with a 2.6.13-rc2 
> kernel but won't work with a 2.6.13-rc3 by a process of elimination I've 
> found that if I reverse this part of the 2.6.13-rc3 patch the card works 
> fine. Please do not include this in the 2.6.13 kernel.

Reversing this patch is not the right fix as it would break
support for the cxusb.c driver. I guess the output_mode needs to
be set for the Hauppauge Nova-T DVB-T (cx88-dvb.c).
cx88-dvb.c is in video4linux CVS, not DVB CVS.

Patrick, can you send a patch for this?

Johannes

> diff --git a/drivers/media/dvb/frontends/cx22702.c 
> b/drivers/media/dvb/frontends/cx22702.c
> --- a/drivers/media/dvb/frontends/cx22702.c
> +++ b/drivers/media/dvb/frontends/cx22702.c
> @@ -76,7 +76,6 @@ static u8 init_tab [] = {
> 	0x49, 0x56,
> 	0x6b, 0x1e,
> 	0xc8, 0x02,
> -	0xf8, 0x02,
> 	0xf9, 0x00,
> 	0xfa, 0x00,
> 	0xfb, 0x00,
> @@ -347,10 +346,11 @@ static int cx22702_init (struct dvb_fron
> 	for (i=0; i<sizeof(init_tab); i+=2)
> 		cx22702_writereg (state, init_tab[i], init_tab[i+1]);
> 
> +	cx22702_writereg (state, 0xf8, (state->config->output_mode << 1) & 0x02);
> 
> 	/* init PLL */
> 	if (state->config->pll_init) {
> -	        cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) &0xfe);
> +		cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) & 0xfe);
> 		state->config->pll_init(fe);
> 		cx22702_writereg (state, 0x0D, cx22702_readreg(state,0x0D) | 1);
> 	}

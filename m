Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbVKDFCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbVKDFCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbVKDFCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:02:25 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:10351 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1161063AbVKDFCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:02:24 -0500
Message-ID: <436AEB70.3060900@m1k.net>
Date: Fri, 04 Nov 2005 00:02:40 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, linux-dvb-maintainer@linuxtv.org,
       Kirk Lapray <kirk.lapray@gmail.com>
Subject: Re: [PATCH 3/3] dvb: nxt200x: Add function for nxt200x to change
 pll input
References: <436AEADB.9080802@m1k.net>
In-Reply-To: <436AEADB.9080802@m1k.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky wrote:

>From: Kirk Lapray <kirk.lapray@gmail.com>
>
>- Added function for nxt200x to change pll input
>- For VSB set to input 0, for QAM set to input 1
>- will only be set for cards that have set_pll_input defined
>
>Signed-off-by: Kirk Lapray <kirk.lapray@gmail.com>
>Signed-off-by: Michael Krufky <mkrufky@m1k.net>
>
> drivers/media/dvb/frontends/nxt200x.c |    9 +++++++--
> drivers/media/dvb/frontends/nxt200x.h |    3 +++
> 2 files changed, 10 insertions(+), 2 deletions(-)
>
>--- linux-2.6.14-git5.orig/drivers/media/dvb/frontends/nxt200x.c
>+++ linux-2.6.14-git5/drivers/media/dvb/frontends/nxt200x.c
>@@ -556,13 +556,18 @@ static int nxt200x_setup_frontend_parame
> 			if (state->config->set_ts_params)
> 				state->config->set_ts_params(fe, 1);
> 
>-			/* set to use cable input */
>-			buf[3] |= 0x08;
>+			/* set input */
>+			if (state->config->set_pll_input)
>+				state->config->set_pll_input(buf, 1);
> 			break;
> 		case VSB_8:
> 			/* Set non-punctured clock for VSB */
> 			if (state->config->set_ts_params)
> 				state->config->set_ts_params(fe, 0);
>+
>+			/* set input */
>+			if (state->config->set_pll_input)
>+				state->config->set_pll_input(buf, 0);
> 			break;
> 		default:
> 			return -EINVAL;
>--- linux-2.6.14-git5.orig/drivers/media/dvb/frontends/nxt200x.h
>+++ linux-2.6.14-git5/drivers/media/dvb/frontends/nxt200x.h
>@@ -42,6 +42,9 @@ struct nxt200x_config
> 	u8 pll_address;
> 	struct dvb_pll_desc *pll_desc;
> 
>+	/* used to set pll input */
>+	int (*set_pll_input)(u8* buf, int input);
>+
> 	/* need to set device param for start_dma */
> 	int (*set_ts_params)(struct dvb_frontend* fe, int is_punctured);
> };
>
Before anybody says it, I am aware of the whitespace issue right here.  
It is all over dvb-kernel, and we will be fixing this all at once, in a 
later patch.

Thank you,

Michael Krufky

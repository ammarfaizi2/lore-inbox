Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTDHT3H (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTDHT3H (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:29:07 -0400
Received: from ns.suse.de ([213.95.15.193]:17164 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261605AbTDHT3G (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:29:06 -0400
To: Michael Buesch <freesoftwaredeveloper@web.de>
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-2?q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
Subject: Re: [2.5.67] gen_rtc compile error
X-Yow: I want a VEGETARIAN BURRITO to go..  with EXTRA MSG!!
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 08 Apr 2003 21:40:43 +0200
In-Reply-To: <200304082130.07080.freesoftwaredeveloper@web.de> (Michael
 Buesch's message of "Tue, 8 Apr 2003 21:30:07 +0200")
Message-ID: <jek7e4ixqc.fsf@sykes.suse.de>
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) Emacs/21.3.50 (gnu/linux)
References: <Pine.LNX.4.51L.0304082033140.20726@piorun.ds.pg.gda.pl>
	<200304082120.39576.freesoftwaredeveloper@web.de>
	<200304082130.07080.freesoftwaredeveloper@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <freesoftwaredeveloper@web.de> writes:

|> Correcting my patch: ;)

Still not right.

|> --- drivers/char/genrtc.c.orig	2003-04-08 21:15:52.000000000 +0200
|> +++ drivers/char/genrtc.c	2003-04-08 21:28:43.000000000 +0200
|> @@ -486,16 +486,21 @@
|>  		     "update_IRQ\t: %s\n"
|>  		     "periodic_IRQ\t: %s\n"
|>  		     "periodic_freq\t: %ld\n"
|> -		     "batt_status\t: %s\n",
|> -		     (flags & RTC_DST_EN) ? "yes" : "no",
|> +#ifdef RTC_BATT_BAD
|> +		     "batt_status\t: %s\n"
|> +#endif
|> +		     ,(flags & RTC_DST_EN) ? "yes" : "no",
|>  		     (flags & RTC_DM_BINARY) ? "no" : "yes",
|>  		     (flags & RTC_24H) ? "yes" : "no",
|>  		     (flags & RTC_SQWE) ? "yes" : "no",
|>  		     (flags & RTC_AIE) ? "yes" : "no",
|>  		     irq_active ? "yes" : "no",
|>  		     (flags & RTC_PIE) ? "yes" : "no",
|> -		     0L /* freq */,
|> -		     (flags & RTC_BATT_BAD) ? "bad" : "okay");
|> +		     0L /* freq */
|> +#ifdef RTC_BATT_BAD
|> +		     ,(flags & RTC_BATT_BAD) ? "bad" : "okay")
|> +#endif
|> +		     ;

Lacks a close paren if !RTC_BATT_BAD.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

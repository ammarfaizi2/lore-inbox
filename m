Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278297AbRKAIDy>; Thu, 1 Nov 2001 03:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278287AbRKAIDp>; Thu, 1 Nov 2001 03:03:45 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:23312 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S278286AbRKAIDY>;
	Thu, 1 Nov 2001 03:03:24 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Date: Thu, 1 Nov 2001 09:02:44 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Patch] Re: Nasty suprise with uptime
CC: <linux-kernel@vger.kernel.org>, J Sloan <jjs@lexus.com>,
        adilger@turbolabs.com
X-mailer: Pegasus Mail v3.40
Message-ID: <7EA9080566E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Nov 01 at 1:52, Tim Schmielau wrote:

> +   static unsigned long jiffies_hi = 0;
> +   static unsigned long jiffies_last = INITIAL_JIFFIES;
> +   unsigned long jiffies_tmp;
> +
> +   jiffies_tmp = jiffies;   /* avoid races */
> +   if (jiffies_tmp < jiffies_last)   /* We have a wrap */
> +       jiffies_hi++;
> +   jiffies_last = jiffies_tmp;

There is very small race - if two processes will call get_jiffies64()
at same time, they can both happen to test jiffies_tmp < jiffies_last
with old jiffies_last - incrementing jiffies_hi twice :-( This race
window is only few microseconds every 497 days, but if we want
correct kernel... 
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

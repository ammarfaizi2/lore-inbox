Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265414AbUEUG7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265414AbUEUG7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 02:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265416AbUEUG7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 02:59:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27102 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265414AbUEUG7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 02:59:14 -0400
Date: Fri, 21 May 2004 09:00:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: adi@hexapodia.org, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: overlaping printk
Message-ID: <20040521070059.GA2665@elte.hu>
References: <1XBEP-Mc-49@gated-at.bofh.it> <1XBXw-13D-3@gated-at.bofh.it> <1XWpp-zy-9@gated-at.bofh.it> <m3lljnnoa0.fsf@averell.firstfloor.org> <20040520151939.GA3562@elte.hu> <20040520155323.GA4750@elte.hu> <20040520161901.GD13601@hexapodia.org> <20040520185745.GA7706@elte.hu> <20040520161143.5677e9b7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520161143.5677e9b7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > i've attached a new patch that does what Andi suggested too - 
> > timestamping of the oopses. This way we will zap no sooner than 10 
> > seconds after the first oops.
> 
> I think that will do the wrong thing between 23 and 47 days uptime
> because time_after() will return an incorrect answer.
> 
> How's this look?

> +	static unsigned long oops_timestamp;
> +
> +	if (time_after_eq(jiffies, oops_timestamp) &&
> +			!time_after(jiffies, oops_timestamp + 30*HZ))
>  		return;
> +

looks good to me!

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVIFQWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVIFQWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 12:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVIFQWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 12:22:30 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:38627 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750738AbVIFQWa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 12:22:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dMsRChoz+43Bp1HFQ9JuDWwEM+YhM0X5ubnQkH94FJzy+wyjAITJz8Jm5/XBBX0ROKnLYX/My38zCc26eWy42y092mBvxnEc+ycdufXyPYk0xvf/AIa7gUwBRK6dUBSMuHblhQC2HGJA4l5R/bC5UilRel2YKUdSyx/4oBiQ49I=
Message-ID: <29495f1d05090609223a588e30@mail.gmail.com>
Date: Tue, 6 Sep 2005 09:22:27 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [-mm patch 5/5] SharpSL: Add new ARM PXA machines Spitz and Borzoi with partial Akita Support
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <1126007632.8338.130.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1126007632.8338.130.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/05, Richard Purdie <rpurdie@rpsys.net> wrote:
> Add the platform support code for two new Sharp Zaurus Models, Spitz
> (SL-C3000) and Borzoi (SL-C3100).
> 
> This patch also adds most of the foundations for Akita (SL-C1000)
> Support. The missing link for Akita is the driver for its I2C io
> expander. Once this has been finished, the missing Kconfig option and
> machine declaration can easily be added to this code.

<snip>
 
===================================================================
> --- /dev/null   1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.13/arch/arm/mach-pxa/spitz.c      2005-09-06 00:18:59.000000000 +0100
> +/*
> + * MMC/SD Device
> + *
> + * The card detect interrupt isn't debounced so we delay it by HZ/4
> + * to give the card a chance to fully insert/eject.
> + */

<snip>

> +static irqreturn_t spitz_mmc_detect_int(int irq, void *devid, struct pt_regs *regs)
> +{
> +       mmc_detect.devid=devid;
> +       mod_timer(&mmc_detect.detect_timer, jiffies + HZ/4);

Can this be:

mod_timer(&mmc_detect.detect_timer, jiffies + msecs_to_jiffies(250));

?

Thanks,
Nish

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbUBOIG4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 03:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbUBOIG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 03:06:56 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:26752 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264339AbUBOIGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 03:06:48 -0500
Date: Sun, 15 Feb 2004 09:06:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Simon Gate <simon@noir.se>, linux-kernel@vger.kernel.org
Subject: Re: psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
Message-ID: <20040215080647.GB314@ucw.cz>
References: <20040214224348.67102cfd.simon@noir.se> <200402142259.34836.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402142259.34836.mbuesch@freenet.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 10:59:26PM +0100, Michael Buesch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Saturday 14 February 2004 22:43, you wrote:
> > Changed from kernel 2.6.1 to 2.6.2 an get this error in dmesg
> > 
> > psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
> > 
> > My mouse goes crazy for a few secs and then returns to normal for a while. Is this a 2.6.2 problem or is this is something old?
> 
> here's the fix:

... no, that's a fix for a different bug. Actually, without this fix it
works more or less OK.

> - --- linux-2.6.3-rc2/drivers/input/serio/i8042.c.orig	2004-02-10 21:33:21.000000000 +0100
> +++ linux-2.6.3-rc2/drivers/input/serio/i8042.c	2004-02-10 21:37:03.000000000 +0100
> @@ -379,6 +379,8 @@
>  	unsigned int dfl;
>  	int ret;
>  
> +	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
> +
>  	spin_lock_irqsave(&i8042_lock, flags);
>  	str = i8042_read_status();
>  	if (str & I8042_STR_OBF)
> @@ -433,7 +435,6 @@
>  irq_ret:
>  	ret = 1;
>  out:
> - -	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
>  	return IRQ_RETVAL(ret);
>  }

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

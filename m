Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWCQEUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWCQEUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWCQEUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:20:22 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:18831 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S1751293AbWCQEUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:20:21 -0500
Date: Thu, 16 Mar 2006 23:20:19 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] sis96x compiled in by error: delay of one minute at boot
Message-ID: <20060317042019.GC3446@jupiter.solarsys.private>
References: <3ZH07HE0.1142498811.4526410.khali@localhost> <20060316105332.46898.qmail@web26913.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316105332.46898.qmail@web26913.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Etienne:

> >Mark M. Hoffman wrote:
> >Lots of drivers printk messages when they load - IMO it's useful info.
> >E.g. how else could Etienne discover that he accidentally built a kernel
> >with dozens of i2c bus drivers (and probably all of the hwmon drivers)
> >built-in by accident?

* Etienne Lorrain <etienne_lorrain@yahoo.fr> [2006-03-16 11:53:32 +0100]:
>  I did not built with all hwmon drivers because I could determine what I
>  had on my mainboard.

Really?  If you don't have all the hwmon drivers built in, then I'm not
sure how the i2c subsystem could take so long to init.  Can we see the
entire kernel config please?

> For me, because the kernel say it enters the I2C
>  system by the line:
> Mar 13 21:46:48 kernel: [   47.705445] i2c /dev entries driver

That message comes from the (optional) Linux i2c ioctl interface.  It is not
the whole core.

>  It could print a line when finished probing all those I2C drivers by a
>  line like:
> Mar 13 21:46:48 kernel: [   50.705445] i2c driver found: aaa-i2c, bbb-i2c.

Actually, it can't do that.  The i2c core doesn't know anything about
"done probing".  It probes whenever a new master or slave driver is
registered, which could happen at any time.

>  And then I can have a clue on what to include in my monolitic build.
>  I do not care about such timeout on _one_ build, as long as I know what
>  to do for next build. Another possibility is to print a line when an I2C
>  detection has failed: you know that it has taken quite a lot of time and
>  it should not have been done in the first place (even for a module
>  because this module should not have been inserted).

Why don't you just use the sensors-detect script from the lm-sensors project
to see what hardware you have?  If you don't have a kernel with all of the
i2c-bus drivers built as modules, you could probably just boot knoppix and
run the script from there.

>  It also protect the I2C group from people like me complainning
>  because completely unrelated messages like
> Mar 13 22:12:54 kernel: [   61.997032]  : Detection failed at step 3

That particular message is displayed by accident; it's a bug.  Jean already
ack'ed that.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


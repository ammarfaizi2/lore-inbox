Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbUAJLkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 06:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbUAJLkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 06:40:09 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:2311 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S265105AbUAJLkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 06:40:04 -0500
Date: Sat, 10 Jan 2004 12:41:56 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Ivanovich <ivanovich@menta.net>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
       "Nicolas Nilles" <nnilles@skycop.net>
Subject: Re: Kernel 2.6.0 and i2c-viapro posible Bug
Message-Id: <20040110124156.3b127c86.khali@linux-fr.org>
In-Reply-To: <200401091955.55007.ivanovich@menta.net>
References: <200401091955.55007.ivanovich@menta.net>
Reply-To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I thinks that thgere is  probably a bug in I2c-viapro module,
> > cuz when i load i2c-viapro after loading w82781d, my computer  just
> > put very slow..., i try loading as modules in the kernel or built
> > in, in both cases i have the same problem.
> 
> I have this very same board CUV4X_E and the same problem too (present
> in 2.6.0 and before)
> The workaround i found is to not initialize the chip "modprobe w83781d
> init=0"
> 
> And answering some of your questions, yes, the slowdown is global, not
> only disk and it doesn't gets better if you unload the modules.
> 
> It's fixed in 2.6.1? going to download+compile and see if it works. 

Could be fixed, because limits initialization has been removed from the
w83781d driver. But since there is still some intialization stuff done,
the problem may still be there. Please try and report. The "init=0"
parameter is still there, so your workaround should still work.

If the problem is still present, I'd like you to do more tests. Edit the
driver (drivers/i2c/chips/w83781d.c), look for the "w83781d_init_client"
function. You'll find three blocks that are under a "init" conditional.
I'd like you to disable each of them individually ("if (0) {" should do
the trick) and see each time if the slowdown still occurs, so as to give
us a hint on which command causes the slowdown.

Also, at the moment a slowdown occurs and if you have ACPI support
enabled, could you please check the throttling level (and the frequency,
if that applies to your CPU)? I suspect that the motherboard is
hardwired so as to enable throttling on overheat detection. A faulty
init of the w83781d could trigger such an alarm and enable throttling,
resulting in the slowdown you notice. Well, that's just a wild guess,
but still worth verifying IMHO.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

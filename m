Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbUDGSVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbUDGSSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:18:18 -0400
Received: from bender.bawue.de ([193.7.176.20]:54964 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S264172AbUDGSOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:14:50 -0400
Date: Wed, 7 Apr 2004 20:14:41 +0200
From: Joerg Sommrey <jo@sommrey.de>
Message-Id: <200404071814.i37IEf2o005602@bear.sommrey.de>
To: psavo@iki.fi, Linux kernel mailing list <linux-kernel@vger.kernel.org>
Orig-To: Pasi Savolainen <psavo@iki.fi>
Subject: Re: High CPU temp on Athlon MP w/ recent 2.6 kernels
References: <1I4Ka-10u-5@gated-at.bofh.it> <1I5n5-1A2-41@gated-at.bofh.it> <1I5Gl-1OD-33@gated-at.bofh.it> <1I8kJ-3Z8-1@gated-at.bofh.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel you write:

>At least on A7M266-D lmsensors read thermal sensors very wrong. I
>haven't got time to contact devs with that, but I do know for sure that
>amd76x_pm really does make cooling calls, even in 2.6.5-rc3-mm3
>(There should be /sys/devices/pci0000\:00/0000\:00\:00.0/C2_cnt file,
>which tells how many times has amd76x_pm really made the disconnection call).

lmsensors might be correct here as there is a sample config from Tyan
for my board.  C2_cnt shows that amd76x_pm is indeed working. 
Otherwise I had expected a much higher temperature.

>One issue is that from some kernel version amd76x_pm's idle() is called
>upto 3.5x times more often when there's some audio activity. So in
>effect number of calls to default_idle() jumps from 1100Hz to 3800Hz.
>(this is reproducible with 'rhytmbox' -application, but not with xmms.
>AFAIK my xmms uses OSS emulation and rhytmbox is native alsa.)

>Ahem. Could you actually try:
>echo 3 > /sys/devices/pci0000\:00/0000\:00\:00.0/lazy_idle

Did that.

>This could help gaining 5-8°C. HZ changed from 100 to 1000 in 2.6, so
>amd76x_pm old default doesn't apply overly well here.

Bingo! Currently running 2.6.5-mm1 at 42.0/43.5°C!

>There's some funniness going on with this tunable. It doesn't really
>affect how many times/second we call amd76x_pm.idle(), but rather how
>easily we go into sleep (no sleep if both CPU's aren't idle).
>With lazy_idle at 3 I get bad distortions with bttv card. with 3000 they
>disappear, but so does the thermal throttling :)

>(Sorry for lack of coherence right now)

Wouldn't be a bad idea to document this :-)

Thanks!

-jo
-- 
-rw-r--r--    1 jo       users          80 2004-04-07 19:37 /home/jo/.signature

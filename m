Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWHERnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWHERnh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 13:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422657AbWHERnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 13:43:37 -0400
Received: from serv07.server-center.de ([83.220.153.152]:25811 "EHLO
	serv07.server-center.de") by vger.kernel.org with ESMTP
	id S1422656AbWHERnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 13:43:37 -0400
Message-ID: <44D4D8B0.5010103@mycable.de>
Date: Sat, 05 Aug 2006 19:43:12 +0200
From: Alexander Bigga <ab@mycable.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC: david-b@pacbell.net, mgreer@mvista.com, a.zummo@towertech.it,
       linux-kernel@vger.kernel.org
Subject: Re: RTC: add RTC class interface to m41t00 driver
References: <200608041933.39930.david-b@pacbell.net> <20060806.012924.96685417.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060806.012924.96685417.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atsushi,
Hi David,

I've seen very late that the rtc-ds1307.c driver supports the quite 
simple m41t00 as well. As Mark's m41t00.c claimed to support even the 
m41t81 and the m41st85, I startet at this point.

First, I sent my approach to Mark (m41t00.c), Alessandro (rtc-subsytem) 
and Jean (i2c-subsystem) to discuss the strategy. And if I understood 
them right, they found the idea good, to move the i2c/chips/m41t00.h to 
an rtc/rtc-m41txx.c driver, as this should be the general place for such 
rtc-drivers.

As Atsushi has done almost the same work, I postet my version on friday 
to pretend the next person to do this job and to start the discussion, 
how to get to a suitable version for all - including Mark with his 
arch/ppc/platforms/katana.c boards.

I confirm, that the rtc-ds1307.c driver works with m41t00. But the 
m41t8x or m41st8x differs a lot from the m41t00 (HT bit, ST bit, SQW 
freq - like Atsushi wrote it already).


Atsushi Nemoto wrote:
> 2. As m41t00_chip_info_tbl[] in m41t00 driver shows, M41T81 and M41T85
>    have different register layout.
>   

The register layout seems to depend on the watchdog and alarm 
functionality.
The features differs from chip to chip, that's why I intodruced a 
"features"-field in struct m41txx_chip_info.

> 3. It lacks some features (ST bit, HT bit, SQW freq.) in m41t00
>    driver, though I personally does not need these features.
>   

You need at least to clear the Stop Bit (ST) and the Halt Update Bit 
(HT) unless your m41t8x will always report the time of the last power 
fail and not the current time.

For me there is still the open question, if the workqueue-part and the 
exported symbols (m41t00_get_rtc_time, ) should stay or not. I don't 
need it and Atsushi seems to share my opinion. But...?

On monday, I can continue work on it.


Alexander

-- 
Alexander Bigga		Tel: +49 4873 90 10 866
mycable GmbH		Fax: +49 4873 90 19 76
Boeker Stieg 43
D-24613 Aukrug		eMail: ab@mycable.de



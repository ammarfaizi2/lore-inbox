Return-Path: <linux-kernel-owner+w=401wt.eu-S932146AbWLLIu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWLLIu5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 03:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWLLIu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 03:50:57 -0500
Received: from smtp.nokia.com ([131.228.20.171]:27805 "EHLO
	mgw-ext12.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbWLLIu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 03:50:56 -0500
Message-ID: <457E6AC1.3040303@movial.fi>
Date: Tue, 12 Dec 2006 10:39:29 +0200
From: Riku Voipio <riku.voipio@movial.fi>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: David Brownell <david-b@pacbell.net>, rtc-linux@googlegroups.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>, i2c@lm-sensors.org,
       buytenh@wantstofly.org, peter.milne@d-tacq.com
Subject: Re: [patch 2.6.19-git] rts-rs5c372 updates: more chips, alarm, 12hr
 mode, etc
References: <200612081859.42995.david-b@pacbell.net>	 <42002.80.222.56.248.1165818454.squirrel@webmail.movial.fi>	 <200612111155.09435.david-b@pacbell.net>	 <42003.80.222.56.248.1165875783.squirrel@webmail.movial.fi> <e9c3a7c20612111533o75683c2j30dbf440696932a6@mail.gmail.com>
In-Reply-To: <e9c3a7c20612111533o75683c2j30dbf440696932a6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2006 08:40:43.0264 (UTC) FILETIME=[35DCC000:01C71DC9]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Executive summary for the new in CC list: Is it possible that i2c-iop3xx 
driver in current mainline
Linux is buggy regarding repeated start conditions?

Dan Williams wrote:
> According to the latest specification update
> (http://www.intel.com/design/iio/specupdt/27351910.pdf) there are no
> known issues with the i2c.  I looked through the thread and did not
> see what board you are using, can you send those details?
We are using Thecus n2100, which has a IOP 80219. The vendor
itself patched iq31244 board file, so presumably it's very similar.

http://www.debonaras.org/wiki/Info/ThecusN2100Internals

Any more specific information you want?
>
> I have not dealt with the i2c-iop3xx driver in the past. Have you
> tried contacting the last person to make functional changes to the
> driver?
Well, now we have :)

 > Hi Riku, this is the first message I have received.

This what I sent then:

-snip-
We have an Ricoh 5c372 RTC [1] which uses "repeated start" for
internal register access. On a ixp-4xx device (Synology DS101),
the mainline linux driver suposedly worked fine. On our device,
a thecus n2100 with IOP 80219, the driver almost works.

See page 31 on the datasheet[1] for example read transfer.

After some debugging, it seems the RTC is ignoring the internal
address setting request. On iop, we allways get the contents of
beginning from internal register 0xF, which is the default internal
address it sets after a stop condition. I'm not equipped with a scope,
so I don't see what's happening on the wire..

I have a workaround for this specific case, but I don't like
it, and this could be problem with other chips as well.
-snip-

Since then I learned the same rtc is in use with Kuro Boxes, which
use a freescale ppc soc. There both mainline driver and my patched
driver works fine.

[1] http://www.ricoh.com/LSI/product_rtc/2wire/5c372/5c372a-e.pdf
[2] 
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;hb=HEAD;f=drivers/rtc/rtc-rs5c372.c



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284599AbRLUOxI>; Fri, 21 Dec 2001 09:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284596AbRLUOw7>; Fri, 21 Dec 2001 09:52:59 -0500
Received: from olinz-dsl-1316.utaonline.at ([212.152.239.38]:43758 "EHLO
	falke.mail") by vger.kernel.org with ESMTP id <S284587AbRLUOwr>;
	Fri, 21 Dec 2001 09:52:47 -0500
Message-ID: <3C2349C8.1DF70E5F@falke.mail>
Date: Fri, 21 Dec 2001 15:40:08 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: @Linus, Marcello, (Alan?) (regards sisfb)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 10.0.0.13
X-Return-Path: tw@webit.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, as you might know, the sisfb driver did not work correctly on
systems with SiS630 and LCD panels, i.e laptops. The problem was the
type of video bridge used, which is LVDS in most cases.

The current driver contained in the kernel can't even work in theory, 
because 

1) the tables that should have contained necessary data for refresh and
timing were empty, and

2) this data depends on the type of LCD panels attached and is not the
same on all machines.

So, the whole theory with this driver is a failure.

I therefore re-wrote (and commented) the sisfb driver to read out the
BIOS data, instead of its very own tables. On non-SiS630 or non-LVDS
systems, the old code is used.

>From the feedback I got, I know that the driver is working in about 50%
of the SiS630-LVDS-machines out there, depending on what revision of the
SiS630 and LCD panel being used. This is 50% more than before!

The driver has been tested on systems without a video bridge as well
(ie. desktop machines) and it works there as well. This means I didn't
break it for other configurations.

The dark side: The driver is - when used on SiS630 and LVDS - not
LinuxBIOS-capable (because it depends on data stored in the SiS-BIOS)

Are you willing to include the new driver in the kernel?

It's available here: http://members.aon.at/~twinisch/sisfb.tar.gz

I have not made a patch, because this patch would be about as twice as
huge than the whole code. But if you insist, I could make a patch as
well. The code is based on 2.4.16. AFAIK there were no changes to sisfb
up to current 17-rc2. The archive is to be extracted over the existing
code while in /usr/src/linux/drivers/video/sis/

Thomas

-- 
Thomas Winischhofer
Vienna/Austria                  Check it out:
mailto:tw@webit.com              http://www.webit.com/tw


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290284AbSBKT7M>; Mon, 11 Feb 2002 14:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290285AbSBKT6x>; Mon, 11 Feb 2002 14:58:53 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:31977 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S290284AbSBKT6d>; Mon, 11 Feb 2002 14:58:33 -0500
Message-ID: <3C682264.7060707@nyc.rr.com>
Date: Mon, 11 Feb 2002 14:58:28 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Linux 2.5.4 Sound Driver Problem
In-Reply-To: <fa.c0t1afv.1f02hrj@ifi.uio.no> <fa.jvah72v.1h34cqd@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Try to do this. Open drivers/sound/Config.in, and find YMFPCI
> tristate, then delete $CONFIG_SOUND_OSS from that line.
> Edit .config, and remove CONFIG_SOUND_OSS. Rerun make oldconfig,
> when prompted for CONFIG_SOUND_OSS, say N. This should work.

if [ "$CONFIG_SOUND_OSS" = "y" -o "$CONFIG_SOUND_OSS" = "m" ]; then
    bool '      Verbose initialisation' CONFIG_SOUND_TRACEINIT
    bool '      Persistent DMA buffers' CONFIG_SOUND_DMAP

The YMFPCI option was in the body of the above if statement, so I had
to move it out of there to be able to enable it without enabling 
CONFIG_SOUND_OSS.  I hope this is what you meant.

> 
> I use monolithic kernels on 2.4, but on 2.5 it is officially
> discouraged, so I gave up on it.

To what granularity?  I use the hardware as a rule of thumb: if the
the hardware supported is fixed, then I put it in the kernel.
Should I compile everything as modules?

However, I did hear something about everything being a module in 2.6
because the kernel will eventually use initramfs or something...

Anyway, this is a different thread.  But I would like to hear your rule 
of thumb for when you compile things as a module...


> I do not see ANYTHING in 2.5.4 Makefiles that depended on
> CONFIG_SOUND_GAMEPORT. This option only works to restric
> some configurations choices, but it does not control any
> compilations. Seems like a deadwood to me. Just kill it too.

I kill it but make oldconfig enables it right back :).
I'll look through Config.in in a bit.


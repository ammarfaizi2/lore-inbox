Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131344AbRDPMMk>; Mon, 16 Apr 2001 08:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131348AbRDPMMa>; Mon, 16 Apr 2001 08:12:30 -0400
Received: from mail001.syd.optusnet.com.au ([203.2.75.244]:38272 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S131344AbRDPMMV>; Mon, 16 Apr 2001 08:12:21 -0400
Message-ID: <3ADAE8A4.87DFBF92@dingoblue.net.au>
Date: Mon, 16 Apr 2001 22:42:12 +1000
From: monkeyiq@dingoblue.net.au
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: idebus=xx on a ISA only 486
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    This may be harmless but I noticed a warning msg when I went to
2.4.3 on a ISA only 486 mobo.

Feb 18 18:01:41 speedy kernel: ide: Assuming 50MHz system bus speed for
PIO modes; override with idebus=xx

My first thought was to drop idebus to 8Mhz (I think this is the
ISA speed ?),
but using that
Feb 18 18:01:41 speedy kernel: Kernel command line: auto BOOT_IMAGE=243
ro root=301 BOOT_FILE=/boot/vmlinuz-2.4.3 idebus=8
Feb 18 18:01:41 speedy kernel: ide_setup: idebus=8 -- BAD BUS SPEED!
Expected value from 20 to 66

and then a quick grep/poke in the src gave this

./drivers/ide/ide.c
Version 5.50         allow values as small as 20 for idebus=

and at line 350 it seems that its pci or nothing for the bus speed.

the only deterministic problem (so far that I can directly attribute to
that kernel) with the
2.4.3 booted kernel is that ssh2 locks up for random amounts of time at
randomish intervals.

I can't seem to dig up other info on this problem, I am sorry if this is
the wrong place
to ask. If there are better places to be looking for this data I am
happy to RTFM there.

Now trying 2.4.3-ac6 to see what happens there.



--
---------------------------------------------------
It's the question, http://witme.sourceforge.net
If you think education is expensive, try ignorance.
                -- Derek Bok, president of Harvard




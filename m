Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273721AbRIQWVx>; Mon, 17 Sep 2001 18:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273720AbRIQWVo>; Mon, 17 Sep 2001 18:21:44 -0400
Received: from hermes.domdv.de ([193.102.202.1]:60430 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S273721AbRIQWVe>;
	Mon, 17 Sep 2001 18:21:34 -0400
Message-ID: <XFMail.20010918002057.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.33.0109161454090.3392-100000@penguin.transmeta.com>
Date: Tue, 18 Sep 2001 00:20:57 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: RE: Linux-2.4.10-pre10
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The new (simpler) code should be a lot less random. But it will probably
> need a few tweaks. It would be very interesting to hear about specific
> loads that show problems (or loads that are good, of course).
> 
OK, comparing 2.4.10pre4 to 2.4.10pre10 there's good news and bad news:

1. Good News
------------

Please don't wonder about memory size, this is a laptop with 32MB on board and
two 128MB modules.

/proc/meminfo on 2.4.10pre4 after boot and then after running aide:

        total:    used:    free:  shared: buffers:  cached:
Mem:  292478976 149729280 142749696        0 14004224 78467072
Swap: 1071087616        0 1071087616
MemTotal:       285624 kB
MemFree:        139404 kB
MemShared:           0 kB
Buffers:         13676 kB
Cached:          76628 kB
SwapCached:          0 kB
Active:           7672 kB
Inact_dirty:     82632 kB
Inact_clean:         0 kB
Inact_target:     1140 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       285624 kB
LowFree:        139404 kB
SwapTotal:     1045984 kB
SwapFree:      1045984 kB

        total:    used:    free:  shared: buffers:  cached:
Mem:  292478976 280997888 11481088        0 25620480 224792576
Swap: 1071087616 35487744 1035599872
MemTotal:       285624 kB
MemFree:         11212 kB
MemShared:           0 kB
Buffers:         25020 kB
Cached:         208300 kB
SwapCached:      11224 kB
Active:         163008 kB
Inact_dirty:     80640 kB
Inact_clean:       896 kB
Inact_target:     6704 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       285624 kB
LowFree:         11212 kB
SwapTotal:     1045984 kB
SwapFree:      1011328 kB


/proc/meminfo on 2.4.10pre10 after boot and then after running aide:

        total:    used:    free:  shared: buffers:  cached:
Mem:  292581376 172519424 120061952        0 36872192 78290944
Swap: 1071087616        0 1071087616
MemTotal:       285724 kB
MemFree:        117248 kB
MemShared:           0 kB
Buffers:         36008 kB
Cached:          76456 kB
SwapCached:          0 kB
Active:          21104 kB
Inact_dirty:     91360 kB
Inact_clean:         0 kB
Inact_target:     1152 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       285724 kB
LowFree:        117248 kB
SwapTotal:     1045984 kB
SwapFree:      1045984 kB

        total:    used:    free:  shared: buffers:  cached:
Mem:  292581376 280190976 12390400        0 20652032 194973696
Swap: 1071087616        0 1071087616
MemTotal:       285724 kB
MemFree:         12100 kB
MemShared:           0 kB
Buffers:         20168 kB
Cached:         190404 kB
SwapCached:          0 kB
Active:          48096 kB
Inact_dirty:    160776 kB
Inact_clean:      1700 kB
Inact_target:     5592 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       285724 kB
LowFree:         12100 kB
SwapTotal:     1045984 kB
SwapFree:      1045984 kB



2. Bad News
-----------

Average time required for aide run:

2.4.10pre4      230 seconds
2.4.10pre10     323 seconds

So an aide run takes additional 93 seconds on pre10 when compared to pre4.

There's an odd behaviour back in 2.4.10pre10 that I remember having noticed last
in 2.4.7:

Any mouse movement causes instant disk activity. This may be initiated by the
fact that I'm using gpm and thus /dev/gpmdata (named pipe) to feed mouse input
to X as I want to have mouse support when switching to console mode (sometimes
cut and paste is really easier using the mouse).

In general (though no measurements) I just can confirm the remark on the list
that pre10 'feels' more sluggish. There seems to be more disk activity when
larger applications are started in general. This fits the reappearance of
the mouse problem stated above.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129788AbQJZRDe>; Thu, 26 Oct 2000 13:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129809AbQJZRDZ>; Thu, 26 Oct 2000 13:03:25 -0400
Received: from styx.suse.cz ([195.70.145.226]:36337 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129788AbQJZRDO>;
	Thu, 26 Oct 2000 13:03:14 -0400
Date: Thu, 26 Oct 2000 19:03:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Yoann Vandoorselaere <yoann@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
Message-ID: <20001026190309.A372@suse.cz>
In-Reply-To: <m3d7gnd31m.fsf@test1.mandrakesoft.com> <Pine.LNX.3.95.1001026115039.12337A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1001026115039.12337A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Oct 26, 2000 at 12:04:21PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2000 at 12:04:21PM -0400, Richard B. Johnson wrote:

> ../drivers/block/ide.c, line 162, on version 2.2.17 does bad things
> to the timer. It writes 0 to the control-word for timer 0. This
> does the following:
> 
> o	Selects timer 0.
> o	Latches the timer.
> o	Selects mode 0.
> o	Programs it to a 16 bit counter.
> 
> The result is a latched (stopped) counter. Bits 5 and 4 should have been
> selected. Then you read bits 0-7 from 0x40, followed by bits 8-15  from
> the same port.
> 
> Also, there is no spin-lock protecting access to these ports. If anybody
> else is mucking with the timer, all bets are off.
 
Well, at least on 2.4.0-test9, the above timing code is #ifed to
DISK_RECOVERY_TIME > 0, which in turn is #defined to 0 in
include/linux/ide.h.

So this is not our problem here. Anyway I guess it's time to hunt for
i8259 accesses in the kernel that lack the necessary spinlock, even when
they're not probably the cause of the problem we see here.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

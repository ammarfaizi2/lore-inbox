Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131078AbQLQVZP>; Sun, 17 Dec 2000 16:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131856AbQLQVZF>; Sun, 17 Dec 2000 16:25:05 -0500
Received: from hera.cwi.nl ([192.16.191.1]:54498 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131078AbQLQVYw>;
	Sun, 17 Dec 2000 16:24:52 -0500
Date: Sun, 17 Dec 2000 21:54:18 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200012172054.VAA173604.aeb@aak.cwi.nl>
To: linux-kernel@vger.kernel.org, mdharm-kernel@one-eyed-alien.net
Subject: Re: set_rtc_mmss: can't update from 0 to 59
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What architecture?
What kernel version?
Are you in fact running xntpd?

> According to the notes in the code, this should work if my RTC
> is less than 15 minutes off... which I can guarantee it is.

Well, since you looked at the source:
For some randomly chosen kernel version and architecture it does

        if (abs(real_minutes - cmos_minutes) < 30) {
		update_cmos()
	} else {
		printk("set_rtc_mmss: can't update from %d to %d\n",
		       cmos_minutes, real_minutes);
	}

so if your cmos time is 0.001 sec ahead of your system time
then around the hour you'll see
	set_rtc_mmss: can't update from 0 to 59

Of course, messing with the cmos clock at all was a rather bad idea,
but that is a different discussion.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

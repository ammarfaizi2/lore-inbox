Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130025AbRBRS2n>; Sun, 18 Feb 2001 13:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130669AbRBRS2d>; Sun, 18 Feb 2001 13:28:33 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:62469 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130025AbRBRS2X>;
	Sun, 18 Feb 2001 13:28:23 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102181827.VAA26196@ms2.inr.ac.ru>
Subject: Re: 2.2.x: TCP lockups with tcp_timestamps
To: mhp@lightlink.com (Max Parke)
Date: Sun, 18 Feb 2001 21:27:30 +0300 (MSK)
Cc: davem@redhat.com, ak@muc.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10102121837430.15077-100000@mhp.lightlink.com> from "Max Parke" at Feb 12, 1 06:46:27 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Yes.  The 5.6.7.8 machine is connected to the Internet via a Linksys
> "router" that is also performing masquerade.  
>
> I will be very angry if this turns out to be the culprit.

I am afraid it is. It corrupts packets preserving their checksum.


Look:

> Trace taken from 1.2.3.4 machine
...
> 20:29:35.179648 1.2.3.4.379 > 5.6.7.8.1053: P 16468:16528(60) ack 65211 win 31856 <nop,nop,timestamp 3397515 1679644> (DF)

and

> Trace taken from 5.6.7.8 (aka 192.168.1.102) machine
...
> 19:18:26.808820 < 1.2.3.4.379 > 192.168.1.102.1053: P 16468:16528(60) ack 65211 win 31856 <nop,nop,timestamp 3643345 3395672641> (DF)

5.6.7.8 received packet with garbage in timestamp area:

<3643345 3395672641> instead of <3397515 1679644>

And checksum is "corrupted" so that it remains right,
which is impossible to make occasionally.

Alexey

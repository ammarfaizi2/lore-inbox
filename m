Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318124AbSHZOhm>; Mon, 26 Aug 2002 10:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318121AbSHZOhl>; Mon, 26 Aug 2002 10:37:41 -0400
Received: from windsormachine.com ([206.48.122.28]:37130 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S318117AbSHZOhk>; Mon, 26 Aug 2002 10:37:40 -0400
Date: Mon, 26 Aug 2002 10:41:55 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-ppp@vger.kernel.org>
cc: <linux-kernel@vger.kernel.org>, <debian-user@lists.debian.org>
Subject: PPP problems I was having
Message-ID: <Pine.LNX.4.33.0208261036030.10194-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I went out and swapped the PCI 3com Sportster modem with another
spare ISA Sportster I had lying around.  Set it up, same problem of
persist option not working properly.
Looking through the syslog again, I noticed this...

Aug 26 08:42:32 tilburybackup pppd[330]: Connect time 0.9 minutes.
Aug 26 08:42:32 tilburybackup pppd[330]: Sent 87 bytes, received 72 bytes.
Aug 26 08:42:32 tilburybackup pppd[330]: Couldn't release PPP unit: Invalid argument
Aug 26 08:42:33 tilburybackup pppd[330]: Script /etc/ppp/ip-down finished (pid 862), status = 0x1
Aug 26 08:43:27 tilburybackup pppd[330]: Serial connection established.
Aug 26 08:43:27 tilburybackup pppd[330]: using channel 2
Aug 26 08:43:27 tilburybackup pppd[330]: Couldn't create new ppp unit: Inappropriate ioctl for device
Aug 26 08:43:28 tilburybackup pppd[330]: Hangup (SIGHUP)

Furthermore, everytime it tries to reconnect, it increases the channel
count.  As well, this invalid argument on the release PPP unit seems odd.

I did find a way to get around having to wait 6 hours for the ISP to
hangup.  Just pulling the phone cable, letting it time out and attempt to
shut down, and then plugging the cable back in, works.

I finally did a work around:


tilburybackup:/etc/ppp/ip-down.d# cat reset
#!/bin/sh
if [ $PPP_TTY == "/dev/ttyS4" ]; then
        poff chatham
        pon chatham
fi


This fixes it for now(as poff shuts it down cleanly, but pppd's persist is
fubar)

Ideas?

Still running 2.4.19 with pppd 2.4.1

If I get desperate enough, I'll go try 2.2.21 the next time I'm in the
area of this facility, to see if it's pppd 2.4.1, or the 2.4.19 kernel
that's causing it.

Mike


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277728AbRJIOl4>; Tue, 9 Oct 2001 10:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277730AbRJIOlq>; Tue, 9 Oct 2001 10:41:46 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:43716 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S277728AbRJIOlh>; Tue, 9 Oct 2001 10:41:37 -0400
Date: Tue, 9 Oct 2001 10:57:45 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Not getting arp replies?
Message-ID: <Pine.LNX.4.40.0110091001250.114-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to machines rather identical software wise, but rather different in
hardware.  They are both plugged into the same ethernet switch, and have
IPs in the same logical network.

On the physical network there are 10 RAS boxes, they proxy arp for up to
46 IPs, but only when they are active.  They also each have their own IP
that they always answer for.  The RASes and the Linux machines all have
static routes that let them know that all the logical networks are on the
same physical network and that they can talk directly to each other
instead of going through the router.

Some of the RASes can go unused through the night, so their arp entries
will expire on the Linux machines.  This is where it gets strange.  One
Linux machine can instantly discover the MAC address of any of the RASes
upon needing it, the other machine cannot.

For instance on Linux box #1, the working one, I type "ping max6", boom
replies start coming in.  But on the second box the same command just sits
there, and the "arp" command shows max6's MAC address to be
"(incomplete)".

This is where it gets really funky, Linux box #2 can always resolve the
hardware address of maxes 1-5, 9 and 10, just not 6-8.  1-5 are in one
logical network and 6-10 are in a second.  I diffed the configs of 6 and 9
and they only very exactly as I would expect, name, IP, and gateway for
the static routes (which is the IP of the box).

Linux box #1 can always resolve the hardware address of any of the RASes
with no trouble.  Running tcpdump on #1 shows #2 making the arp query,
then running tcpdump on #2 shows the same thing, the "who-has", but never
the "reply".

This is really strange, and I can't figure out for what logical reason
this would be happening.  As I said the hardware between the two machines
is rather different.  I figure the most important thing to note is the one
that works has an eepro100 ethernet adaptor, while the one that is having
the trouble is a tulip.

Thanks,
Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks


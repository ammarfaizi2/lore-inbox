Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266482AbUFUViW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266482AbUFUViW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 17:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUFUViW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 17:38:22 -0400
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:58496 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S266482AbUFUViT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 17:38:19 -0400
Message-ID: <40D75543.3050706@ThinRope.net>
Date: Tue, 22 Jun 2004 06:38:11 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new device support for forcedeth.c second try
References: <C064BF1617D93B4B83714E38C4653A6E0BD11BCF@mail-sc-10.nvidia.com> <40D71CBB.4090009@gmx.net> <40D73040.5010106@ThinRope.net> <40D73BA2.5080703@gmx.net>
In-Reply-To: <40D73BA2.5080703@gmx.net>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Does the driver work for you when a cable is plugged in? Please test
> normal network traffic.

No, definately not :-( I just saw that I can up the iface and assign it addresses, but when I try to use it...

I tried a ping and on the other host (directly connected with a cross cable) I got a lot of:

eth1: bogus packet size: 1774, status=0x21 nxpg=0x66.
eth1: bogus packet size: 1774, status=0x21 nxpg=0x6d.
eth1: bogus packet size: 1774, status=0x21 nxpg=0x74.
...
eth1: bogus packet size: 1774, status=0x21 nxpg=0x78.
eth1: bogus packet size: 1779, status=0x21 nxpg=0x7f.
eth1: bogus packet size: 1779, status=0x21 nxpg=0x52.
eth1: bogus packet size: 1779, status=0x21 nxpg=0x59.
eth1: bogus packet size: 1779, status=0x21 nxpg=0x60.
eth1: bogus packet size: 1779, status=0x21 nxpg=0x67.

The size seems to fluctuate between 1774 and 1779, more like random.

The iteresting thing is that sometimes it just starts and works!
Like in the middle of a ping (or ping -f), or just starting iptraf (and get into promiscuous mode), the best description that fits here is "random"...

Trying with tcpdump on the othe host:
#  tcpdump  -XX -vvv -n -p -i eth1
tcpdump: listening on eth1, link-type EN10MB (Ethernet), capture size 96 bytes
06:34:30.708109 IP truncated-ip - 23 bytes missing! (tos 0x0, ttl  64, id 0, offset 0, flags [DF], length: 84) 192.168.44.20 > 192.168.44.123: icmp 64: echo request seq 1
        0x0000:  0090 fe52 8bab 000c 6ecd ae29 0800 4500  ...R....n..)..E.
        0x0010:  0054 0000 4000 4001 60c9 c0a8 2c14 c0a8  .T..@.@.`...,...
        0x0020:  2c7b 0800 3864 b42c 0001 6054 d740 e2d5  ,{..8d.,..`T.@..
        0x0030:  0600 0809 0a0b 0c0d 0e0f 1011 1213 1415  ................
        0x0040:  1617 1819 1a1b 1c1d 1e1f 20              ...........
06:34:31.707072 IP truncated-ip - 23 bytes missing! (tos 0x0, ttl  64, id 1, offset 0, flags [DF], length: 84) 192.168.44.20 > 192.168.44.123: icmp 64: echo request seq 2
        0x0000:  0090 fe52 8bab 000c 6ecd ae29 0800 4500  ...R....n..)..E.
        0x0010:  0054 0001 4000 4001 60c8 c0a8 2c14 c0a8  .T..@.@.`...,...
        0x0020:  2c7b 0800 a166 b42c 0002 6154 d740 78d2  ,{...f.,..aT.@x.
        0x0030:  0600 0809 0a0b 0c0d 0e0f 1011 1213 1415  ................
        0x0040:  1617 1819 1a1b 1c1d 1e1f 20              ...........

when doing this on the A7X8N-Deluxe:
# ping  -c 2 192.168.44.123

The MSG "23 bytes missing!" is different (saw 28, 29, etc).

arping seems to work OK, so it is the IP that gets shreded here.

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/

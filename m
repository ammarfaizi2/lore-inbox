Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131879AbRAQNkr>; Wed, 17 Jan 2001 08:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132078AbRAQNkh>; Wed, 17 Jan 2001 08:40:37 -0500
Received: from mailframe.cabinet.net ([213.169.1.9]:47631 "HELO
	mailframe.cabinet.net") by vger.kernel.org with SMTP
	id <S131879AbRAQNke>; Wed, 17 Jan 2001 08:40:34 -0500
Date: Wed, 17 Jan 2001 15:40:10 +0200 (EET)
From: Jussi Hamalainen <count@theblah.org>
To: <linux-kernel@vger.kernel.org>
Subject: ipchains blocking port 65535
Message-ID: <Pine.LNX.4.30.0101171530150.20661-100000@shodan.irccrew.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a bug in ipchains. Matching port 65535 seems to
always fail. If I set the chain policy to REJECT or DENY and then
add a rule that accepts TCP to/from ports 0:65535, packets going to
port 65535 will still be caught by the kernel. Is there a fix for
this? It's driving me nuts. The firewall box is a 486 with 3 NICs and
is running kernel 2.2.18 vanilla.

Here is a piece of the kernel log:

Jan 17 15:13:03 galileo kernel: Packet log: forward REJECT eth0
PROTO=6 213.173.130.69:65535 xxx.xxx.xxx.xxx:65535 L=44 S=0x00
I=16815 F=0x00B6 T=56 (#25)
Jan 17 15:15:03 galileo kernel: Packet log: forward REJECT eth0
PROTO=6 213.173.130.69:65535 xxx.xxx.xxx.xxx:65535 L=44 S=0x00
I=19969 F=0x00B6 T=56 (#25)
Jan 17 15:17:03 galileo kernel: Packet log: forward REJECT eth0
PROTO=6 213.173.130.69:65535 xxx.xxx.xxx.xxx:65535 L=44 S=0x00
I=21869 F=0x00B6 T=56 (#25)

And here a piece of my forward chain:

ACCEPT     tcp  ------  anywhere              myhomenet/27
any ->   1024:65535
ACCEPT     udp  ------  anywhere              myhomenet/27
any ->   1024:65535

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.org ]=-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

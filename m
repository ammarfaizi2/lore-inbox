Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292475AbSCDQ0s>; Mon, 4 Mar 2002 11:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292466AbSCDQ0i>; Mon, 4 Mar 2002 11:26:38 -0500
Received: from flaske.stud.ntnu.no ([129.241.56.72]:14772 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S292395AbSCDQ0T>; Mon, 4 Mar 2002 11:26:19 -0500
Date: Mon, 4 Mar 2002 17:26:17 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
        linux-net@vger.kernel.org
Subject: Re: [BETA-0.94] Fifth test release of Tigon3 driver
Message-ID: <20020304172617.B1648@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020304.041252.13772021.davem@redhat.com> <20020304164453.A27587@stud.ntnu.no> <3C83993A.94FE655E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C83993A.94FE655E@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Mar 04, 2002 at 10:56:42AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik:
> And, what MTU are you using?  You may have answered this earlier and I
> forgot :)  If you -are- on a gigabit network, then you [currently] must
> manually enable an MTU of 9000 (jumbo frames).

First mail with MTU 9000, tg3 in both ends:

test8:/usr/src/LMbench/bin/i686-pc-linux-gnu# ./lat_tcp 129.241.56.160
TCP latency using 129.241.56.160: 146.3539 microseconds


However, there seems to be a problem with the bw_tcp-tool, cause it just
hangs, trying to strace it won't gimme me much usefull info about why it
hangs either. (it worked like a charm with 1500 MTUs).

Ok, right now I just tried the nttcp tool (which I used to benchmark this
driver in an earlier posting), it seems like there's a bug with MTU 9000 and
TCP:

[this is UDP, works like a charm]
kiwi:/usr/src# /root/nttcp-1.47/nttcp -t -u -v 129.241.56.161
nttcp-l: nttcp, version 1.47
nttcp-l: Pid=10519
nttcp-l: from 129.241.56.161: "129.241.56.161" (=nttcp-1: Pid=3197,
InetPeer= 1)
nttcp-l: from 129.241.56.161: "129.241.56.161" (=nttcp-1:
Optionline="nttcp@-r@)
nttcp-l: from 129.241.56.161: "129.241.56.161" (=dataport: 5038)
nttcp-l: send window size = 65535
nttcp-l: receive window size = 65535
nttcp-l: buflen=4096, bufcnt=2048, dataport=5038/udp
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-l: transmitted 8388608 bytes
l  8388608    0.07    0.02    993.7049   3355.4432    2051  30369.89
102550.0
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: got EOF
nttcp-1: received 0 bytes
1             0.07    0.00      0.0000      0.0000       1     14.64
100000.0
nttcp-1: exiting

[and this is TCP, doesn't exactly work like a charm]
kiwi:/usr/src# /root/nttcp-1.47/nttcp -t -v 129.241.56.161
nttcp-l: nttcp, version 1.47
nttcp-l: Pid=10520
nttcp-l: from 129.241.56.161: "129.241.56.161" (=nttcp-1: Pid=3198,
InetPeer= 1)
nttcp-l: from 129.241.56.161: "129.241.56.161" (=nttcp-1:
Optionline="nttcp@-r@)
nttcp-l: from 129.241.56.161: "129.241.56.161" (=dataport: 5038)
nttcp-l: send window size = 27900
nttcp-l: receive window size = 87380
nttcp-l: buflen=4096, bufcnt=2048, dataport=5038/tcp
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: accept from 129.241.56.160
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: send window size = 27900
nttcp-1: receive window size = 87380
nttcp-l: try to get outstanding messages from 1 remote clients
nttcp-1: buflen=4096, bufcnt=2048, dataport=5038/tcp

[cause here it hangs]


I can still stop the program with CTRL-C, so I dont' know what it is,
someone enlighten me, please? :)  

-- 
Thomas

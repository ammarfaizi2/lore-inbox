Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSELBMz>; Sat, 11 May 2002 21:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315274AbSELBMy>; Sat, 11 May 2002 21:12:54 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:44214 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S315272AbSELBMx>;
	Sat, 11 May 2002 21:12:53 -0400
Message-ID: <3CDDC194.7000405@candelatech.com>
Date: Sat, 11 May 2002 18:12:52 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-net <linux-net@vger.kernel.org>
Subject: OT:  problem with select() and RH 7.3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appologies for an OT post, but I am hoping someone here will
have an answer.

It appears that the select() call as found in RH 7.3 waits too
long before it returns.  I come to this conclusion because I
was dropping a large number of UDP packets when I allowed the
select timeout to be > 0.   However, if I force the timeout to
be zero in all cases, almost no packets are dropped (but the
packet generator/receiver uses all of the CPU)  My traffic pattern
is 10Mbps send + 10Mbps receive on 4 ports (of a DFE-570tx 4-port
NIC, tulip driver), pkt size of 1200 to 1514.

If I understand select() correctly, it should work equally fast
with a timeout of zero or 10 minutes, as long as the file descriptors
are ready to be read from or written to.

I tried various kernels that I am sure have worked in the past,
all with the same results.  The only thing I can think of is that
somehow glibc or whatever implements select is wierd in RH 7.3
(I'm installing RH 7.2 now to test that hypothesis.)

One interesting observation that sheds a bit of doubt on blaming
glibc is that when the timeout is > 0 (ie I'm dropping packets),
the ethernet driver is not receiving as many packets as the
sender is sending.  It also does not have any substantial amount
of errors of any kind.  The ports are connected via a loopback cable,
and all 4 ports exhibit this behaviour.  With a timeout of zero though,
the send & receive counters are virtually identical.

If anyone has any ideas or suggestions, I'd love to hear them!

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear



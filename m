Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130297AbRBZOep>; Mon, 26 Feb 2001 09:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130375AbRBZObO>; Mon, 26 Feb 2001 09:31:14 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130381AbRBZOak>;
	Mon, 26 Feb 2001 09:30:40 -0500
Message-ID: <20010226092240.23713.qmail@lindy.softhome.net>
To: linux-kernel@vger.kernel.org
cc: roger@kea.grace.cri.nz
Subject: tcp stalls with 2.4 (but not 2.2)
Date: Mon, 26 Feb 2001 02:22:40 -0700
From: Brian Grossman <brian@SoftHome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm seeing stalls sending packets to some clients.  I see this problem
under 2.4 (2.4.1 and 2.4.1ac17) but not under 2.2.17.

My theory is there is an ICMP black hole between my server and some of its
clients.  Is there a tool to pinpoint that black hole if it exists?

Can anyone suggest another cause or a direction for investigation?

Why does this affect 2.4 but not 2.2?

The characteristics I've discovered so far:

        From strace of the server process, each write to the network is
        preceeded by a select on the output fd.  The select waits for a
        long time, after which the write succeeds.

        The packets are received by the client a couple minutes after my
        server sends them.

        The clients I have tested with are win98 and winNT.

        The router for both 2.4 and 2.2 servers is running 2.2.18 with
        ipvs (ipvs-1.0.2-2.2.18).

        That router does not block any ICMP.

        The behavior occurs on the 2.4 machine whether the packets are
        routed directly or are mangled by ipvs.

        I've tried the same machine with both 2.4 and 2.2, as well as
        another machine with just 2.2.  2.2 works.  2.4 doesn't.

        Both of my servers and the router I mentioned have two tulip
        network cards.

        The clients I've tested with are behind a modem through earthlink.
        Another I suspect to have same problem is behind a modem
	through Juno.

        I've tried adjusting both /proc/sys/net/ipv4/route/min_adv_mss and
        /proc/sys/net/ipv4/route/min_pmtu downward.  Do these require an
        ifconfig down/up to take effect?

Thanks for any help anyone can supply.

Brian

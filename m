Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130315AbRBZQLf>; Mon, 26 Feb 2001 11:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRBZQL0>; Mon, 26 Feb 2001 11:11:26 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:44171 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130312AbRBZQLR>; Mon, 26 Feb 2001 11:11:17 -0500
Message-ID: <3A9A8023.7542CBF7@coplanar.net>
Date: Mon, 26 Feb 2001 11:11:16 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Grossman <brian@SoftHome.net>
CC: linux-kernel@vger.kernel.org, roger@kea.grace.cri.nz
Subject: Re: tcp stalls with 2.4 (but not 2.2)
In-Reply-To: <20010226092240.23713.qmail@lindy.softhome.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Grossman wrote:

> I'm seeing stalls sending packets to some clients.  I see this problem
> under 2.4 (2.4.1 and 2.4.1ac17) but not under 2.2.17.

compiled in ECN support? SYNcookies?  try disabling through /proc
tcp or udp? if udp check /proc/net/ipv4/ip_udpdloose or such

>
>
> My theory is there is an ICMP black hole between my server and some of its
> clients.  Is there a tool to pinpoint that black hole if it exists?

ping is your friend.  -s lets you set size of packet. (to
check for fragmentation) use tcpdump to capture
a trace of this or a tcp session.

email trace to me private if you want.

>
>
> Can anyone suggest another cause or a direction for investigation?
>
> Why does this affect 2.4 but not 2.2?
>
> The characteristics I've discovered so far:
>
>         From strace of the server process, each write to the network is
>         preceeded by a select on the output fd.  The select waits for a
>         long time, after which the write succeeds.
>
>         The packets are received by the client a couple minutes after my
>         server sends them.
>
>         The clients I have tested with are win98 and winNT.
>
>         The router for both 2.4 and 2.2 servers is running 2.2.18 with
>         ipvs (ipvs-1.0.2-2.2.18).
>
>         That router does not block any ICMP.
>
>         The behavior occurs on the 2.4 machine whether the packets are
>         routed directly or are mangled by ipvs.
>
>         I've tried the same machine with both 2.4 and 2.2, as well as
>         another machine with just 2.2.  2.2 works.  2.4 doesn't.
>
>         Both of my servers and the router I mentioned have two tulip
>         network cards.
>
>         The clients I've tested with are behind a modem through earthlink.
>         Another I suspect to have same problem is behind a modem
>         through Juno.
>
>         I've tried adjusting both /proc/sys/net/ipv4/route/min_adv_mss and
>         /proc/sys/net/ipv4/route/min_pmtu downward.  Do these require an
>         ifconfig down/up to take effect?
>


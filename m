Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269979AbUICXZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269979AbUICXZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 19:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269980AbUICXZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 19:25:39 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:6003 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S269979AbUICXZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 19:25:21 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: Michael.Waychison@Sun.COM, plars@linuxtestproject.org,
       Brian.Somers@Sun.COM, linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
X-Message-Flag: Warning: May contain useful information
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com> <412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com> <412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com> <412DC055.4070401@sun.com>
	<20040830161126.585a6b62.davem@davemloft.net>
	<1094238777.9913.278.camel@plars.austin.ibm.com>
	<4138C3DD.1060005@sun.com> <52acw7rtrw.fsf@topspin.com>
	<20040903133059.483e98a0.davem@davemloft.net>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 03 Sep 2004 16:24:25 -0700
In-Reply-To: <20040903133059.483e98a0.davem@davemloft.net> (David S.
 Miller's message of "Fri, 3 Sep 2004 13:30:59 -0700")
Message-ID: <52ekljq6l2.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Sep 2004 23:24:25.0436 (UTC) FILETIME=[26ADA1C0:01C4920D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> Please make sure you try current sources, I've had nothing
    David> but positive reports for IBM blades from people actually
    David> using the correct current 3.9 driver.

I tried it with a full build of a BK tree pulled last night, and it
definitely didn't work.  Some relevant output:

    tg3.c:v3.9 (August 30, 2004)
    eth0: Tigon3 [partno(none) rev 2003 PHY(serdes)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:1e:88:56
    eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0]
    eth1: Tigon3 [partno(none) rev 2003 PHY(serdes)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:1e:88:57
    eth1: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]

and then as soon as the init scripts try to bring up the interface:

    Setting up network interfaces:
        lo
        lo        IP address: 127.0.0.1/8                                 done
        dummy0
        dummy0    No configuration found for dummy0                       unused
        eth0      device: Broadcom Corporation NetXtreme BCM5
    system>
    system> console -T system:blade[11]
    SOL is not ready

(the last three lines are the management console taking over again
after the serial-over-LAN has died)

Just to be clear, I'm running a ppc64 kernel on a JS20 blade (dual PPC
970) with BCM5704S.  The HS20 blade (dual Xeon) also has a BCM5703X
but I haven't tried the latest driver on one of those yet.

Thanks,
  Roland

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262621AbTC3M57>; Sun, 30 Mar 2003 07:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbTC3M56>; Sun, 30 Mar 2003 07:57:58 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:43274 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S262621AbTC3M55>; Sun, 30 Mar 2003 07:57:57 -0500
Date: Sun, 30 Mar 2003 22:08:29 +0900 (JST)
Message-Id: <20030330.220829.129728506.yoshfuji@linux-ipv6.org>
To: usagi-users@linux-ipv6.org, pioppo@ferrara.linux.it
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, ds6-devel@deepspace6.net
Subject: Re: (usagi-users 02296) IPv6 duplicate address bugfix
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030330122705.GA18283@ferrara.linux.it>
References: <20030330122705.GA18283@ferrara.linux.it>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030330122705.GA18283@ferrara.linux.it> (at Sun, 30 Mar 2003 14:27:05 +0200), Simone Piunno <pioppo@ferrara.linux.it> says:

> When adding an IPv6 address to a given interface, I'm allowed to
> add that address multiple time, e.g.:
> 
> [root@abulafia root]# ip addr add 3ffe:4242:4242::1 dev eth0
> [root@abulafia root]# ip addr add 3ffe:4242:4242::1 dev eth0
> [root@abulafia root]# ip addr add 3ffe:4242:4242::1 dev eth0
> [root@abulafia root]# ip addr show dev eth0
> 2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
>     link/ether 00:48:54:1b:25:30 brd ff:ff:ff:ff:ff:ff
>     inet6 3ffe:4242:4242::1/128 scope global 
>     inet6 3ffe:4242:4242::1/128 scope global 
>     inet6 3ffe:4242:4242::1/128 scope global 
>     inet6 fe80::248:54ff:fe1b:2530/10 scope link
> 
> Apparently, this is not a stability problem, because I'm allowed to 
> delete 3 times that address before receving a "not found" error,
> but there's no reason to allow multiple instances of the same address 
> on the same interface, so this is a bug nonetheless.
> 
> Bug is confirmed on:
>   - 2.4.20
>   - 2.5.66
>   - latest -usagi

usagi code does not act like that.

In my environment,

# ip addr add 3ffe:4242:4242::1 dev eth0
# ip addr add 3ffe:4242:4242::1 dev eth0
RTNETLINK answers: No buffer space available
# ip addr add 3ffe:4242:4242::1 dev eth0
RTNETLINK answers: No buffer space available

And, patch does not seem optimal. I'd take a look at very soon.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA

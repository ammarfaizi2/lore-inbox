Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUHVCSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUHVCSC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 22:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUHVCSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 22:18:00 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:7313 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265293AbUHVCPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 22:15:39 -0400
Subject: 2.6.(8.1) clock drift with apic enabled
From: Quel Qun <kelk1@comcast.net>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kelk1@comcast.net
Content-Type: text/plain
Date: Sat, 21 Aug 2004 19:15:34 -0700
Message-Id: <1093140934.4180.34.camel@dsktop.net.home>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93-2kk1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Maybe a follow-up to http://groups.google.com/groups?q=time+drift
+group:fa.linux.kernel&hl=en&lr=&ie=UTF-8&group=fa.linux.kernel&selm=fa.kv2ep3o.6i053a%40ifi.uio.no&rnum=7

With 2.6 kernels (at least since 2.6.7), I observe a huge system time
drift (~12s/h) if I boot with apic enabled. If I boot with noapic
nolapic, the system time is stable. Of course, ntpd is stopped to get
the following results.

# cat /proc/cmdline
BOOT_IMAGE=linux-2681-2kk1 ro root=345 noapic nolapic nodevfs
pmdisk=/dev/hda6 splash=silent

# while (true) ; do ntpdate -q gateway ; sleep 300 ; done
Looking for host gateway and service ntp
host found : gateway.home.net
server 192.168.0.1, stratum 2, offset 0.000618, delay 0.02631
21 Aug 17:29:53 ntpdate[4636]: adjust time server 192.168.0.1 offset
0.000618 sec
Looking for host gateway and service ntp
host found : gateway.home.net
server 192.168.0.1, stratum 2, offset 0.000717, delay 0.02631
21 Aug 17:34:53 ntpdate[4645]: adjust time server 192.168.0.1 offset
0.000717 sec
Looking for host gateway and service ntp
host found : gateway.home.net
server 192.168.0.1, stratum 2, offset 0.000827, delay 0.02631
21 Aug 17:39:53 ntpdate[4654]: adjust time server 192.168.0.1 offset
0.000827 sec
Looking for host gateway and service ntp
host found : gateway.home.net
server 192.168.0.1, stratum 2, offset 0.000775, delay 0.02632
21 Aug 17:44:53 ntpdate[4663]: adjust time server 192.168.0.1 offset
0.000775 sec
Looking for host gateway and service ntp
host found : gateway.home.net
server 192.168.0.1, stratum 2, offset 0.000759, delay 0.02632
21 Aug 17:49:54 ntpdate[4672]: adjust time server 192.168.0.1 offset
0.000759 sec

# cat /proc/cmdline
BOOT_IMAGE=linux-2681-2kk1 ro root=345 nodevfs pmdisk=/dev/hda6
splash=silent

# while (true) ; do ntpdate -q gateway ; sleep 300 ; done
Looking for host gateway and service ntp
host found : gateway.home.net
server 192.168.0.1, stratum 2, offset -0.749909, delay 0.02631
21 Aug 17:59:27 ntpdate[4033]: step time server 192.168.0.1 offset
-0.749909 secLooking for host gateway and service ntp
host found : gateway.home.net
server 192.168.0.1, stratum 2, offset -1.865757, delay 0.02629
21 Aug 18:04:27 ntpdate[4044]: step time server 192.168.0.1 offset
-1.865757 secLooking for host gateway and service ntp
host found : gateway.home.net
server 192.168.0.1, stratum 2, offset -2.941571, delay 0.02631
21 Aug 18:09:27 ntpdate[4053]: step time server 192.168.0.1 offset
-2.941571 secLooking for host gateway and service ntp
host found : gateway.home.net
server 192.168.0.1, stratum 2, offset -4.057391, delay 0.02631
21 Aug 18:14:27 ntpdate[4062]: step time server 192.168.0.1 offset
-4.057391 secLooking for host gateway and service ntp
host found : gateway.home.net
server 192.168.0.1, stratum 2, offset -5.140378, delay 0.02631
21 Aug 18:19:27 ntpdate[4071]: step time server 192.168.0.1 offset
-5.140378 sec

At 12seconds/hour, the system is unusable. Hardware is an Asus A7N8X2 MB
with an Athlon XP 2100+

Please cc me directly if you need more info as I am not subscribed to
the list.

Thank you,
-- 
kk1


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265151AbUFSIm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbUFSIm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 04:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUFSIm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 04:42:26 -0400
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:17018 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S265151AbUFSImW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 04:42:22 -0400
Message-ID: <40D3FC66.5050207@ThinRope.net>
Date: Sat, 19 Jun 2004 17:42:14 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Brian Lazara <blazara@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.7 and 2.4.27-pre6] new device support for forcedeth.c
References: <1087629194.19311.24.camel@localhost.localdomain>
In-Reply-To: <1087629194.19311.24.camel@localhost.localdomain>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Lazara wrote:
> Updated forcedeth.c network driver for NVIDIA nForce chipsets. Includes
> new devices and support for gigabit.
> 
> Regards,
> Brian 

Applied the patch and had a few modprobe/modprobe -r runs.
On every `modprobe forcedeth` the system freezes for a few seconds, sometimes the screensaver (i.e. blanker) starts...

MB here is ASUS A7N8X-Deluxe, AthlonXP2500+. I usually use only the 3COM NIC (there are 2 NICs on board), but I have used the nvidia NIC for some tests before.

So I tried to investigate the issue with the following commands:

 # alias ntp_check='ntpdate -q 192.168.1.100 2>&1 |grep ntpdate'
 # alias ntp_sync='ntpdate -b 192.168.1.100 2>&1 |grep ntpdate'
 # ntp_sync 
19 Jun 17:21:32 ntpdate[24182]: step time server 192.168.1.100 offset 0.000015 sec
 # modprobe -r forcedeth; ntp_check; modprobe forcedeth; ntp_check; dmesg -c; ntp_check; sleep 10; ntp_check
19 Jun 17:21:43 ntpdate[24244]: adjust time server 192.168.1.100 offset 0.000031 sec
19 Jun 17:21:44 ntpdate[24279]: step time server 192.168.1.100 offset 2.337685 sec
eth1: no IPv6 routers present
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.26.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
eth1: phy init failed to autoneg.
19 Jun 17:21:44 ntpdate[24294]: step time server 192.168.1.100 offset 2.337686 sec
19 Jun 17:21:55 ntpdate[24324]: step time server 192.168.1.100 offset 2.337705 sec
 # modprobe -r forcedeth; ntp_check; modprobe forcedeth; ntp_check; dmesg -c; ntp_check; sleep 10; ntp_check
19 Jun 17:21:57 ntpdate[24386]: step time server 192.168.1.100 offset 2.337709 sec
19 Jun 17:21:58 ntpdate[24402]: step time server 192.168.1.100 offset 4.675361 sec
eth1: no link during initialization.
eth1: no IPv6 routers present
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.26.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
eth1: phy init failed to autoneg.
eth1: no link during initialization.
19 Jun 17:21:58 ntpdate[24440]: step time server 192.168.1.100 offset 4.675362 sec
19 Jun 17:22:09 ntpdate[24466]: step time server 192.168.1.100 offset 4.675384 sec
 # modprobe -r forcedeth; ntp_check; modprobe forcedeth; ntp_check; dmesg -c; ntp_check; sleep 10; ntp_check
19 Jun 17:22:10 ntpdate[24482]: step time server 192.168.1.100 offset 4.675387 sec
19 Jun 17:22:11 ntpdate[24579]: step time server 192.168.1.100 offset 7.013042 sec
eth1: no IPv6 routers present
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.26.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth1: phy init failed to autoneg.
eth1: no link during initialization.
eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
19 Jun 17:22:11 ntpdate[24605]: step time server 192.168.1.100 offset 7.013040 sec
19 Jun 17:22:22 ntpdate[24608]: step time server 192.168.1.100 offset 7.013059 sec
 # modprobe -r forcedeth; ntp_check; modprobe forcedeth; ntp_check; dmesg -c; ntp_check; sleep 10; ntp_check
19 Jun 17:22:31 ntpdate[24654]: step time server 192.168.1.100 offset 7.013079 sec
19 Jun 18:34:04 ntpdate[24680]: step time server 192.168.1.100 offset -4281.321603 sec
eth1: no IPv6 routers present
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.26.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
eth1: phy init failed to autoneg.
eth1: no link during initialization.
19 Jun 18:34:04 ntpdate[24724]: step time server 192.168.1.100 offset -4281.321594 sec
19 Jun 17:22:39 ntpdate[24750]: step time server 192.168.1.100 offset 13.645721 sec
 # ntp_sync
19 Jun 17:23:04 ntpdate[24752]: step time server 192.168.1.100 offset 13.645741 sec


So, sometimes (good times) about 2.3 seconds are lost on each `modprobe forcedeth`, but sometimes (about 1 out of 3 tests) time is really sc.ewed! Although after a few (=10) seconds, it is restored to the "normal" 2.3 s/modprobe ...
Sometimes on the first test time goes back about 4200 seconds.

Any ideas on this issue?
I stopped ntpd on my local machine for the tests (so I can use ntp_sync), but with it running it is the same.
I have /sbin/hotplug running, but I doubt it is the culprit.
I plugged a cable (to a hub) into the NIC, but the results were the same (to check if the problem was autonegotiation).

Is this behaviour expected? Or this patch turned it?
I don't remember it with 2.6.6(unpatched).
I can try with 2.6.7 unpatched if it is of any value.

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/

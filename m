Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVHQBDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVHQBDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 21:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVHQBDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 21:03:42 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:50430 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S1750778AbVHQBDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 21:03:42 -0400
Date: Tue, 16 Aug 2005 18:03:37 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: linux-kernel@vger.kernel.org
Subject: routes disappear
Message-ID: <Pine.LNX.4.62.0508161749310.25699@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having an intermittent problem over the last couple of years 
where the addition of a network interface will cause all routes on the box 
to vanish.

the systems are a stripped down Debian 3.0 build with a 2.6.7 kernel and 
the vast majority of the time they work just fine.

however once in a while I get a config where enabling an interface causes 
netstat (and /proc/net/route) to report no routes. The system continues to 
function so the routes are still there somehow, but they aren't reported.

the latest box to do this has two interfaces (this one has tg3 interfaces, 
but I've also seen this on adaptec starfire, tulip, and 3com nics) 
192.168.242.142
192.168.210.219

if I boot the box with the interfaces disabled and do ifup individually it 
sometimes works (I haven't nailed down the difference between when it does 
and when it doesn't), if I leave them enabled at boot by the time I can 
login the routing table shows blank.

I have a few days to fiddle with this system before I need to use it, 
where should I look to dig up more info?

syslog shows the following
Aug 16 16:33:04 scribe1a-p kernel: Adding 2048276k swap on /dev/sda1. 
Priority:-1 extents:1
Aug 16 16:33:04 scribe1a-p kernel: ttyS2: LSR safety check engaged!
Aug 16 16:33:04 scribe1a-p kernel: ttyS2: LSR safety check engaged!
Aug 16 16:33:04 scribe1a-p kernel: ttyS3: LSR safety check engaged!
Aug 16 16:33:04 scribe1a-p kernel: ttyS3: LSR safety check engaged!
Aug 16 16:33:04 scribe1a-p kernel: tg3: eth0: Link is up at 1000 Mbps, 
full duplex.
Aug 16 16:33:04 scribe1a-p kernel: tg3: eth0: Flow control is on for TX 
and on for RX.
Aug 16 16:33:04 scribe1a-p kernel: tg3: eth1: Link is up at 1000 Mbps, 
full duplex.
Aug 16 16:33:04 scribe1a-p kernel: tg3: eth1: Flow control is off for TX 
and off for RX.
Aug 16 16:33:04 scribe1a-p kernel: process `syslogd' is using obsolete 
setsockopt SO_BSDCOMPAT
Aug 16 16:33:05 scribe1a-p /usr/sbin/gpm[191]: Detected EXPS/2 protocol 
mouse.
Aug 16 16:33:07 scribe1a-p ntpd[298]: ntpd 4.1.0 Mon Mar 25 23:39:47 UTC 
2002 (2)
Aug 16 16:33:07 scribe1a-p ntpd[298]: precision = 11 usec
Aug 16 16:33:07 scribe1a-p ntpd[298]: kernel time discipline status 0040
Aug 16 16:33:07 scribe1a-p ntpd[298]: attempt to configure invalid address 
127.127.1.0
Aug 16 16:33:07 scribe1a-p /usr/sbin/cron[303]: (CRON) INFO (pidfile fd = 
3)
Aug 16 16:33:07 scribe1a-p /usr/sbin/cron[304]: (CRON) STARTUP (fork ok)
Aug 16 16:33:07 scribe1a-p /usr/sbin/cron[304]: (CRON) INFO (Running 
@reboot jobs)
Aug 16 16:33:16 scribe1a-p ntpd[298]: sendto(192.168.252.132): Network is 
unreachable
Aug 16 16:33:23 scribe1a-p ntpd[298]: sendto(192.168.252.131): Network is 
unreachable
Aug 16 16:33:36 scribe1a-p kernel: 192.168.242.142 sent an invalid ICMP 
type 3, code 1 error to a broadcast: 192.168.
242.255 on lo
Aug 16 16:33:36 scribe1a-p kernel: 192.168.242.142 sent an invalid ICMP 
type 3, code 1 error to a broadcast: 192.168.
242.255 on lo
Aug 16 16:33:39 scribe1a-p kernel: tg3: eth0: Link is up at 1000 Mbps, 
full duplex.
Aug 16 16:33:39 scribe1a-p kernel: tg3: eth0: Flow control is on for TX 
and on for RX.
Aug 16 16:33:42 scribe1a-p kernel: 192.168.210.216 sent an invalid ICMP 
type 3, code 1 error to a broadcast: 192.168.
210.255 on lo
Aug 16 16:33:42 scribe1a-p kernel: 192.168.210.216 sent an invalid ICMP 
type 3, code 1 error to a broadcast: 192.168.
210.255 on lo
Aug 16 16:33:43 scribe1a-p kernel: tg3: eth1: Link is up at 1000 Mbps, 
full duplex.
Aug 16 16:33:43 scribe1a-p kernel: tg3: eth1: Flow control is off for TX 
and off for RX.
Aug 16 16:33:55 scribe1a-p kernel: tg3: eth1: Link is up at 1000 Mbps, 
full duplex.
Aug 16 16:33:55 scribe1a-p kernel: tg3: eth1: Flow control is off for TX 
and off for RX.
Aug 16 16:34:01 scribe1a-p /USR/SBIN/CRON[716]: (root) CMD (touch 
/tmp/.crond_running >/dev/null 2>/dev/null)
Aug 16 16:34:02 scribe1a-p kernel: 192.168.242.142 sent an invalid ICMP 
type 3, code 1 error to a broadcast: 192.168.
242.255 on lo
Aug 16 16:34:02 scribe1a-p kernel: 192.168.242.142 sent an invalid ICMP 
type 3, code 1 error to a broadcast: 192.168.
242.255 on lo
Aug 16 16:34:04 scribe1a-p kernel: tg3: eth0: Link is up at 1000 Mbps, 
full duplex.
Aug 16 16:34:04 scribe1a-p kernel: tg3: eth0: Flow control is on for TX 
and on for RX.
Aug 16 16:35:01 scribe1a-p /USR/SBIN/CRON[1126]: (root) CMD 
(/usr/local/etc/newlogs >/dev/null 2>/dev/null)
Aug 16 16:35:01 scribe1a-p /USR/SBIN/CRON[1128]: (root) CMD (touch 
/tmp/.crond_running >/dev/null 2>/dev/null)


David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

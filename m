Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264294AbRFOJNV>; Fri, 15 Jun 2001 05:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264307AbRFOJNL>; Fri, 15 Jun 2001 05:13:11 -0400
Received: from dfw-smtpout1.email.verio.net ([129.250.36.41]:55180 "EHLO
	dfw-smtpout1.email.verio.net") by vger.kernel.org with ESMTP
	id <S264294AbRFOJNA>; Fri, 15 Jun 2001 05:13:00 -0400
Message-ID: <3B29D19B.48A62E4B@bigfoot.com>
Date: Fri, 15 Jun 2001 02:12:59 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20p2-ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: =?iso-8859-1?Q?Jos=E9?= Luis Domingo =?iso-8859-1?Q?L=F3pez?= 
	<jldomingo@crosswinds.net>
Subject: Re: [BUG] 2.2.19 -> 80% Packet Loss
In-Reply-To: <20010615011415.A5210@dardhal.mired.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

José Luis Domingo López wrote:
> 
> On Thursday, 14 June 2001, at 14:17:11 -0700,
> chuckw@altaserv.net wrote:
> 
> >
> > 1. When pinging a machine using kernel 2.2.19 I consistently get an 80%
> > packet loss when doing a ping -f with a packet size of 64590 or higher.
> >
> What happens here is (under kernel 2.2.19):
> ping -f -s 49092 localhost -->>   0 % packet loss
> ping -f -s 49093 localhost -->> 100 % packet loss

[tim@abit cron.daily]# ping -w 10 -f -s 49093 localhost
PING localhost (127.0.0.1) from 127.0.0.1 : 49093(49121) bytes of data.
Warning: no SO_RCVTIMEO support, falling back to poll
.
--- localhost ping statistics ---
8051 packets transmitted, 8051 packets received, 0% packet loss
round-trip min/avg/max/mdev = 0.517/0.751/25.336/0.678 ms

> Maybe this has something to do with fragmentation of IP packets to fit in
> the underlying protocol's MTU (3929 in my loopback device).

[tim@abit cron.daily]# ifconfig lo
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3924  Metric:1
          RX packets:1197462 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1197462 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 

[tim@abit cron.daily]# cat /proc/version
Linux version 2.2.20p2-ai (root@abit) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #12 Fri May 25 16:31:02 PDT 2001

--

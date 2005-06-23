Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbVFWXVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVFWXVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVFWXVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:21:14 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:9409 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262623AbVFWXVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:21:04 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
X-X-Sender: dlang@dlang.diginsite.com
Date: Thu, 23 Jun 2005 16:20:21 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [git patch] urgent e1000 fix
In-Reply-To: <42BB2749.1020209@pobox.com>
Message-ID: <Pine.LNX.4.62.0506231615590.18154@qynat.qvtvafvgr.pbz>
References: <42BA7FB5.5020804@pobox.com> <Pine.LNX.4.62.0506231402340.18154@qynat.qvtvafvgr.pbz>
 <42BB2749.1020209@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This does not solve the problem that I reported last thursday where the 
fourth port of a e1000 quad card doesn't work under SMP (I don't know if 
it was supposed to, but since it was a locking fix I had hopes).

here's the symptom I am seeing
happy1-p:~# ifconfig eth11 192.168.255.1
SIOCSIFFLAGS: Invalid argument
happy1-p:~# netstat -nr
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
172.20.252.0    0.0.0.0         255.255.252.0   U         0 0          0 eth1
10.201.0.0      0.0.0.0         255.255.0.0     U         0 0          0 eth0
0.0.0.0         10.201.0.2      0.0.0.0         UG        0 0          0 eth0
happy1-p:~# ifconfig eth11
eth11     Link encap:Ethernet  HWaddr 00:04:23:B4:BB:97
           inet addr:192.168.255.1  Bcast:192.168.255.255  Mask:255.255.255.0
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
           Base address:0x60c0 Memory:fe460000-fe480000

userspace is debian woody

David Lang

On Thu, 23 Jun 2005, Jeff Garzik wrote:

> David Lang wrote:
>> hmm, I know I'm not that experianced with patch, but when I saved this to a 
>> file and did patch -p1 <file the hunk was rejected, the reject file is 
>> saying
>
> It's probably the whitespace thing that Linus's git-apply gadget was 
> complaining about.
>
> I'm terribly surprising, though, since my patch(1) applied the diff just 
> fine.
>
> <shrug>
>
> 	Jeff
>
>
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbUBDUpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266586AbUBDUoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:44:44 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:29660 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S264441AbUBDUm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:42:59 -0500
Date: Wed, 4 Feb 2004 15:42:58 -0500 (EST)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, kraxel@bytesex.org
Subject: Re: major network performance difference between 2.4 and 2.6.2-rc2
In-Reply-To: <Pine.GSO.4.58.0401302108560.1211@denali.ccs.neu.edu>
Message-ID: <Pine.GSO.4.58.0402041529160.7454@denali.ccs.neu.edu>
References: <Pine.GSO.4.58.0401302108560.1211@denali.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Jan 2004, Jim Faulkner wrote:

>
> There is a major networking performance problem on my machine under recent
> 2.6 kernels.  I have a dual Athlon-MP machine with an onboard Intel
> Ethernet Pro 100 device, which can use either the e100 or eepro100 driver.
>
> I ran some tests under 2.4 and recent 2.6 kernels to see what kind of
> performance I could get.  I tested using both ftp and samba, the client
> machine is a windows box with an onboard 3com 3c920b controller.  They
> are connected through a D-Link 100 megabit full duplex switch.

...

> It appears that my network device is capable of 4 times the throughput
> under 2.4 kernels versus recent 2.6 kernels.  I believe this problem arose
> recently, probably sometime since 2.6.0, since I only recently noticed
> this performance issue.

I am still experiencing severely degraded network performance under
2.6.2-rc3 and 2.6.2-rc3-mm1.  Based on some kernel output, I think this
problem may be related to Gerd Knorr's input patches, so I am CCing him on
this e-mail.  You can view my entire original e-mail, which includes
system configuration information, right here:
http://groups.google.com/groups?selm=1jTPU-2ee-1%40gated-at.bofh.it&rnum=1

While doing a large network transfer, and not at any other time, I get
tons of messages like this from the kernel:

Feb  4 15:13:50 delta-9 i2c IR (Hauppauge): unknown key: key=0x3f raw=0x3fff down=1
Feb  4 15:13:55 delta-9 i2c IR (Hauppauge): unknown key: key=0x3f raw=0x3fff down=0
Feb  4 15:13:57 delta-9 i2c IR (Hauppauge): unknown key: key=0x3f raw=0x3fff down=1
Feb  4 15:14:00 delta-9 i2c IR (Hauppauge): unknown key: key=0x3f raw=0x3fff down=0
Feb  4 15:14:01 delta-9 i2c IR (Hauppauge): unknown key: key=0x3f raw=0x3fff down=1
Feb  4 15:14:03 delta-9 i2c IR (Hauppauge): unknown key: key=0x3f raw=0x3fff down=0
Feb  4 15:14:03 delta-9 i2c IR (Hauppauge): unknown key: key=0x3f raw=0x3fff down=1
Feb  4 15:14:05 delta-9 i2c IR (Hauppauge): unknown key: key=0x3f raw=0x3fff down=0
Feb  4 15:14:06 delta-9 i2c IR (Hauppauge): unknown key: key=0x3f raw=0x3fff down=1

I do have a hauppauge remote which works great under the 2.6 kernels
(thanks Gerd), but I am not pressing any keys while this is happening.

Additionally, while large network transfers are going on, both ksoftirqd/0
and events/0 start going crazy, putting a huge load on my system:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  3 root      35  19     0    0    0 S 45.9  0.0   0:46.98 ksoftirqd/0
  6 root       5 -10     0    0    0 S 43.3  0.0   1:56.63 events/0
  12008 dogshu 15   0  4800 2356 3828 S  5.3  0.2   0:05.98 proftpd
  12 root      15   0     0    0    0 S  0.3  0.0   0:00.41 pdflush
  9778 root    16   0  5888 1724 5516 R  0.3  0.2   0:00.12 sshd

the load before that network transfer was 0.01, and the load after the
network transfer was 1.45.

I'd really like to have my network performance back, so it would be great
if someone could take a look at this. :)

thanks for any help,
Jim Faulkner

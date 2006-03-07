Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWCGO54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWCGO54 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 09:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWCGO54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 09:57:56 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:16136 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751031AbWCGO5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 09:57:54 -0500
Date: Tue, 7 Mar 2006 14:57:39 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060307145739.GA9834@deprecation.cyrius.com>
References: <20060305180757.GA22121@deprecation.cyrius.com> <20060305185948.GA24765@electric-eye.fr.zoreil.com> <20060306143512.GI23669@deprecation.cyrius.com> <20060306191706.GA6947@deprecation.cyrius.com> <20060306211745.GD15728@electric-eye.fr.zoreil.com> <20060307051152.GA1244@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307051152.GA1244@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Michlmayr <tbm@cyrius.com> [2006-03-07 05:11]:
> * Francois Romieu <romieu@fr.zoreil.com> [2006-03-06 22:17]:
> > Not sure about this one, but...
> 
> It seems to help.  It's hard to say for sure because I don't have a
> foolproof way to reproduce this panic.  It _usually_ occurs after
> copying a few hundred MB but there's no clear trigger.  I've now copied
> a few GB around using a kernel with your patch and it hasn't crashed.

I'm pretty sure now that your patch helps.  I left the system running
overnight and it was still alive in the morning after transferring ~10
GB.  I do get all kind of underrun messages (see below) but the data
got transferred alright.  I then rebooted with the kernel that doesn't
have your patch and it crashed after ~1 GB.


(this was at about 3 GB, but the same goes on and on; but the network
works.)

eth0      Link encap:Ethernet  HWaddr 00:80:C8:33:4F:96  
          inet addr:192.168.1.145  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::280:c8ff:fe33:4f96/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1199533 errors:7 dropped:0 overruns:7 frame:0
          TX packets:2344296 errors:396 dropped:252 overruns:396 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:64846004 (61.8 MiB)  TX bytes:3479989567 (3.2 GiB)
          Interrupt:10 Base address:0x2000 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:560 (560.0 b)  TX bytes:560 (560.0 b)


Adding 136512k swap on /dev/hda5.  Priority:-1 extents:1 across:136512k
EXT3 FS on hda1, internal journal
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
eth0: enabling interface
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
eth0: link up, media 10baseT auto
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb022
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb012
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb032
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb02a
eth0: tx err, status 0x7fffb01a
eth0: tx err, status 0x7fffb02a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
NETDEV WATCHDOG: eth0: transmit timed out
eth0: NIC status fc660000 mode 7ffc2002 sia 45e1d1c8 desc 15/37/38
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
eth0: link up, media 10baseT auto
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb012
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: rx err, slot 54 status 0x508329 len 76
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
NETDEV WATCHDOG: eth0: transmit timed out
eth0: NIC status fc660000 mode 7ffc2002 sia 45e1d1c8 desc 16/6/7
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
eth0: link up, media 10baseT auto
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb012
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: rx err, slot 60 status 0x508329 len 76
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
NETDEV WATCHDOG: eth0: transmit timed out
eth0: NIC status fc660000 mode 7ffc2002 sia 45e1d1c8 desc 41/47/48
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
eth0: link up, media 10baseT auto
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: rx err, slot 32 status 0x508329 len 76
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: rx err, slot 55 status 0x508329 len 76
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: rx err, slot 43 status 0x508329 len 76
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: rx err, slot 2 status 0x508329 len 76
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: rx err, slot 6 status 0x508329 len 76
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002
NETDEV WATCHDOG: eth0: transmit timed out
eth0: NIC status fc660000 mode 7ffc2002 sia 45e1d1c8 desc 17/63/0
eth0: set link 10baseT auto
eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
eth0: link up, media 10baseT auto
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb002
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb00a
eth0: tx err, status 0x7fffb002

-- 
Martin Michlmayr
http://www.cyrius.com/

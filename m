Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264957AbUEQKaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbUEQKaz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 06:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbUEQKaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 06:30:55 -0400
Received: from rs1.physik.Uni-Dortmund.DE ([129.217.168.30]:28057 "EHLO
	rs1.physik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264957AbUEQKav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 06:30:51 -0400
Date: Mon, 17 May 2004 12:30:11 +0200
From: Robert Fendt <fendt@physik.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: Re: peculiar problem with 2.6, 8139too + ACPI
Message-Id: <20040517123011.7e12d297.fendt@physik.uni-dortmund.de>
In-Reply-To: <1084584998.12352.306.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615FB5FE@hdsmsx403.hd.intel.com>
	<1084584998.12352.306.camel@dhcppc4>
Organization: Lehrstuhl =?ISO-8859-1?B?Zvxy?= experimentelle Physik I,
 =?ISO-8859-1?B?VW5pdmVyc2l05HQ=?= Dortmund
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 2004 21:36:38 -0400
Len Brown <len.brown@intel.com> wrote:

> If the 8139too has statistics counters showing if it gets
> RX buffer over-runs, that would be interseting to observe.

Hmm I am not entirely sure I understand what you mean. ifconfig output
is as follows:

a) with 'processor' loaded

robert@betazed:~$ wget http://download.sourcemage.org/iso/smgl-i386-2.6.5-20040414.iso.bz2
--12:27:16--  http://download.sourcemage.org/iso/smgl-i386-2.6.5-20040414.iso.bz2
           => `smgl-i386-2.6.5-20040414.iso.bz2'
Resolving download.sourcemage.org... 152.2.210.81
Connecting to download.sourcemage.org[152.2.210.81]:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 142,065,569 [text/plain]

 0% [                                     ] 202,609        2.30K/s ETA 10:17:41


robert@betazed:~$ /sbin/ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0C:6E:8A:DD:BA  
          inet addr:129.217.168.125  Bcast:129.217.168.255  Mask:255.255.255.0
          inet6 addr: fe80::20c:6eff:fe8a:ddba/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:933 errors:117 dropped:212 overruns:117 frame:0
          TX packets:638 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:622241 (607.6 KiB)  TX bytes:54355 (53.0 KiB)
          Interrupt:5 Base address:0xc800 


b) without 'processor' loaded

robert@betazed:~$ wget http://download.sourcemage.org/iso/smgl-i386-2.6.5-20040414.iso.bz2
--11:29:17--  http://download.sourcemage.org/iso/smgl-i386-2.6.5-20040414.iso.bz2
           => `smgl-i386-2.6.5-20040414.iso.bz2.2'
Resolving download.sourcemage.org... 152.2.210.81
Connecting to download.sourcemage.org[152.2.210.81]:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 142,065,569 [text/plain]

 3% [=>                                                  ] 5,526,132    514.93K/s

robert@betazed:~$ /sbin/ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0C:6E:8A:DD:BA  
          inet addr:129.217.168.125  Bcast:129.217.168.255  Mask:255.255.255.0
          inet6 addr: fe80::20c:6eff:fe8a:ddba/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4187 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2313 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:5904292 (5.6 MiB)  TX bytes:149285 (145.7 KiB)
          Interrupt:5 Base address:0xc800 


One additional problem in debugging this is that it seems to be
depending on the local network topology, since I somehow cannot
reproduce it when downloading from machines on the LAN or when I have a
slow downstream connection (e.g. DSL).

> It would also be interesting to know if you see the problem
> more frequently when running on battery power, since some
> systems have higher c-state exit latency when on battery.

Hmmm, I cannot see a difference between battery and ac. I will look into
it a bit more, though.

Regards,
Robert

-- 
Robert Fendt
Experimentelle Physik I, Universität Dortmund
Otto-Hahn-Str. 4, 44221 Dortmund, -Germany-
Tel. +49-231-755-3522

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263641AbUE3NQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUE3NQy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 09:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbUE3NQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 09:16:54 -0400
Received: from news.cistron.nl ([62.216.30.38]:47816 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263641AbUE3NQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 09:16:47 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: Linux 2.6.7-rc2
Date: Sun, 30 May 2004 13:16:46 +0000 (UTC)
Organization: Cistron
Message-ID: <c9cmru$nju$1@news.cistron.nl>
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org> <c9c42l$228$1@news.cistron.nl> <20040530130902.A2756@electric-eye.fr.zoreil.com>
X-Trace: ncc1701.cistron.net 1085923006 24190 62.216.30.38 (30 May 2004 13:16:46 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu  <romieu@fr.zoreil.com> wrote:
>> Ethernet stopped working (for me) going from 2.6.7-rc1-bk3 to 2.6.7-rc2.
>> AMD64/asusK8V with onboard ethernet.
>> 2.6.7-rc1-bk3 worked like intended.
>
>The patch below was applied between 2.6.7-rc1-bk3 and 2.6.7-rc1-bk4.
>How does your kernel perform if you patch -R ?
>diff -Nru a/drivers/net/sk98lin/skvpd.c b/drivers/net/sk98lin/skvpd.c
>--- a/drivers/net/sk98lin/skvpd.c	2004-05-28 01:13:08 -07:00
>+++ b/drivers/net/sk98lin/skvpd.c	2004-05-28 01:13:08 -07:00

Same (not working)

Running dhclient:

sit0: unknown hardware address type 776
eth0: unknown hardware address type 24
sit0: unknown hardware address type 776
eth0: unknown hardware address type 24
Listening on LPF/eth0/<null>
Sending on   LPF/eth0/<null>
Sending on   Socket/fallback/fallback-net
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 3
receive_packet failed on eth0: Network is down
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 3
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 5
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 14
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 10
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 15
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 11
No DHCPOFFERS received.

eth0      Link encap:UNSPEC  HWaddr 00-E0-18-00-00-60-79-2F-00-00-00-00-00-00-00-00  
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:17 dropped:17 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

---------------------

Manual config:
eth0      Link encap:UNSPEC  HWaddr 00-E0-18-00-00-60-79-2F-00-00-00-00-00-00-00-00  
          inet addr:192.168.42.65  Bcast:192.168.42.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:19 dropped:19 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

Ping to firewall:

eth0      Link encap:UNSPEC  HWaddr 00-E0-18-00-00-60-79-2F-00-00-00-00-00-00-00-00  
          inet addr:192.168.42.65  Bcast:192.168.42.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6 errors:19 dropped:19 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 b)  TX bytes:216 (216.0 b)

Clearly nothing received

Oh wait... now i see what's wrong!
eth0 is now suddenly ethertnet over firewire.

cp /boot/config-2.6.7-rc1-bk3 .config
make oldconfig
somehow "whacked" CONFIG_SK98LIN=y in .config ....

grmblll..

make menuconfig i cannot get into the submenu 

device drivers -> 
 networking support -> 
  Gigabit Ethernet (1000/10000 Mbit)  ---> 

whereas with 10/100 Mbit ethernet i can.

Little flaw elsewhere!

Danny
-- 
"If Microsoft had been the innovative company that it calls itself, it 
would have taken the opportunity to take a radical leap beyond the Mac, 
instead of producing a feeble, me-too implementation." - Douglas Adams -


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282150AbRKWOFt>; Fri, 23 Nov 2001 09:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282152AbRKWOFk>; Fri, 23 Nov 2001 09:05:40 -0500
Received: from mammut.nsc.liu.se ([130.236.104.31]:7684 "EHLO
	mammut.nsc.liu.se") by vger.kernel.org with ESMTP
	id <S282150AbRKWOFb> convert rfc822-to-8bit; Fri, 23 Nov 2001 09:05:31 -0500
Date: Fri, 23 Nov 2001 15:05:29 +0100 (CET)
From: =?ISO-8859-1?Q?Peter_Kjellstr=F6m?= <cap@nsc.liu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: anyone got the same problem with DIGITAL 21143 network card ?
Message-ID: <Pine.LNX.4.21.0111231436040.25529-100000@mammut.nsc.liu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Juan Quintela wrote:

> Could you check if this patch makes your card work?

On my system it behaves no diffrent from 2.4.[14,15] vanilla :-(
My box still requires me to a disconnect/reconnect my ethernet cable with
these new tulip drivers... (resulting in that I still run 0.9.13a)

Here is what my kernel spits out during boot (2.4.15-final):

 Linux Tulip driver version 0.9.15-pre9-quintela (Nov 23, 2001)
 PCI: Found IRQ 5 for device 00:09.0
 tulip0:  EEPROM default media type Autosense.
 tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY
 (3) block.
 tulip0:  MII transceiver #8 config 3100 status 782d advertising 01e1.
 eth0: Digital DS21143 Tulip rev 65 at 0xbc00, 00:80:C8:F7:14:BA, IRQ 5.
 .
 .
 .
 eth0: Setting full-duplex based on MII#8 link partner capability of 41e1.


and here is lspci for the NIC:

 00:09.0 Ethernet controller: Digital Equipment Corporation DECchip
 21142/43 (rev 41)
	Subsystem: D-Link System Inc DFE-500TX Fast Ethernet
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at bc00 [size=128]
	Memory at e8061000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]


ifconfig:

 eth0     Link encap:Ethernet  HWaddr 00:80:C8:F7:14:BA  
          inet addr:192.168.1.253  Bcast:192.168.1.255 Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:1 dropped:0 overruns:0 frame:0
          TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:5 Base address:0xbc00 

...doing some pinging (no ans. then host unreachable)...

 eth0     Link encap:Ethernet  HWaddr 00:80:C8:F7:14:BA  
          inet addr:192.168.1.253  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:1 dropped:0 overruns:0 frame:0
          TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:5 Base address:0xbc00 

> It works for me.
> Later, Juan.
> --- linux/drivers/net/tulip/21142.c.orig	Mon Nov  5 20:50:27 2001
> +++ linux/drivers/net/tulip/21142.c	Mon Nov  5 21:26:40 2001
> @@ -188,8 +188,9 @@
>                          int i;
>                          for (i = 0; i < tp->mtable->leafcount; i++)
>                                  if (tp->mtable->mleaf[i].media ==
> dev->if_port) {
> +					int startup = ! ((tp->chip_id ==
> DC21143 && tp->revision == 65));
>                                          tp->cur_index = i;
> -					tulip_select_media(dev, 1);
> +					tulip_select_media(dev, startup);
>                                          setup_done = 1;
>                                          break;
>                                  }
> --
> In theory, practice and theory are the same, but in practice they
> are different -- Larry McVoy
> -

/Peter


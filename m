Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264645AbUEEM4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264645AbUEEM4m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264651AbUEEM4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:56:12 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:12332 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S264639AbUEEMwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:52:30 -0400
Date: Tue, 4 May 2004 13:55:16 +0100
From: backblue <backblue@netcabo.pt>
To: Lucas Nussbaum <lucas@lucas-nussbaum.net>, linux-kernel@vger.kernel.org
Subject: Re: ne2k-pci uncorrectly detecting collisions ?
Message-Id: <20040504135516.78f87d0d@fork.ketic.com>
In-Reply-To: <20040505123532.GA3011@blop.info>
References: <20040505123532.GA3011@blop.info>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2004 12:52:28.0067 (UTC) FILETIME=[D22E8730:01C4329F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that problem, it's because hardware, ne2k-pci NIC's and all realtek stuff, are chip NIC's that it's not suposed to use in that way, i have many problems like that, with realtek NIC's, but when i used real NIC's like 3com, you dont have any problems at all!
The realtek's NIC's starts complaining because another ones, they dont live well together! :)
Buy 3com nic's. :)

good luck

On Wed, 5 May 2004 14:35:32 +0200
Lucas Nussbaum <lucas@lucas-nussbaum.net> wrote:

> Hello,
> 
> I have experienced problem with the ne2k-pci driver. The symptoms were
> extremly poor performance with TCP. After some investigations, I believe
> it might be caused by problems with detecting collisions.
> 
> I tested with 3 cards :
> - eth1 : RTL8029 - not working properly
>   the chip says RTL8029, but lspci says RTL8029(AS)
> - eth2 : RTL8029AS - working.
> - eth3 : RTL8029AS - not working properly
> lspci for all three cards :
> 00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.  RTL-8029(AS)
> 
> The same problem was experienced on FreeBSD, but it hurts a lot to say
> that there wasn't any problem when I tested under Windows - so it's
> probably not a broken card problem.
> 
> All 3 NICs were in the same box, using the same ne2k-pci driver compiled
> as a module (kernel version is 2.4.24). They used the same 10/100 Hub to
> talk to the same NIC on the other end. Traffic on the network during the
> test was quite low but not nonexistent.
> 
> As you can see :
> - throughput for eth1 and eth3 with TCP is extremly low.
> - throughput with UDP is normal.
> - eth1 and eth3 saw no collisions, but eth2 saw a lot.
> - eth1 and eth3 saw lots of frame errors, but eth2 saw much less.
>  
> Here are the detailed test results. I can provide more results if needed.
> + ifconfig eth1 down
> + ifconfig eth2 down
> + ifconfig eth3 down
> + rmmod ne2k-pci
> + modprobe ne2k-pci
> + ifconfig eth1 172.36.1.2
> + ifconfig eth2 172.37.1.2
> + ifconfig eth3 172.38.1.2
> + netperf -H 172.36.1.1 -l 20
> TCP STREAM TEST to 172.36.1.1
> Recv   Send    Send                          
> Socket Socket  Message  Elapsed              
> Size   Size    Size     Time     Throughput  
> bytes  bytes   bytes    secs.    10^6bits/sec  
> 
>  87380  16384  16384    20.18       0.59   
> + netperf -H 172.37.1.1 -l 20
> TCP STREAM TEST to 172.37.1.1
> Recv   Send    Send                          
> Socket Socket  Message  Elapsed              
> Size   Size    Size     Time     Throughput  
> bytes  bytes   bytes    secs.    10^6bits/sec  
> 
>  87380  16384  16384    20.04       8.54   
> + netperf -H 172.38.1.1 -l 20
> TCP STREAM TEST to 172.38.1.1
> Recv   Send    Send                          
> Socket Socket  Message  Elapsed              
> Size   Size    Size     Time     Throughput  
> bytes  bytes   bytes    secs.    10^6bits/sec  
> 
>  87380  16384  16384    20.05       0.56   
> + netperf -t UDP_STREAM -H 172.36.1.1 -l 20 -- -m 1472
> UDP UNIDIRECTIONAL SEND TEST to 172.36.1.1
> Socket  Message  Elapsed      Messages                
> Size    Size     Time         Okay Errors   Throughput
> bytes   bytes    secs            #      #   10^6bits/sec
> 
>  65535    1472   20.00       16027      0       9.44
>  65535           20.00       15216              8.96
> 
> + netperf -t UDP_STREAM -H 172.37.1.1 -l 20 -- -m 1472
> UDP UNIDIRECTIONAL SEND TEST to 172.37.1.1
> Socket  Message  Elapsed      Messages                
> Size    Size     Time         Okay Errors   Throughput
> bytes   bytes    secs            #      #   10^6bits/sec
> 
>  65535    1472   19.99       15326      0       9.03
>  65535           19.99       15326              9.03
> 
> + netperf -t UDP_STREAM -H 172.38.1.1 -l 20 -- -m 1472
> UDP UNIDIRECTIONAL SEND TEST to 172.38.1.1
> Socket  Message  Elapsed      Messages                
> Size    Size     Time         Okay Errors   Throughput
> bytes   bytes    secs            #      #   10^6bits/sec
> 
>  65535    1472   20.00       16008      0       9.43
>  65535           20.00       15593              9.18
> 
> + netstat -i
> Table d'interfaces noyau
> Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR   TX-OK TX-ERR TX-DRP TX-OVR Flg
> eth0   1500 0    140926      0      0      0  232637      0      0      0 BMRU
> eth1   1500 0      1049      0      0      0   17292      0      0      0 BMRU
> eth2   1500 0      7421      0      0      0   30134      0      0      0 BMRU
> eth3   1500 0       982      0      0      0   17201      0      0      0 BMRU
> lo    16436 0     22831      0      0      0   22831      0      0      0 LRU
> + ifconfig eth1
> eth1      Lien encap:Ethernet  HWaddr 00:00:E8:D7:E9:46  
>           inet adr:172.36.1.2  Bcast:172.36.255.255  Masque:255.255.0.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:1049 errors:0 dropped:0 overruns:0 frame:165
>           TX packets:17292 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 lg file transmission:1000 
>           RX bytes:75796 (74.0 KiB)  TX bytes:26148738 (24.9 MiB)
>           Interruption:5 Adresse de base:0xd800 
> 
> + ifconfig eth2
> eth2      Lien encap:Ethernet  HWaddr 00:E0:7D:75:C2:D7  
>           inet adr:172.37.1.2  Bcast:172.37.255.255  Masque:255.255.0.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:7421 errors:0 dropped:0 overruns:0 frame:27
>           TX packets:30134 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:225 lg file transmission:1000 
>           RX bytes:491544 (480.0 KiB)  TX bytes:45590838 (43.4 MiB)
>           Interruption:9 Adresse de base:0xdc00 
> 
> + ifconfig eth3
> eth3      Lien encap:Ethernet  HWaddr 00:00:E8:74:0E:1A  
>           inet adr:172.38.1.2  Bcast:172.38.255.255  Masque:255.255.0.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:982 errors:0 dropped:0 overruns:0 frame:147
>           TX packets:17201 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 lg file transmission:1000 
>           RX bytes:71062 (69.3 KiB)  TX bytes:26010052 (24.8 MiB)
>           Interruption:11 Adresse de base:0xe000 
> 
> Thank you,
> -- 
> | Lucas Nussbaum
> | lucas@lucas-nussbaum.net    lnu@gnu.org    GPG: 1024D/023B3F4F |
> | jabber: lucas@linux.ensimag.fr   http://www.lucas-nussbaum.net |
> | fingerprint: 075D 010B 80C3 AC68 BD4F B328 DA19 6237 023B 3F4F |
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

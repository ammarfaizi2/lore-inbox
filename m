Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWHJRjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWHJRjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbWHJRjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:39:24 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5869 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1422651AbWHJRjX (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:39:23 -0400
Message-Id: <200608101738.k7AHcx9V004680@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       Thomas Graf <tgraf@suug.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - IPV6_MULTIPLE_TABLES borked....
In-Reply-To: Your message of "Sun, 06 Aug 2006 03:08:09 PDT."
             <20060806030809.2cfb0b1e.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1155231538_3998P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Aug 2006 13:38:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1155231538_3998P
Content-Type: text/plain; charset=us-ascii

On Sun, 06 Aug 2006 03:08:09 PDT, Andrew Morton said:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/

Building a kernel with IPV6_MULTIPLE_TABLES=y breaks my IPv6 connectivity
quite badly.  It basically totally refuses to answer an IPv6 Neighbor Solicit
packet or IPv6 Echo Request packet.  I run a 'tcpdump -n ipv6', and I see the
requests come in, and no packets leaving.  Interestingly enough, if I try to
ping6 *out* of the box, it's totally willing to send a Neighbor Solicit outbound
(although it appears to totally ignore the Neighbor Advert packet that comes
back). Of course, things don't work very well at all with busticated Neighbor
Solicit.

A kernel built with IPV6_MULTIPLE_TABLES=n works just fine.

The relevant ifconfig (eth3 is a 100mbit port, eth5 is a wireless card):

eth3      Link encap:Ethernet  HWaddr 00:06:5B:EA:8E:4E  
          inet addr:128.173.14.107  Bcast:128.173.15.255  Mask:255.255.252.0
          inet6 addr: 2001:468:c80:2103:206:5bff:feea:8e4e/64 Scope:Global
          inet6 addr: fe80::206:5bff:feea:8e4e/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:15529 errors:0 dropped:0 overruns:1 frame:0
          TX packets:2073 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:2333290 (2.2 MiB)  TX bytes:228862 (223.4 KiB)
          Interrupt:11 Base address:0x6800 

eth5      Link encap:Ethernet  HWaddr 00:02:2D:5C:11:48  
          inet addr:198.82.168.129  Bcast:198.82.168.255  Mask:255.255.255.0
          inet6 addr: 2001:468:c80:2181:202:2dff:fe5c:1148/64 Scope:Global
          inet6 addr: fe80::202:2dff:fe5c:1148/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2096 errors:0 dropped:0 overruns:0 frame:0
          TX packets:144 errors:1 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:280919 (274.3 KiB)  TX bytes:22184 (21.6 KiB)
          Interrupt:11 Base address:0xe100 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:1583 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1583 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:642598 (627.5 KiB)  TX bytes:642598 (627.5 KiB)

A working routing table:

netstat -r -n -A inet6
Kernel IPv6 routing table
Destination                                 Next Hop                                Flags Metric Ref    Use Iface
::1/128                                     ::                                      U     0      12       1 lo      
2001:468:c80:2103:206:5bff:feea:8e4e/128    ::                                      U     0      4        1 lo      
2001:468:c80:2103::/64                      ::                                      UA    256    113       0 eth3    
2001:468:c80:2181:202:2dff:fe5c:1148/128    ::                                      U     0      0        1 lo      
2001:468:c80:2181::/64                      ::                                      UA    256    11       0 eth5    
fe80::202:2dff:fe5c:1148/128                ::                                      U     0      0        1 lo      
fe80::206:5bff:feea:8e4e/128                ::                                      U     0      2        1 lo      
fe80::/64                                   ::                                      U     256    0        0 eth3    
fe80::/64                                   ::                                      U     256    0        0 eth5    
ff02::1/128                                 ff02::1                                 UC    0      113       0 eth3    
ff02::1/128                                 ff02::1                                 UC    0      1        0 eth5    
ff00::/8                                    ::                                      U     256    0        0 eth3    
ff00::/8                                    ::                                      U     256    0        0 eth5    
::/0                                        fe80::20f:35ff:fe3e:d41a                UGDA  1024   1        0 eth3    
::/0                                        fe80::20f:35ff:fe3e:d41a                UGDA  1024   1        0 eth5    



--==_Exmh_1155231538_3998P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE228ycC3lWbTT17ARAhscAJ9/RA53+ch/Lt8YOfleahwHmWMrlgCeOcIc
JlXBxM41kYlsfb4py+K4eHw=
=rpFI
-----END PGP SIGNATURE-----

--==_Exmh_1155231538_3998P--

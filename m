Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbULKPyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbULKPyj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 10:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbULKPyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 10:54:39 -0500
Received: from pop3.infonegocio.com ([213.4.129.150]:56024 "EHLO
	telesmtp3.mail.isp") by vger.kernel.org with ESMTP id S261953AbULKPy3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 10:54:29 -0500
Message-ID: <41BB186C.4000105@telefonica.net>
Date: Sat, 11 Dec 2004 16:55:24 +0100
From: =?ISO-8859-1?Q?Antonio_P=E9rez?= <aperlu@telefonica.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-net@vger.kernel.org
Subject: nat/masquerade with 2.6.x
References: <41BA0245.4050502@lougher.demon.co.uk> <20041211013323.GA12796@kroah.com> <41BA825F.9040509@lougher.demon.co.uk> <20041211153922.GA29523@kroah.com>
In-Reply-To: <20041211153922.GA29523@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have a local network with private directions, and a adsl conection. I 
want to do masquerade. Then I do:
   echo 1 > /proc/sys/net/ipv4/ip_forward
   iptables --table nat --append POSTROUTING --out-interface eth1 -j 
MASQUERADE
where eth1 is the interface conected to internet. This work perfectly 
with the kernels 2.4.x.
But one week ago I installed the kernel 2.6.8 and when I do :
   echo 1 > /proc/sys/net/ipv4/ip_forward
   iptables --table nat --append POSTROUTING --out-interface 
$ifc_internet -j MASQUERADE
the hosts of the internal network can do ping to internet, and this is 
normal, but they can not open any web or conection the msn , they
only can do ping. This is very stranger. I try the kernels 
2.6.7,2.6.7,2.6.8 and 2.6.9 and they do no work.

I know that the dns is working because when I do "ping www.google.es" 
from  internal host  this  work.
There are not other rules in the FORWARD chain, look:

   Chain INPUT (policy ACCEPT 2 packets, 100 bytes)
       pkts      bytes target     prot opt in     out     
source               destination

   Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
       pkts      bytes target     prot opt in     out     
source               destination

   Chain OUTPUT (policy ACCEPT 5958 packets, 2480411 bytes)
       pkts      bytes target     prot opt in     out     
source               destination

and if i do iptables -t nat -L -nvx, then:

   Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
       pkts      bytes target     prot opt in     out     
source               destination

   Chain POSTROUTING (policy ACCEPT 1 packets, 60 bytes)
       pkts      bytes target     prot opt in     out     
source               destination
          0        0 MASQUERADE  all  --  *      eth1    
0.0.0.0/0            0.0.0.0/0

   Chain OUTPUT (policy ACCEPT 1 packets, 60 bytes)
       pkts      bytes target     prot opt in     out     
source               destination

And this is all,
Can somebody help me, please?
Sorry for my bad english.

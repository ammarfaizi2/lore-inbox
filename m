Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280824AbRKYPUF>; Sun, 25 Nov 2001 10:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280823AbRKYPTu>; Sun, 25 Nov 2001 10:19:50 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:60556 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280867AbRKYPT1>; Sun, 25 Nov 2001 10:19:27 -0500
Subject: Re: Severe Linux 2.4 kernel memory leakage
From: Chris Chabot <chabotc@reviewboard.com>
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0111260210050.24725-100000@blackbird.intercode.com.au>
In-Reply-To: <Pine.LNX.4.31.0111260210050.24725-100000@blackbird.intercode.com.au>
Content-Type: multipart/mixed; boundary="=-sqXxG3nHlavvFG6/rXuF"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 25 Nov 2001 16:19:32 +0100
Message-Id: <1006701572.1316.0.camel@gandalf.chabotc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sqXxG3nHlavvFG6/rXuF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

nope, just plain netfilter/iptables. Specificly (lsmod output) :

ipt_TOS                  880   8  (autoclean)
ipt_MASQUERADE          1312   4  (autoclean)
ipt_state                576   7  (autoclean)
ipt_REJECT              2816   7  (autoclean)
ipt_LOG                 3408  24  (autoclean)
ipt_limit               1008  26  (autoclean)
ip_nat_ftp              3184   0  (unused)
ip_conntrack_ftp        3536   0  [ip_nat_ftp]
iptable_mangle          1712   0  (autoclean) (unused)
iptable_nat            14448   1  (autoclean) [ipt_MASQUERADE
ip_nat_ftp]
ip_conntrack           15056   5  (autoclean) [ipt_MASQUERADE ipt_state
ip_nat_ftp ip_conntrack_ftp iptable_nat]
iptable_filter          1680   0  (autoclean) (unused)
ip_tables              11392  11  [ipt_TOS ipt_MASQUERADE ipt_state
ipt_REJECT ipt_LOG ipt_limit iptable_mangle iptable_nat iptable_filter]

I've also attached the output of 'iptables -L -n' so u can get an idea
of what its running.

	-- Chris

On Sun, 2001-11-25 at 16:10, James Morris wrote:
> On 25 Nov 2001, Chris Chabot wrote:
> 
> > Also it has a (custom) iptables firewall script
> 
> Are you using ipchains emulation?
> 
> 
> - James
> -- 
> James Morris
> <jmorris@intercode.com.au>
> 


--=-sqXxG3nHlavvFG6/rXuF
Content-Disposition: attachment; filename=iptables-output.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

Chain INPUT (policy DROP)
target     prot opt source               destination        =20
CHECKFLAGS  tcp  --  0.0.0.0/0            0.0.0.0/0         =20
INETIN     all  --  0.0.0.0/0            0.0.0.0/0         =20
CHECKFLAGS  tcp  --  0.0.0.0/0            0.0.0.0/0         =20
INETIN     all  --  0.0.0.0/0            0.0.0.0/0         =20
ACCEPT     all  --  192.168.0.0/24       0.0.0.0/0         =20
ACCEPT     all  --  10.0.0.0/24          0.0.0.0/0         =20
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0         =20
UDPACCEPT  udp  --  0.0.0.0/0            0.0.0.0/0          udp dpt:67=20
UDPACCEPT  udp  --  0.0.0.0/0            0.0.0.0/0          udp dpt:67=20

Chain FORWARD (policy DROP)
target     prot opt source               destination        =20
ACCEPT     all  --  192.168.0.0/24       0.0.0.0/0         =20
ACCEPT     all  --  0.0.0.0/0            192.168.0.0/24    =20
ACCEPT     all  --  10.0.0.0/24          0.0.0.0/0         =20
ACCEPT     all  --  0.0.0.0/0            10.0.0.0/24       =20
TCPACCEPT  tcp  --  0.0.0.0/0            192.168.0.10       tcp dpt:80=20
TCPACCEPT  tcp  --  0.0.0.0/0            192.168.0.10       tcp dpt:80=20
TCPACCEPT  tcp  --  0.0.0.0/0            192.168.0.10       tcp dpt:443=20
TCPACCEPT  tcp  --  0.0.0.0/0            192.168.0.10       tcp dpt:443=20

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination        =20
INETOUT    all  --  0.0.0.0/0            0.0.0.0/0         =20
INETOUT    all  --  0.0.0.0/0            0.0.0.0/0         =20

Chain CHECKFLAGS (2 references)
target     prot opt source               destination        =20
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp flags:0x3F/=
0x29 limit: avg 1/sec burst 5 LOG flags 0 level 6 prefix `Posible NMAP-XMAS=
:'=20
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp flags:0x3F/=
0x29=20
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp flags:0x06/=
0x06 limit: avg 1/sec burst 5 LOG flags 0 level 6 prefix `Posible SYN/RST:'=
=20
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp flags:0x06/=
0x06=20
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp flags:0x03/=
0x03 limit: avg 1/sec burst 5 LOG flags 0 level 6 prefix `Posible SYN/FIN:'=
=20
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp flags:0x03/=
0x03=20
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp option=3D64=
 limit: avg 1/sec burst 5 LOG flags 0 level 6 prefix `Bogus TCP FLAG 64'=20
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp option=3D64=
=20
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp option=3D12=
8 limit: avg 1/sec burst 5 LOG flags 0 level 6 prefix `Bogus TCP FLAG 128'=20
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp option=3D12=
8=20
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:31337 l=
imit: avg 1/sec burst 5 LOG flags 0 level 6 prefix `Back Orifice:'=20
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:31337=20
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:20034 l=
imit: avg 1/sec burst 5 LOG flags 0 level 6 prefix `Back Orifice:'=20
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:20034=20
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp spt:27665 l=
imit: avg 1/sec burst 5 LOG flags 0 level 6 prefix `Trinoo:'=20
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp spt:27665=20
LOG        udp  --  0.0.0.0/0            0.0.0.0/0          udp dpt:27665 l=
imit: avg 1/sec burst 5 LOG flags 0 level 6 prefix `Trinoo:'=20
DROP       udp  --  0.0.0.0/0            0.0.0.0/0          udp dpt:27665=20
INETIN     all  --  0.0.0.0/0            0.0.0.0/0         =20

Chain INETIN (3 references)
target     prot opt source               destination        =20
LDROP      all  --  10.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  172.16.0.0/12        0.0.0.0/0         =20
LDROP      all  --  192.168.0.0/16       0.0.0.0/0         =20
LDROP      all  --  224.0.0.0/4          0.0.0.0/0         =20
LDROP      all  --  240.0.0.0/5          0.0.0.0/0         =20
LDROP      all  --  10.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  172.16.0.0/12        0.0.0.0/0         =20
LDROP      all  --  192.168.0.0/16       0.0.0.0/0         =20
LDROP      all  --  224.0.0.0/4          0.0.0.0/0         =20
LDROP      all  --  240.0.0.0/5          0.0.0.0/0         =20
LDROP      all  --  0.0.0.0/8            0.0.0.0/0         =20
LDROP      all  --  1.0.0.0/8            0.0.0.0/0         =20
LDROP      all  --  2.0.0.0/8            0.0.0.0/0         =20
LDROP      all  --  5.0.0.0/8            0.0.0.0/0         =20
LDROP      all  --  7.0.0.0/8            0.0.0.0/0         =20
LDROP      all  --  23.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  27.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  31.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  36.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  37.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  39.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  41.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  42.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  58.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  59.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  60.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  67.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  68.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  69.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  70.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  71.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  72.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  73.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  74.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  75.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  76.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  77.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  78.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  79.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  82.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  83.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  84.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  85.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  86.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  87.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  88.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  89.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  90.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  91.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  92.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  93.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  94.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  95.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  96.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  97.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  98.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  99.0.0.0/8           0.0.0.0/0         =20
LDROP      all  --  100.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  101.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  102.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  103.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  104.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  105.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  106.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  107.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  108.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  109.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  110.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  111.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  112.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  113.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  114.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  115.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  116.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  117.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  118.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  119.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  120.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  121.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  122.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  123.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  124.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  125.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  126.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  127.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  197.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  201.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  219.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  220.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  221.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  222.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  223.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  240.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  241.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  242.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  243.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  244.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  245.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  246.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  247.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  248.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  249.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  250.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  251.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  252.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  253.0.0.0/8          0.0.0.0/0         =20
LDROP      all  --  254.0.0.0/8          0.0.0.0/0         =20
TREJECT    all  --  0.0.0.0/0            0.0.0.0/0          state INVALID=20
UDPACCEPT  udp  --  194.109.137.130      0.0.0.0/0          udp dpt:53=20
TCPACCEPT  tcp  --  194.109.137.130      0.0.0.0/0          tcp dpt:53=20
UDPACCEPT  udp  --  194.109.137.130      0.0.0.0/0          udp dpt:53=20
TCPACCEPT  tcp  --  194.109.137.130      0.0.0.0/0          tcp dpt:53=20
UDPACCEPT  udp  --  213.84.192.197       0.0.0.0/0          udp dpt:53=20
TCPACCEPT  tcp  --  213.84.192.197       0.0.0.0/0          tcp dpt:53=20
UDPACCEPT  udp  --  213.84.192.197       0.0.0.0/0          udp dpt:53=20
TCPACCEPT  tcp  --  213.84.192.197       0.0.0.0/0          tcp dpt:53=20
UDPACCEPT  udp  --  63.117.39.22         0.0.0.0/0          udp dpt:53=20
TCPACCEPT  tcp  --  63.117.39.22         0.0.0.0/0          tcp dpt:53=20
UDPACCEPT  udp  --  63.117.39.22         0.0.0.0/0          udp dpt:53=20
TCPACCEPT  tcp  --  63.117.39.22         0.0.0.0/0          tcp dpt:53=20
ACCEPT     icmp --  0.0.0.0/0            0.0.0.0/0          icmp type 8 lim=
it: avg 1/sec burst 3=20
ACCEPT     icmp --  0.0.0.0/0            0.0.0.0/0          icmp !type 8=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:21=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:22=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:25=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:80=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:67=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:68=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:69=20
UDPACCEPT  udp  --  0.0.0.0/0            0.0.0.0/0          udp dpt:53=20
UDPACCEPT  udp  --  0.0.0.0/0            0.0.0.0/0          udp dpt:67=20
UDPACCEPT  udp  --  0.0.0.0/0            0.0.0.0/0          udp dpt:68=20
UDPACCEPT  udp  --  0.0.0.0/0            0.0.0.0/0          udp dpt:69=20
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0          state ESTABLISH=
ED=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpts:1024:6=
5535 state RELATED=20
UDPACCEPT  udp  --  0.0.0.0/0            0.0.0.0/0          udp dpts:1024:6=
5535 state RELATED=20
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0          state ESTABLISH=
ED=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpts:1024:6=
5535 state RELATED=20
UDPACCEPT  udp  --  0.0.0.0/0            0.0.0.0/0          udp dpts:1024:6=
5535 state RELATED=20
TREJECT    all  --  0.0.0.0/0            0.0.0.0/0         =20

Chain INETOUT (2 references)
target     prot opt source               destination        =20
LDROP      all  --  0.0.0.0/0            10.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            172.16.0.0/12     =20
LDROP      all  --  0.0.0.0/0            192.168.0.0/16    =20
LDROP      all  --  0.0.0.0/0            224.0.0.0/4       =20
LDROP      all  --  0.0.0.0/0            240.0.0.0/5       =20
LDROP      all  --  0.0.0.0/0            10.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            172.16.0.0/12     =20
LDROP      all  --  0.0.0.0/0            192.168.0.0/16    =20
LDROP      all  --  0.0.0.0/0            224.0.0.0/4       =20
LDROP      all  --  0.0.0.0/0            240.0.0.0/5       =20
LDROP      all  --  0.0.0.0/0            0.0.0.0/8         =20
LDROP      all  --  0.0.0.0/0            1.0.0.0/8         =20
LDROP      all  --  0.0.0.0/0            2.0.0.0/8         =20
LDROP      all  --  0.0.0.0/0            5.0.0.0/8         =20
LDROP      all  --  0.0.0.0/0            7.0.0.0/8         =20
LDROP      all  --  0.0.0.0/0            23.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            27.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            31.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            36.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            37.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            39.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            41.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            42.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            58.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            59.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            60.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            67.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            68.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            69.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            70.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            71.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            72.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            73.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            74.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            75.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            76.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            77.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            78.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            79.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            82.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            83.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            84.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            85.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            86.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            87.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            88.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            89.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            90.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            91.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            92.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            93.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            94.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            95.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            96.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            97.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            98.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            99.0.0.0/8        =20
LDROP      all  --  0.0.0.0/0            100.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            101.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            102.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            103.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            104.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            105.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            106.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            107.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            108.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            109.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            110.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            111.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            112.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            113.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            114.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            115.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            116.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            117.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            118.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            119.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            120.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            121.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            122.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            123.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            124.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            125.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            126.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            127.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            197.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            201.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            219.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            220.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            221.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            222.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            223.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            240.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            241.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            242.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            243.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            244.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            245.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            246.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            247.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            248.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            249.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            250.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            251.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            252.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            253.0.0.0/8       =20
LDROP      all  --  0.0.0.0/0            254.0.0.0/8       =20
UDPACCEPT  udp  --  0.0.0.0/0            194.109.137.130    udp spt:53=20
TCPACCEPT  tcp  --  0.0.0.0/0            194.109.137.130    tcp spt:53 flag=
s:!0x16/0x02=20
UDPACCEPT  udp  --  0.0.0.0/0            194.109.137.130    udp spt:53=20
TCPACCEPT  tcp  --  0.0.0.0/0            194.109.137.130    tcp spt:53 flag=
s:!0x16/0x02=20
UDPACCEPT  udp  --  0.0.0.0/0            213.84.192.197     udp spt:53=20
TCPACCEPT  tcp  --  0.0.0.0/0            213.84.192.197     tcp spt:53 flag=
s:!0x16/0x02=20
UDPACCEPT  udp  --  0.0.0.0/0            213.84.192.197     udp spt:53=20
TCPACCEPT  tcp  --  0.0.0.0/0            213.84.192.197     tcp spt:53 flag=
s:!0x16/0x02=20
UDPACCEPT  udp  --  0.0.0.0/0            63.117.39.22       udp spt:53=20
TCPACCEPT  tcp  --  0.0.0.0/0            63.117.39.22       tcp spt:53 flag=
s:!0x16/0x02=20
UDPACCEPT  udp  --  0.0.0.0/0            63.117.39.22       udp spt:53=20
TCPACCEPT  tcp  --  0.0.0.0/0            63.117.39.22       tcp spt:53 flag=
s:!0x16/0x02=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp spt:21=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp spt:22=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp spt:25=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp spt:80=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp spt:67=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp spt:68=20
TCPACCEPT  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp spt:69=20
UDPACCEPT  udp  --  0.0.0.0/0            0.0.0.0/0          udp spt:53=20
UDPACCEPT  udp  --  0.0.0.0/0            0.0.0.0/0          udp spt:67=20
UDPACCEPT  udp  --  0.0.0.0/0            0.0.0.0/0          udp spt:68=20
UDPACCEPT  udp  --  0.0.0.0/0            0.0.0.0/0          udp spt:69=20
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0         =20

Chain LDROP (214 references)
target     prot opt source               destination        =20
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 6 prefix `TCP Dropped '=20
LOG        udp  --  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 6 prefix `UDP Dropped '=20
LOG        icmp --  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 6 prefix `ICMP Dropped '=20
LOG        all  -f  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 4 prefix `FRAGMENT Dropped '=20
DROP       all  --  0.0.0.0/0            0.0.0.0/0         =20

Chain LREJECT (0 references)
target     prot opt source               destination        =20
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 6 prefix `TCP Rejected '=20
LOG        udp  --  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 6 prefix `UDP Rejected '=20
LOG        icmp --  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 6 prefix `ICMP Dropped '=20
LOG        all  -f  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 4 prefix `FRAGMENT Rejected '=20
REJECT     all  --  0.0.0.0/0            0.0.0.0/0          reject-with icm=
p-port-unreachable=20

Chain LTREJECT (0 references)
target     prot opt source               destination        =20
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 6 prefix `TCP Rejected '=20
LOG        udp  --  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 6 prefix `UDP Rejected '=20
LOG        icmp --  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 6 prefix `ICMP Dropped '=20
LOG        all  -f  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 4 prefix `FRAGMENT Rejected '=20
REJECT     tcp  --  0.0.0.0/0            0.0.0.0/0          reject-with tcp=
-reset=20
REJECT     udp  --  0.0.0.0/0            0.0.0.0/0          reject-with icm=
p-port-unreachable=20
DROP       icmp --  0.0.0.0/0            0.0.0.0/0         =20
REJECT     all  --  0.0.0.0/0            0.0.0.0/0          reject-with icm=
p-port-unreachable=20

Chain TCPACCEPT (32 references)
target     prot opt source               destination        =20
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0          tcp flags:0x16/=
0x02 limit: avg 40/sec burst 5=20
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp flags:0x16/=
0x02 limit: avg 1/sec burst 5 LOG flags 0 level 4 prefix `Possible SynFlood=
 '=20
TREJECT    tcp  --  0.0.0.0/0            0.0.0.0/0          tcp flags:0x16/=
0x02=20
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0          tcp flags:!0x16=
/0x02=20
LOG        all  --  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 4 prefix `Mismatch in TCPACCEPT '=20
TREJECT    all  --  0.0.0.0/0            0.0.0.0/0         =20

Chain TREJECT (5 references)
target     prot opt source               destination        =20
REJECT     tcp  --  0.0.0.0/0            0.0.0.0/0          reject-with tcp=
-reset=20
REJECT     udp  --  0.0.0.0/0            0.0.0.0/0          reject-with icm=
p-port-unreachable=20
DROP       icmp --  0.0.0.0/0            0.0.0.0/0         =20
REJECT     all  --  0.0.0.0/0            0.0.0.0/0          reject-with icm=
p-port-unreachable=20

Chain UDPACCEPT (24 references)
target     prot opt source               destination        =20
ACCEPT     udp  --  0.0.0.0/0            0.0.0.0/0         =20
LOG        all  --  0.0.0.0/0            0.0.0.0/0          limit: avg 1/se=
c burst 5 LOG flags 0 level 4 prefix `Mismatch on UDPACCEPT '=20
TREJECT    all  --  0.0.0.0/0            0.0.0.0/0         =20

--=-sqXxG3nHlavvFG6/rXuF--


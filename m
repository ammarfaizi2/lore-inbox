Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTJDPic (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 11:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTJDPic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 11:38:32 -0400
Received: from CPE-203-51-31-218.nsw.bigpond.net.au ([203.51.31.218]:7675 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S262656AbTJDPiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 11:38:25 -0400
Message-ID: <3F7EE96C.4AC99553@eyal.emu.id.au>
Date: Sun, 05 Oct 2003 01:38:20 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa2 - some problems [with patches]
References: <20031004105731.GA1343@velociraptor.random>
Content-Type: multipart/mixed;
 boundary="------------45B61698F112B57B572E781B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------45B61698F112B57B572E781B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This is most unusual as -aa patches usually apply clean, but I am
encountering a number of build problems.

"PCMCIA SCSI adapter support" build is broken. I deselected the whole
section.

I now have this failure:

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
-Wstrict-
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-poi
nter -pipe -msoft-float -mpreferred-stack-boundary=2 -march=i686
-malign-functio
ns=4 -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-aa/inclu
de/linux/modversions.h  -nostdinc -iwithprefix include
-DKBUILD_BASENAME=ip_vs_c
onn  -c -o ip_vs_conn.o ip_vs_conn.c
ip_vs_conn.c: In function `ip_vs_tunnel_xmit':
ip_vs_conn.c:895: too many arguments to function
`ip_select_ident_Rd603b6c5'
make[2]: *** [ip_vs_conn.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/net/ipv4/ipvs'

Seems that ip_select_ident() only wants the first argument.


Next I get

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
-Wstrict-
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-poi
nter -pipe -msoft-float -mpreferred-stack-boundary=2 -march=i686
-malign-functio
ns=4 -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-aa/inclu
de/linux/modversions.h  -nostdinc -iwithprefix include
-DKBUILD_BASENAME=addrcon
f  -c -o addrconf.o addrconf.c
addrconf.c: In function `ipv6_store_devconf':
addrconf.c:1996: structure has no member named `rtr_solicit_interval'
addrconf.c:1997: structure has no member named `rtr_solicit_delay'
make[2]: *** [addrconf.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/net/ipv6'

I think that these members were renamed, my patch is just a guess.


Next
gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
-Wstrict-
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-poi
nter -pipe -msoft-float -mpreferred-stack-boundary=2 -march=i686
-malign-functio
ns=4 -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-aa/inclu
de/linux/modversions.h  -nostdinc -iwithprefix include
-DKBUILD_BASENAME=protoco
l  -c -o protocol.o protocol.c
protocol.c: In function `sctp_v4_create_accept_sk':
protocol.c:537: structure has no member named `id'
make[2]: *** [protocol.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/net/sctp'

Member .id was removed, so my patch removes the offending line (a
guess).


Finally I get
if [ -r System.map ]; then /sbin/depmod -ae -F System.map 
2.4.23-pre6-aa2; fi
depmod: /lib/modules/2.4.23-pre6-aa2/ksyms is not an ELF file
depmod: /lib/modules/2.4.23-pre6-aa2/soundconf is not an ELF file
depmod: *** Unresolved symbols in
/lib/modules/2.4.23-pre6-aa2/kernel/drivers/vi
deo/sis/sisfb.o
depmod:         __floatsidf
depmod:         __divdf3
depmod:         __fixunsdfsi
depmod:         __muldf3
depmod:         __adddf3

And building i2c-2.7.0 (which I need for sensors) is failing.

depmod: *** Unresolved symbols in
/lib/modules/2.4.23-pre6-aa2/kernel/drivers/ie
ee1394/pcilynx.o
depmod:         i2c_bit_add_bus_Rca543f36
depmod:         i2c_transfer_R1dea91d1
depmod:         i2c_bit_del_bus_Rdf920b11
depmod: *** Unresolved symbols in
/lib/modules/2.4.23-pre6-aa2/kernel/drivers/me
dia/video/bttv.o
depmod:         i2c_bit_add_bus_Rca543f36
depmod:         i2c_master_recv_R67b29cc4
depmod:         i2c_bit_del_bus_Rdf920b11
depmod:         i2c_master_send_Rb692cb0e
depmod: *** Unresolved symbols in
/lib/modules/2.4.23-pre6-aa2/kernel/drivers/me
dia/video/msp3400.o
depmod:         i2c_probe_R4e2acbec
depmod:         i2c_add_driver_Racf22304
depmod:         i2c_transfer_R1dea91d1
depmod:         i2c_attach_client_Ra861362d
depmod:         i2c_master_send_Rb692cb0e
depmod:         i2c_detach_client_R0cfb40b4
depmod:         i2c_del_driver_R57837012
.... more following, all in  kernel/drivers/media/video/* ...

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------45B61698F112B57B572E781B
Content-Type: text/plain; charset=us-ascii;
 name="2.4.23-pre6-aa2.ip_vs_conn.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.23-pre6-aa2.ip_vs_conn.patch"

--- linux/net/ipv4/ipvs/ip_vs_conn.c.orig	Sun Oct  5 01:14:39 2003
+++ linux/net/ipv4/ipvs/ip_vs_conn.c	Sun Oct  5 01:15:12 2003
@@ -892,7 +892,7 @@
 	iph->saddr		=	rt->rt_src;
 	iph->ttl		=	old_iph->ttl;
 	iph->tot_len		=	htons(skb->len);
-	ip_select_ident(iph, &rt->u.dst, NULL);
+	ip_select_ident(iph);
 	ip_send_check(iph);
 
 	skb->ip_summed = CHECKSUM_NONE;

--------------45B61698F112B57B572E781B
Content-Type: text/plain; charset=us-ascii;
 name="2.4.23-pre6-aa2.addrconf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.23-pre6-aa2.addrconf.patch"

--- linux/net/ipv6/addrconf.c.orig	Sun Oct  5 01:20:38 2003
+++ linux/net/ipv6/addrconf.c	Sun Oct  5 01:21:24 2003
@@ -1993,8 +1993,8 @@
 	array[DEVCONF_AUTOCONF] = cnf->autoconf;
 	array[DEVCONF_DAD_TRANSMITS] = cnf->dad_transmits;
 	array[DEVCONF_RTR_SOLICITS] = cnf->rtr_solicits;
-	array[DEVCONF_RTR_SOLICIT_INTERVAL] = cnf->rtr_solicit_interval;
-	array[DEVCONF_RTR_SOLICIT_DELAY] = cnf->rtr_solicit_delay;
+	array[DEVCONF_RTR_SOLICIT_INTERVAL] = cnf->__rtr_solicit_interval;
+	array[DEVCONF_RTR_SOLICIT_DELAY] = cnf->__rtr_solicit_delay;
 #ifdef CONFIG_IPV6_PRIVACY
 	array[DEVCONF_USE_TEMPADDR] = cnf->use_tempaddr;
 	array[DEVCONF_TEMP_VALID_LFT] = cnf->temp_valid_lft;

--------------45B61698F112B57B572E781B
Content-Type: text/plain; charset=us-ascii;
 name="2.4.23-pre6-aa2.protocol.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.23-pre6-aa2.protocol.patch"

--- linux/net/sctp/protocol.c.orig	Sun Oct  5 01:30:01 2003
+++ linux/net/sctp/protocol.c	Sun Oct  5 01:30:13 2003
@@ -534,7 +534,6 @@
 	newsk->dport = htons(asoc->peer.port);
 	newsk->daddr = asoc->peer.primary_addr.v4.sin_addr.s_addr;
 	newinet->pmtudisc = inet->pmtudisc;
-      	newinet->id = 0;
 
 	newinet->ttl = sysctl_ip_default_ttl;
 	newinet->mc_loop = 1;

--------------45B61698F112B57B572E781B--


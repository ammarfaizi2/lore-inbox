Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286802AbRLVPtb>; Sat, 22 Dec 2001 10:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286804AbRLVPtU>; Sat, 22 Dec 2001 10:49:20 -0500
Received: from dsl-213-023-060-147.arcor-ip.net ([213.23.60.147]:25094 "HELO
	spot.local") by vger.kernel.org with SMTP id <S286802AbRLVPtJ>;
	Sat, 22 Dec 2001 10:49:09 -0500
Date: Sat, 22 Dec 2001 16:51:21 +0100
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: excessive "svc: bad direction 65537, dropping request" with 2.4.17
Message-ID: <20011222165121.A19282@gmxpro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.16 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I have the following problem since 2.4.17 on my laptop with a PC-Card
network card. When something is sent over the network the kernel prints

"kernel: svc: bad direction 65537, dropping request"

into the syslog and the network stops working. It does start to work again 
after some time. This happenes without any scheme, but frequently when trying 
to access NFS mounts.

Dec 22 16:23:18 sneaky kernel: nfs: server spot not responding, still trying
Dec 22 16:23:44 sneaky kernel: svc: bad direction 65537, dropping request
Dec 22 16:23:47 sneaky kernel: nfs: server spot OK
Dec 22 16:23:49 sneaky kernel: svc: bad direction 65537, dropping request
Dec 22 16:23:58 sneaky last message repeated 3 times

	What is this message about and what triggers it? I found some 
occurences of this in the lkml archive. Like 
http://lists.kernelnotes.de/linux-kernel/Week-of-Mon-20011008/044888.html but 
this does not apply to this.

	I became aware of this problem with 2.4.17, however there is also a 
syslog entry with the very same message when the system was running 2.4.16. 
But with .17 I get the error quite frequently and the network stops working.

	The network card running in the system (if the driver might be the 
problem) is identified as 

Dec 22 16:21:52 sneaky kernel: tulip.c:v0.91g-ppc 7/16/99 becker@scyld.com (modi
fied by danilo@cs.uni-magdeburg.de for XIRCOM CBE, fixed by Doug Ledford)
Dec 22 16:21:52 sneaky kernel: eth0: ADMtek Centaur-C rev 17 at 0x200, 
00:E0:98:96:88:DC, IRQ 11.

	by the kernel. I'm running with pcmcia-cs 3.1.30 that loads the 
following modules:

Module                  Size  Used by
nfs                    69008   1  (autoclean)
lockd                  45904   1  (autoclean) [nfs]
sunrpc                 58208   1  (autoclean) [nfs lockd]
tulip_cb               31872   2 
cb_enabler              2528   2  [tulip_cb]
ds                      6672   1  [cb_enabler]
i82365                 22256   1 
pcmcia_core            41440   0  [cb_enabler ds i82365]
nls_iso8859-1           2880   1  (autoclean)
nls_cp437               4384   1  (autoclean)
vfat                    9264   1  (autoclean)
fat                    29120   0  (autoclean) [vfat]

	I would be glad for any hints. If you need more details about the 
system I'll provide it. Um... help? :)

Bye

Oliver


-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/

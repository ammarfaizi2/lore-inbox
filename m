Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRCTXfQ>; Tue, 20 Mar 2001 18:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRCTXfH>; Tue, 20 Mar 2001 18:35:07 -0500
Received: from umail.unify.com ([204.163.170.2]:29372 "EHLO umail.unify.com")
	by vger.kernel.org with ESMTP id <S129143AbRCTXex>;
	Tue, 20 Mar 2001 18:34:53 -0500
Message-ID: <419E5D46960FD211A2D5006008CAC79902E5C135@pcmailsrv1.sac.unify.com>
From: "Manuel A. McLure" <mmt@unify.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: NETDEV WATCHDOG: eth0: transmit timed out on LNE100TX 4.0,  k
	ernel2.4.2-ac11 and earlier.
Date: Tue, 20 Mar 2001 15:33:37 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd looked for changes in tulip between 2.4.2-ac11 and 2.4.2-ac20 and hadn't
seen any - that's why I hadn't updated. I gather that the change in question
is at a higher level?

Anyway, I've upgraded to 2.4.2-ac20 and now I still get the error messages:

Mar 20 14:35:52 ulthar kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar 20 14:35:52 ulthar kernel: eth0: Transmit timed out, status fc664010,
CSR12
00000000, resetting...

but instead of hanging completely the connection just gets extremely slow
and "bursty" as shown by the following fragment of ping output:

64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=8 ttl=255
time=130 usec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=9 ttl=255
time=358 usec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=10 ttl=255
time=6.000 sec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=4 ttl=255
time=12.001 sec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=12 ttl=255
time=1.000 sec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=13 ttl=255
time=368 usec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=14 ttl=255
time=361 usec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=15 ttl=255
time=395 usec

So the behavior is quite a bit better (at least I can telnet in to
ifdown/ifup) but still not OK. Once again, ifdown/ifup makes things work OK.

Thanks!
--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Space Ghost: "Hey, what happened to the-?" Moltar: "It's out." SG: "What
about-?" M: "It's fixed." SG: "Eh, good. Good."




"Jeff Garzik" wrote:
> "Manuel A. McLure" wrote:
> > 
> > System:
> > AMD Athlon Thunderbird 900MHz
> > MSI K7T Pro (VIA KT133 chipset)
> > Network card: Linksys LNE100TX Rev. 4.0 (tulip)
> > Kernel: 2.2.18 (with 0.92 Scyld drivers), 2.4.0, 2.4.1, 
> 2.4.2, 2.4.2-ac11
> > 
> > With all the above kernel revisions/drivers, my network 
> card hangs at random
> > (sometimes within minutes, other times it takes days). To 
> restart it I need
> > to do an ifdown/ifup cycle and it will work fine until the 
> next hang. I
> > upgraded to 2.4.2-ac11 because of the documented tulip 
> fixes, but after a
> > few days got this again. The error log shows:
> 
> In Alan Cox terms, that's a long time ago :)
> 
> Can you please try 2.4.2-ac20?  It includes fixes 
> specifically for this
> problem.

I'd looked for changes in tulip between 2.4.2-ac11 and 2.4.2-ac20 and hadn't
seen any - that's why I hadn't updated. I gather that the change in question
is at a higher level?

Anyway, I've upgraded to 2.4.2-ac20 and now I still get the error messages:

Mar 20 14:35:52 ulthar kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar 20 14:35:52 ulthar kernel: eth0: Transmit timed out, status fc664010,
CSR12
00000000, resetting...

but instead of hanging completely the connection just gets extremely slow
and "bursty" as shown by the following fragment of ping output:

64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=8 ttl=255
time=130 usec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=9 ttl=255
time=358 usec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=10 ttl=255
time=6.000 sec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=4 ttl=255
time=12.001 sec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=12 ttl=255
time=1.000 sec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=13 ttl=255
time=368 usec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=14 ttl=255
time=361 usec
64 bytes from leng.internal.mclure.org (10.1.1.1): icmp_seq=15 ttl=255
time=395 usec

So the behavior is quite a bit better (at least I can telnet in to
ifdown/ifup) but still not OK. Once again, ifdown/ifup makes things work
fine until the problem starts again.

Thanks!
--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Space Ghost: "Hey, what happened to the-?" Moltar: "It's out." SG: "What
about-?" M: "It's fixed." SG: "Eh, good. Good."

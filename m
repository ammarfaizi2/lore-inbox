Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131728AbRC3XPz>; Fri, 30 Mar 2001 18:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131726AbRC3XPp>; Fri, 30 Mar 2001 18:15:45 -0500
Received: from umail.unify.com ([204.163.170.2]:56567 "EHLO umail.unify.com")
	by vger.kernel.org with ESMTP id <S131722AbRC3XP0>;
	Fri, 30 Mar 2001 18:15:26 -0500
Message-ID: <419E5D46960FD211A2D5006008CAC79902E5C165@pcmailsrv1.sac.unify.com>
From: "Manuel A. McLure" <mmt@unify.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.4.3 fails to compile
Date: Fri, 30 Mar 2001 15:14:11 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Fri, 30 Mar 2001, Manuel A. McLure wrote:
> 
> > Jeff Garzik wrote:
> > > On Fri, 30 Mar 2001, Manuel A. McLure wrote:
> > > 
> > > > ...
> > > > gcc -D__KERNEL__ -I/usr/src/linux/include -Wall 
> > > -Wstrict-prototypes -O2
> > > > -fomit-frame-pointer -fno-strict-aliasing -pipe 
> > > -mpreferred-stack-boundary=2
> > > > -march=athlon  -DMODULE -DMODVERSIONS -include
> > > > /usr/src/linux/include/linux/modversions.h   -c -o buz.o buz.c
> > > > buz.c: In function `v4l_fbuffer_alloc':
> > > > buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in 
> this function)
> > > > buz.c:188: (Each undeclared identifier is reported only once
> > > > buz.c:188: for each function it appears in.)
> > > 
> > > Easy solution -- just delete the entire test
> > > 
> > > 	if (size > KMALLOC_MAXSIZE) {
> > > 		...
> > > 	}
> > 
> > Thanks, I'll do that. It just seemed strange that the file was being
> > compiled in the first place when the config option was not set.
> 
> buz is built with CONFIG...ZORAN as well as CONFIG...BUZ.  I dunno if
> that's a bug or not...

Yeah - I figured that out. I found that there were many places where
KMALLOC_MAXSIZE was being used in buz.c so I removed CONFIG...ZORAN and the
kernel is working now.

It looks like the tulip driver isn't as up-to-date as the one from
2.4.2-ac20 - when is 2.4.3-ac1 due? :-) I got NETDEV WATCHDOG errors shortly
after rebooting with 2.4.3, although these were of the "slow/packet lossy"
type I got with 2.4.2-ac20 instead of the "network completely unusable" type
I got with 2.4.2-ac11 and earlier.

--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Space Ghost: "Hey, what happened to the-?" Moltar: "It's out." SG: "What
about-?" M: "It's fixed." SG: "Eh, good. Good."

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317696AbSGaNfU>; Wed, 31 Jul 2002 09:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318371AbSGaNfU>; Wed, 31 Jul 2002 09:35:20 -0400
Received: from sunny.pacific.net.au ([203.25.148.40]:25294 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S317696AbSGaNfU>; Wed, 31 Jul 2002 09:35:20 -0400
From: "David Luyer" <david@luyer.net>
To: "'Dana Lacoste'" <dana.lacoste@peregrine.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
Date: Wed, 31 Jul 2002 23:38:41 +1000
Message-ID: <00c901c23897$9593e530$638317d2@pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <1028122277.13632.3.camel@dlacoste.ottawa.loran.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana Lacoste wrote:
> On Wed, 2002-07-31 at 13:59, David Luyer wrote:
> >   printf("%d\n", sysconf(_SC_NPROCESSORS_CONF));
> > }
> > luyer@praxis8:~$ ./cpus
> > 4
> 
> I ran your test program on a Compaq DL360 and an IBM x330
> and both showed '2' for the CPU count (2.4.18 stock, glibc 2.2.3)
> 
> Just a point of reference to help narrow the problem area down :)

Yes, the problem is in the -ac train only.  It's the "processor id"
field that has been added to /proc/cpuinfo which is confusing libc's
way of counting CPUs.

That's a libc bug.  But there's also a kernel bug with that field
it appears.

The kernel bug: the "processor id" fields are both printing zero.

Possibly because show_cpuinfo() in arch/i386/kernel/setup.c prints
directly out of phys_proc_id as at the time it's called, but
smpboot.c declates phys_proc_id as __initdata (either that, or
phys_proc_id is actually zero for both CPUs?).

David.
--
David Luyer                                     Phone:   +61 3 9674 7525
Network Development Manager    P A C I F I C    Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T   Mobile:  +61 4 1111 BYTE
http://www.pacific.net.au/                      NASDAQ:  PCNTF


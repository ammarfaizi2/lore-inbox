Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUF2WU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUF2WU0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 18:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbUF2WU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 18:20:26 -0400
Received: from burro.logi-track.com ([213.239.193.212]:20879 "EHLO
	mail.logi-track.com") by vger.kernel.org with ESMTP id S266117AbUF2WUR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 18:20:17 -0400
Date: Wed, 30 Jun 2004 00:20:14 +0200
From: Markus Schaber <schabios@logi-track.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Block Device Caching
Message-Id: <20040630002014.4970b82d@kingfisher.intern.logi-track.com>
Organization: logi-track ag, =?ISO-8859-15?Q?z=FCrich?=
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: Nx5T&>Nj$VrVPv}sC3IL&)TqHHOKCz/|)R$i"*r@w0{*I6w;UNU_hdl1J4NI_m{IMztq=>cmM}1gCLbAF+9\#CGkG8}Y{x%SuQ>1#t:;Z(|\qdd[i]HStki~#w1$TPF}:0w-7"S\Ev|_a$K<GcL?@F\BY,ut6tC0P<$eV&ypzvlZ~R00!A
X-PGP-Key: http://schabi.de/pubkey.asc
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

During our application testing, we noticed that our application (that
operates directly on a LVM volume) we noticed that it seems the read
data does not go into any cache.

Now we did some tests using dd blocksize=1M count=1000:

Using dd directly on the /dev/daten/testing lvm volume, we read about 95
MBytes/Seconds. Issuing multiple dds in sequence gives little variance in IO
speed (between 90 and 100 MB/sec).

When we create a file system on this volume, and mount it, and we create
a 1G file there, the dd gives us the same 95 MB/sec on the first read
after the mount, and approx. 480 MB/Sec on subsequent reads.

The machine runs Kernel 2.6.5 SMP on a dual SMT Itanium HP Box.

This lead us to the conclusion that block devices do not cache, but the
filesystem does. But subsequently, I ran some tests on my developer
machine (Pentium 4 Mobile Laptop).

dd'ing 16MB from an usb 1.1 stick present as /dev/sda, I got about
900k/sec on every read, so this seems to be uncached access, too.

When dd'ing 100MB from /dev/hda5, the first read gives about
22MBytes/Sek (which seems okay for a 2.5" IDE Disk), but subsequend
reads give about 389MBytes/sek (which is impossible to achieve using
such hardware). Interestingly, this happens on a mounted partition,
while when unmounting the partition, caching does not work. But for the
/dev/daten/testing above, mounting a filesystem on the partition does
not help in caching.

Can anyone give us a hint what's happening here, or even tell us how to
use a block device via the kernel caching (and memory mapping does not
work easily, as the production lvm volume is about 600 Gig on said
32-bit X86 machine.

Thanks,
Markus

PS: I subscribed to the list, so no Cc:-ing required.
-- 
markus schaber | dipl. informatiker
logi-track ag | rennweg 14-16 | ch 8001 zürich
phone +41-43-888 62 52 | fax +41-43-888 62 53
mailto:schabios@logi-track.com | www.logi-track.com

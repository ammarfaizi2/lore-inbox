Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132187AbRBKKpd>; Sun, 11 Feb 2001 05:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132152AbRBKKpX>; Sun, 11 Feb 2001 05:45:23 -0500
Received: from fungus.teststation.com ([212.32.186.211]:37083 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S132191AbRBKKpF>; Sun, 11 Feb 2001 05:45:05 -0500
Date: Sun, 11 Feb 2001 11:45:02 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Kaj-Michael Lang <milang@tal.org>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: VIA Rhine on Alpha bug
In-Reply-To: <000f01c09268$ee56e4a0$56dc10c3@tal.org>
Message-ID: <Pine.LNX.4.30.0102111017190.22121-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Kaj-Michael Lang wrote:

> I don't know if it should work or not but using a VIA Rhine compatible card
> on my LX164 locks it solid when transfering large packets:
> ping -f host.on.100mbit.lan works
> ping -f -s 1024 same.host locks it solid as does
> untarring to a NFS mount.

I have seen at least one similar report of nfs/large ping problems with
the via-rhine. The other report was x86 so it is probably not alpha
specific (if it should work ... that's another thing).

Personally I have not seen (or been able to create) anything like this.

What kernel version are you running? If you are not using the latest try
that first. I would try 2.4.1-ac9 (or 2.2.19preX if you use 2.2, but there
is a fix in "ac9" that is not in the 2.2 driver).


To help debug this you could try:

Enable SysRq if you haven't already (Documentation/sysrq.txt does not
mention alpha ...). Run the ping-test on the console (not X).

SysRq-P will dump register contents (eip and stacktrace on x86, only pc on
alpha?) that can be written down (pc only) and compared with your
System.map. It may be possible to guess where the driver is looping
(assuming it is) by getting a few register dumps. If it is looping it
should repeat itself (with an address that points to the via-rhine driver,
decoding the address is easier if the driver is not compiled as a module).

Test SysRq-P before doing the ping-test to make sure it works.


The driver takes a debug flag, which defaults to 1. If you load the driver
as a module set "options via-rhine debug=?" in /etc/modules.conf where ?
is some value between 1 and 7.

SysRq-8 makes kernel debug messages appear on the console.

The output may aid narrowing it down, for example if it prints that it 
enters the interrupt handler but never exits.


And then there is of course the possibility of hardware bugs ...

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

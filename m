Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWHVT0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWHVT0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWHVT0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:26:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:24136 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751201AbWHVT0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:26:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:content-type:mime-version:content-transfer-encoding:message-id:user-agent:from;
        b=HNKlZBbYpe06Kb9r2EgSmXzzoAp38iqW/85jungixhVvPkBtapFQIiboN6Yp5Lfd6wOoZNrYkwx4KBxLfIsFl5Bv5X7mfv98R96fr+/dEK72U5Akryopaz6jwWUwybOdFnmPIZ6BrzL5I615CF2HGkBc3KqU5xZCyIWYrBr+p4Q=
Date: Tue, 22 Aug 2006 21:26:40 +0200
To: linux-kernel@vger.kernel.org
Subject: Specify devices manually in exotic environment
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-ID: <op.teo9mqjlepq0rv@localhost>
User-Agent: Opera Mail/9.00 (Linux)
From: Milan Hauth <milahu@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there.

Got a quite exotic environment here -- a Compaq Evo T20 thin client, which  
I want to run Linux on.

But I'm not satisfied with a completely thin client, meaning that all the  
files are located on the server. What I want is the basic system to be  
located on the client, while the Unix System Resources, for example, are  
mounted from the server, since they're too big for 32MB of Flash memory.

The problem I'm facing at the moment is the T20's BIOS, which doesn't seem  
to pass the device information correctly to the Kernel. GRUB (v0.97) does  
work with a workaround, which can be found in the document [1] I followed  
to 'teach' Linux to the T20.

I already tried to use /proc/sys/kernel/real-root-dev, but setting the  
root device to 0x80 (as already specified for GRUB) or 0x81 (1st partition  
of 0x80) did not seem to help.

So, did I forget anything when building my Kernel? Or is it just another  
trick, I don't know yet?

Hopefully someone here can help me on this one.. have been 'working' on my  
cute T20 for several months now.. :-\

Cheers, milahu


[1] http://www.kazak.ws/evo/


PS: Here's my linuxrc:

#!/bin/sh
mount -v -t proc proc /proc
echo 0x80 >/proc/sys/kernel/real-root-dev
mount -o remount,rw /
exec chroot . sh <<- EOF
     <dev/console >dev/console 2>&1
     exec /sbin/init
EOF
--
proc on /proc type proc (rw)
mount: can't find / in /etc/fstab or /etc/mtab
INIT: version 2.86 booting
INIT: No inittab file found

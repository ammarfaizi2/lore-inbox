Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131629AbRDCMRA>; Tue, 3 Apr 2001 08:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbRDCMQu>; Tue, 3 Apr 2001 08:16:50 -0400
Received: from exchruhydro.sw.ru ([195.16.40.3]:5 "EHLO exchruhydro.sw.com.sg")
	by vger.kernel.org with ESMTP id <S130470AbRDCMQr>;
	Tue, 3 Apr 2001 08:16:47 -0400
Message-ID: <3AC9BF03.AC0A6661@infratel.com>
Date: Tue, 03 Apr 2001 16:16:04 +0400
From: Vladimir Serov <vserov@infratel.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.2-ac28 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-arm-kernel@lists.arm.linux.org.uk
Subject: 2.4.2,3 nbd problem, works OK in 2.4.2-ac20,28
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I'm working on remote disks and swap for Strong ARM based board similar
to Brutus eval board (using usbnet Ethernet-over-USB driver).  And i've
got problems with Network block device (nbd) i'm using to mount devices
exported from host computer.  Every program trying access /dev/nbd0
after it was connected by nbd-client stops in D state.

My first thought was it's ARM specific, but later i found this problem
persists when using my host PC as client too.  I've compiled nbd.o and
nbd-server (latest from cvs) with debug options turned on and use
"strace cat /dev/nd0" to see where it stuck. It looks like nbd actually
gets first page (4k) of data in several packets but user space doesn't
get this data and read system call does never return (this is the case
for 2.4.2-rmk1-np3 at least). I got this problem on 2.4.2-rmk1-np1,
2.4.2-rmk1-np3, 2.4.3 with Russell Kings patch for 2.4.3-pre7 kernels on
ARM and vanilla 2.4.2 and 2.4.3 kernels on ix86.

BUT !!!! 2.4.2-ac20,28 works fine on ix86 !!!!  Possibly main branch
doesn't get updated.
Unfortunately the details of handling these requests aren't clear for me
and it's not simple to use Alan Cox patches on ARM cause there not
supported by Russell King and other people in ARM community (I mean no
patches again -acxx kernels) and i'm already overloaded by various beta
and alpha software.

Any help will be appreciated !!!
Thanks in advance.

Vladimir.

PS. sorry for bad english, it' my second language.


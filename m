Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVLAX4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVLAX4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 18:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVLAX4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 18:56:04 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:7340 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932271AbVLAX4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 18:56:03 -0500
Subject: 2.6.15-rc4 RTC problems
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 15:56:14 -0800
Message-Id: <1133481374.21429.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am having troubles booting my 8-way P-III machine.
On boot it hangs in init script boot.clock.
It prints,

"Setting up the CMOS clock"

and hangs. So I disabled that script and brought up
the machine and ran command manually. It looks like
it waits forever to read from /dev/rtc.

Is this a known issue ? How do I fix the problem ?

Thanks,
Badari

# strace /sbin/hwclock --adjust -u
....
....
open("/dev/rtc", O_RDONLY|O_LARGEFILE)  = 3
close(3)                                = 0
stat64("/etc/adjtime", {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
open("/etc/adjtime", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
mmap2(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x40186000
read(3, "0.288490 1133479037 0.000000\n113"..., 131072) = 44
close(3)                                = 0
munmap(0x40186000, 131072)              = 0
open("/dev/rtc", O_RDONLY|O_LARGEFILE)  = 3
ioctl(3, RTC_UIE_ON, 0)                 = 0
read(3, <unfinished ...>



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267979AbUI1Qld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267979AbUI1Qld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 12:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267985AbUI1Qlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 12:41:32 -0400
Received: from ig2.scea.com ([160.33.44.35]:60393 "EHLO ig2.scea.com")
	by vger.kernel.org with ESMTP id S267979AbUI1Ql3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 12:41:29 -0400
Message-ID: <41599434.7010300@san.rr.com>
Date: Tue, 28 Sep 2004 09:41:24 -0700
From: Mark Jacob <mjacob1@san.rr.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Reboot while processing gunzip() in decompress_kernel()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Reboot while processing gunzip() in decompress_kernel()
2. System reboots when calling gunzip() from
linux-2.4.27/arch/i386/boot/compressed/misc.c:decompress_kernel()
3. i386 boot
4. vanilla 2.4.27 (also tried with vanilla 2.4.24, same result)
5. No Oops output.
6. N/A
7.1 ver_linux output from the machine I build the kernel on:
Linux mythical 2.4.27 #2 SMP Sun Aug 22 21:56:02 PDT 2004 i686 i686 i386 
GNU/Linux

Gnu C                  3.3.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.25
e2fsprogs              1.34
jfsutils               1.1.3
reiserfsprogs          3.6.8
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.17
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         ivtv msp3400 saa7115 tuner i2c-algo-bit videodev 
i2c-core nfsd lockd sunrpc autofs e100 microcode nls_iso8859-1 jfs loop 
ext3 jbd lvm-mod

7.2 Can't get at the /proc/cpuinfo since the system won't boot. The 
system is a diskless Via EPIA M6000 mini-itx system with 128 MB RAM. 
 From what I remember it's a pentium clone. It network boots with PXE 
and syslinux, and pulls the compressed kernel in via tftp.

7.3 No modules.
7.4 No loaded drivers.
7.5 Can't boot system to get lspci -vvv
7.6 No SCSI

I've tracked it to the call to gunzip() in decompress_kernel() by moving 
a while(1); loop around in the code. Placing the while(1); before the 
call to gunzip keeps the machine from rebooting and causes a hang as 
expected. Moving the while(1) loop reverts it back to an infinite reboot 
cycle.

I've only found two recent list threads that describe similar problems, 
but the solutions did not work for me. One of them is here:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=120685

And the other is here:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.3/0639.html

Here's the rub. I have a similar VIA EPIA M10000 setup and the kernel 
boots! Thinking that the problem was CPU specific, I trimmed down the 
CPU type to plain old i386 in the kernel config file. Alas, this did not 
help. :( I've also verified that I'm running the latest BIOS firmware 
(the M10K and the M6K are both flashed to the same bios rev). Lastly, I 
know for sure that it's not a firmware issue because the precompiled 
kernel provided by the linpvr project 
(http://www.linpvr.org/dl.php?filename=rel-0.5.1/bzImage) boots the M6K 
board with no issues. Please help!

Thank You,
Mark Jacob

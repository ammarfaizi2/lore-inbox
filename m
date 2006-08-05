Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422761AbWHEI1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422761AbWHEI1J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 04:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422764AbWHEI1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 04:27:09 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:55465 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S1422761AbWHEI1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 04:27:08 -0400
Date: Sat, 5 Aug 2006 10:23:21 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Suspend on Dell D420
Message-ID: <20060805082321.GB27129@uio.no>
References: <20060804162300.GA26148@uio.no> <200608042327.38280.rjw@sisk.pl> <20060804151758.1d3dd6bd.akpm@osdl.org> <200608050126.57060.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200608050126.57060.rjw@sisk.pl>
X-Operating-System: Linux 2.6.16trofastxen on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.12-2006-07-14
X-Spam-Score: -2.6 (--)
X-Spam-Report: Status=No hits=-2.6 required=5.0 tests=AWL,BAYES_00,NO_RELAYS version=3.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 01:26:56AM +0200, Rafael J. Wysocki wrote:
> Because the non-boot CPUs are taken off early, before anything else, and the
> system is effectively non-SMP during the entire suspend-resume cycle
> (well, almost).  If SMP-related things go wrong during the suspend, CPU
> hotplug is the first suspect. ;-)

Well, it seems to work fine during the suspend phase, at least, and it also
seems to work well during normal use:

fugl:~# echo 0 > /sys/devices/system/cpu/cpu1/online 
fugl:~# echo 1 > /sys/devices/system/cpu/cpu1/online 

FWIW, there is an error in dmesg afterwards, though:

===
CPU 1 is now offline
SMP alternatives: switching to UP code
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 2394.85 BogoMIPS (lpj=4789709)
CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Genuine Intel(R) CPU           U2500  @ 1.20GHz stepping 08
APIC error on CPU1: 00(40)
===

No idea whether it's related. FWIW, resume didn't work with maxcpus=1 on boot
either, so I'm not really sure how related it is.

/* Steinar */
-- 
Homepage: http://www.sesse.net/

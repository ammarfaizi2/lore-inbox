Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263993AbTJ1PLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 10:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTJ1PLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 10:11:16 -0500
Received: from mail.g-housing.de ([62.75.136.201]:19877 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263993AbTJ1PLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 10:11:13 -0500
Message-ID: <3F9E7900.8060008@g-house.de>
Date: Tue, 28 Oct 2003 15:11:12 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030924 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ppc32 lockups with 2.6 (maybe network related)
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moin,


i have problems with my ppc32 (PReP) machine and 2.6.0-test* kernels.
since this is some kind of home "server", i did not test any ealier 
versions, but 2.6.0-test{7|8|9}. all show the same behaviour, somewhere 
during the bootup, the machine just freezes. i found out, that upon 
configuring my thernet devices the lockups occur.

so, i have 2 network cards, both are working under 2.4 with the 3c59x 
(eth0) and tulip (eth1, it's an on-board 21140).

loading the drivers by using insmod / modprobe succeeds, the driver 
registers, some messages are printed.

e.g.

Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:00:04.0 (0000 -> 0003)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media AUI (#2) described by a 21140 non-MII (0) block.
tulip0:  Index #1 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #8 config 3100 status 786b advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0x1800, 08:00:3E:29:0B:B6, IRQ 9.

or

3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
0000:00:06.0: 3Com PCI 3c905C Tornado at 0x1000. Vers LK1.1.19
  00:01:02:f1:83:37, IRQ 11
   product code 464a rev 00.13 date 11-12-00
   Internal config register is 1800000, transceivers 0xa.
   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
   MII transceiver found at address 24, status 782d.
   Enabling bus-master transmits and whole-frame receives.
0000:00:06.0: scatter/gather enabled. h/w checksums enabled


"ifconfig eth0" gives then an unconfigured eth0, ok. but using "ifconfig 
eth0 192.168.1.1" results in a lockup. no oops printed, no SysReq anymore.

i tried with the "tulip" modul first, and could "strace" the ifconfig, 
until it freezes.

    http://nerdbynature.de/bits/sheep/network/ifc-tulip.log

the 3c59x module however acted somehow differently: upon using "ifconfig 
eth0 192.168.1.1" the screen filled with strange chars in some pattern, 
i've never seen before on a linux box (no, i was clean :-)) (ok, the 
pattern is probably not important, but it's on [1] anyway) then, the 
system locked up too.

as you can see (http://nerdbynature.de/bits/sheep/network/config) i have 
then compiled some debug options into the kernel, i loaded the 3c59x 
module with "debug=6". also, i want to say that this is not my first 
build of a 2.6 kernel, i have a i386 running pretty stable with 2.6 for 
weeks now; some time ago i used to have an Alpha (AXP) with 2.5.x 
running 24x7.

please let me know, i have forgotten something or where to look further.
i will be glad to help with running tests and the like.

i don't suspect hw errors here, because both cards are happy working 
under 2.4.

some details about the PrEP machine:
[1] http://nerdbynature.de/bits/

Thank you,
Christian.


-- 
BOFH excuse #396:

Mail server hit by UniSpammer.


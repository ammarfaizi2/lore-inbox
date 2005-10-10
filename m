Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVJJTfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVJJTfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 15:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVJJTfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 15:35:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:9371 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751126AbVJJTfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 15:35:13 -0400
X-Authenticated: #4395837
Message-ID: <434AC26F.9050007@gmx.de>
Date: Mon, 10 Oct 2005 21:35:11 +0200
From: Cornelius Thiele <thielec@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20051008)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Dual Xeon Time skips with 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we have a dual xeon 3,0ghz system with hyperthreading running here with 
kernel 2.6.13 / 2.6.12 and are experiencing time skips. Meaning, when 
you enter 'date' in the shell the result will be different depending on 
which cpu the command is scheduled. The longer the system is up the 
greater the difference. The increase is approximately 5 minutes per day; 
as you can probably imagine this adds up to quite a lot over weeks and 
screws up our logging and any other program that needs timing or writes 
timestamp to disk somewhere.

$> / # dmesg | grep time
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 3000.236 MHz processor.
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
time.c: Using PIT/TSC based timekeeping.

[ ... w/o bogomips and pci timing... ]

The CPUs seem to be put in sync only at system startup:

dmesg | grep TSC
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 142 cycles, maxerr 1267 
cycles)
[... for CPU1-4 ...]

but they drift apart quite heavily after that.

The server runs on a Tyan Mainboard, I'd be happy to provide any more 
infos if needed or try out some things, because we really need to have a 
server with only _one_ system time :)

Greetings,
	Cornelius Thiele

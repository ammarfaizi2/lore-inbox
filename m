Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVJJTwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVJJTwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 15:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVJJTwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 15:52:12 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7462 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751181AbVJJTwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 15:52:12 -0400
Date: Mon, 10 Oct 2005 13:55:27 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Dual Xeon Time skips with 2.6
In-reply-to: <4WbFk-3iC-33@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <434AC72F.8070701@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4WbFk-3iC-33@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cornelius Thiele wrote:
> Hello,
> 
> we have a dual xeon 3,0ghz system with hyperthreading running here with 
> kernel 2.6.13 / 2.6.12 and are experiencing time skips. Meaning, when 
> you enter 'date' in the shell the result will be different depending on 
> which cpu the command is scheduled. The longer the system is up the 
> greater the difference. The increase is approximately 5 minutes per day; 
> as you can probably imagine this adds up to quite a lot over weeks and 
> screws up our logging and any other program that needs timing or writes 
> timestamp to disk somewhere.
> 
> $> / # dmesg | grep time
> time.c: Using 3.579545 MHz PM timer.
> time.c: Detected 3000.236 MHz processor.
> Using local APIC timer interrupts.
> Detected 12.500 MHz APIC timer.
> time.c: Using PIT/TSC based timekeeping.
> 
> [ ... w/o bogomips and pci timing... ]
> 
> The CPUs seem to be put in sync only at system startup:
> 
> dmesg | grep TSC
> CPU 1: Syncing TSC to CPU 0.
> CPU 1: synchronized TSC with CPU 0 (last diff 142 cycles, maxerr 1267 
> cycles)
> [... for CPU1-4 ...]
> 
> but they drift apart quite heavily after that.
> 
> The server runs on a Tyan Mainboard, I'd be happy to provide any more 
> infos if needed or try out some things, because we really need to have a 
> server with only _one_ system time :)

You can probably avoid this problem by using "notsc" on the kernel 
command line. It would seem that somehow the TSC drift is too small for 
the kernel to notice on boot, but causes problems anyway..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


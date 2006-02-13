Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWBMHBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWBMHBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBMHBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:01:36 -0500
Received: from fsmlabs.com ([168.103.115.128]:28368 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750997AbWBMHBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:01:36 -0500
X-ASG-Debug-ID: 1139814082-17577-18-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sun, 12 Feb 2006 23:05:59 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: 2.6.16-rc2, x86-64, CPU hotplug failure
Subject: Re: 2.6.16-rc2, x86-64, CPU hotplug failure
In-Reply-To: <200602130230.41120.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0602122223290.10777@montezuma.fsmlabs.com>
References: <200602130230.41120.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.8651
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Alistair John Strachan wrote:

> In an attempt to play with ACPI S3 on my Athlon 64 X2 3800+, I recompiled 
> 2.6.16-rc2 with CPU hotplug and ACPI sleep state support. I experienced 
> multiple crashes and oopsen, which I quickly discovered were the result of 
> bringing at least one CPU back online.
> 
> echo 0 >> /sys/devices/system/cpu/cpu1/online
> 
> Works, but then if I try to do:
> 
> echo 1 >> /sys/devices/system/cpu/cpu1/online
> 
> I get an oops. Unfortunately this board has no serial ports so I've taken a 
> digital camera shot of the oops. From dmesg, I'm using the PM timer.
> 
> [alistair] 02:13 [~] dmesg | egrep time\.c
> time.c: Using 3.579545 MHz PM timer.
> time.c: Detected 2500.768 MHz processor.
> time.c: Using PM based timekeeping.
> 
> http://devzero.co.uk/~alistair/oops-20060213/

Nice snapshot, that bug was fixed around 2.6.16-rc3, unsynchronized_tsc 
was marked __init instead of __cpuinit

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTIJKbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbTIJKbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:31:50 -0400
Received: from luli.rootdir.de ([213.133.108.222]:26542 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S261473AbTIJKbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:31:48 -0400
Date: Wed, 10 Sep 2003 12:31:42 +0200
From: Claas Langbehn <claas@rootdir.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew de Quincey <adq@lidskialf.net>, acpi-devel@lists.sourceforge.net
Subject: [2.6.0-test5-mm1] Suspend to RAM problems
Message-ID: <20030910103142.GA1053@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-By: Sat Sep 13 12:15:02 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test4-mm4 i686
X-No-archive: yes
X-Uptime: 12:15:02 up  2:10,  7 users,  load average: 0.97, 0.55, 0.27
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have got kernel 2.6.0-test5-mm1 on an Epox 8k9a9i Mainboard with
KT400A and an Nvidia FX5200 using the nvidia-module and drivers.
I use only onboard IDE and onboard ethernet.

I want to be able to use Suspend to RAM with my machine. I tried
APM and ACPI, both with no success. I also tried with no X11.


1.) APM:   (ACPI follows...)
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)

Sep 10 12:02:55 localhost apmd[441]: Suspending now
Sep 10 12:02:55 localhost kernel: hdc: start_power_step(step: 0)
Sep 10 12:02:55 localhost kernel: hdc: completing PM request, suspend
Sep 10 12:02:55 localhost kernel: hda: start_power_step(step: 0)
Sep 10 12:02:55 localhost kernel: hda: start_power_step(step: 1)
Sep 10 12:02:55 localhost kernel: hda: complete_power_step(step: 1, stat: 50, err: 0)
Sep 10 12:02:59 localhost kernel: hda: completing PM request, suspend
Sep 10 12:03:00 localhost kernel: hda: Wakeup request inited, waiting for !BSY...
Sep 10 12:03:00 localhost kernel: hda: start_power_step(step: 1000)
Sep 10 12:03:00 localhost kernel: blk: queue dfe03e00, I/O limit 4095Mb (mask 0xffffffff)
Sep 10 12:03:00 localhost kernel: hda: completing PM request, resume
Sep 10 12:03:00 localhost kernel: hdc: Wakeup request inited, waiting for !BSY...
Sep 10 12:03:00 localhost kernel: hdc: start_power_step(step: 1000)
Sep 10 12:03:00 localhost kernel: hdc: completing PM request, resume

I pressed the power button at the machines case, but it comes back to
life straight away. I also tried with apm --verbose --suspend and --standby,
but with no change.


2) ACPI
Thanks to Andrew de Quincey I can boot with ACPI without
problems and I can read out my temp and so on, but when I do
   echo -n "mem" >/sys/power/state 
the machine goes into sleep (STR) but crashes after waking up again.
And an
   echo -n "S3" > /proc/acpi/sleep 
doesn't work at all.
Also pressing the power button has NO effect. I think
it does not generate an event.


3) Questions
What can I do to get STR working straight?
Are these some stupid non-powersaving-aware drivers?
What makes my system wake up from apm suspend? How to debug?
I can see the CPU temp with ACPI, but how do I see the case temp?
Do I need to change things in the system BIOS or does linux ignore that?



Bye, claas

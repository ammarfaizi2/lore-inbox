Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265070AbTIJPgQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbTIJPgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:36:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:64681 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265070AbTIJPgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:36:00 -0400
Date: Wed, 10 Sep 2003 08:33:21 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Claas Langbehn <claas@rootdir.de>
cc: <linux-kernel@vger.kernel.org>, Andrew de Quincey <adq@lidskialf.net>,
       <acpi-devel@lists.sourceforge.net>
Subject: Re: [2.6.0-test5-mm1] Suspend to RAM problems
In-Reply-To: <20030910103142.GA1053@rootdir.de>
Message-ID: <Pine.LNX.4.33.0309100829470.1012-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have got kernel 2.6.0-test5-mm1 on an Epox 8k9a9i Mainboard with
> KT400A and an Nvidia FX5200 using the nvidia-module and drivers.
> I use only onboard IDE and onboard ethernet.
> 
> I want to be able to use Suspend to RAM with my machine. I tried
> APM and ACPI, both with no success. I also tried with no X11.

> 1.) APM:   (ACPI follows...)
> apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)

It's likely that if your system supports ACPI, the APM implementation will 
not work, especially if you boot with ACPI enabled. 

> 2) ACPI
> Thanks to Andrew de Quincey I can boot with ACPI without
> problems and I can read out my temp and so on, but when I do
>    echo -n "mem" >/sys/power/state 
> the machine goes into sleep (STR) but crashes after waking up again.

What exactly does it do on wakeup? 

Would you please try the patch at: 

http://developer.osdl.org/~mochel/patches/test5-pm1/test5-pm2.diff.bz2

against 2.6.0-test5 and report whether or not it works? 

Also, please try removing all modules before suspending and reinserting 
them after resuming. 

Do you have any of the following enabled: 

SMP?

Preempt?

APIC? 


> And an
>    echo -n "S3" > /proc/acpi/sleep 

That should be:

	echo "3" > /proc/acpi/sleep

But, please use the sysfs interface. 


Thanks,


	Pat


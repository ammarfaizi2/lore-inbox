Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271652AbRIDPND>; Tue, 4 Sep 2001 11:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271705AbRIDPMn>; Tue, 4 Sep 2001 11:12:43 -0400
Received: from bgm-24-95-140-16.stny.rr.com ([24.95.140.16]:55548 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S271652AbRIDPMc>; Tue, 4 Sep 2001 11:12:32 -0400
Date: Tue, 4 Sep 2001 11:17:28 -0400 (EDT)
From: Steven Rostedt <rostedt@stny.rr.com>
X-X-Sender: <rostedt@localhost.localdomain>
Reply-To: Steven Rostedt <srostedt@stny.rr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: bug in 2.4.9 - ACPI driver
Message-ID: <Pine.LNX.4.33.0109041106350.18927-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just traced down a bug in the acpi driver.
I have a toshiba 2805-S402 laptop and I just
got a bug crash.

The interrupt handler in drivers/acpi/ospm/ec/ecgpe.c: ec_gpe_handler
calls acpi_os_queue_for_execution
in  drivers/acpi/os.c which calls acpi_os_callocate
which eventually calls kmalloc with the GFP_KERNEL flag.
This of course should not be called like this in an
interrupt handler!

I currently changed the allocate to use the GFP_ATOMIC instead,
but this acpi_os_callocate and acpi_os_allocate are used
else where, and I don't think this is a proper fix.
there probably should be some sort of acpi_os_allocate_int
and acpi_os_callocate_int for interrupts to use, but
I'm not familiar enough with this driver to know what
to touch.

cheers,

-- Steve.



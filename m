Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbTKEShM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbTKEShM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:37:12 -0500
Received: from web11304.mail.yahoo.com ([216.136.131.207]:7186 "HELO
	web11304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263090AbTKEShH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:37:07 -0500
Message-ID: <20031105183611.86413.qmail@web11304.mail.yahoo.com>
Date: Wed, 5 Nov 2003 10:36:11 -0800 (PST)
From: Alex Deucher <agd5f@yahoo.com>
Subject: Re: Suspend and AGP in 2.6.0-test9
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See these pages:
http://cpbotha.net/dri_resume.html

you will need a patch for your agp chipset as well, although it seems
just re-running the configure() call should work, at least so the page
claims for intel and via chips.

Alex

------------------------------

Hi!

2.6.0-test9 is the first kernel with *almost* working suspend to ram
and suspend to disk.

Well, almost, because when i run X with AGP support enabled i can't
resume - either it hangs forever after displaying "Waiting for DMAs to
settle down..." message or it reboots right after displaying it.
When i force using of PCI bus for acceleration, then suspend (to ram as
well as to disk) with resume works perfectly - but of course, with
disabled
agp everything is significantly slower.

So, my question is - is it known (and not fixable :) bug or it's
something weird and shouldn't happen ? As fair as I googled for similar
problems I have found that people usually have problems with DRI, it
looks
like agp works ok for most of them :) However, on my laptop disabling
DRI doesn't help.

I have Dell Lattitude D600 with:
- ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
- Intel Corp. 82855PM Processor to AGP Controllerntel Corp. 82855PM
- Latest BIOS (A06)

Here is full output from dmesg, lspci and my current kernel config:

http://student.uci.agh.edu.pl/~fahren/dmesg
http://student.uci.agh.edu.pl/~fahren/lspci
http://student.uci.agh.edu.pl/~fahren/config.gz


I've tried both 2.6.0-test9 and 2.6.0-test9-mm1 with:
- XFree's radeon drivers (from XFree86's cvs) -
As i already wrote, everything work ok untill i load intel-agp
module (or don't force "BusType" to "PCI" in XF86Config) - enabling/
disabling DRI doesn't seem to affect anything.

- ATI's fglrx drivers (ver. 3.2.8) - the same, with enabled
"UseInternalAGPGART" i can't resume. When disabled and without loaded
intel-agp module i can.

I'm suspending by writing to /proc/acpi/sleep - writing to
/sys/power/state returns nice "call trace" screen.
On older versions of kernel (<= 2.6.0-test8*) suspend just doesn't work
- /proc/acpi/sleep behaves like /dev/null :)

If anyone know sollution for it *please* let me know. :>

BTW, standby mode doesn't work at all (and never had on 2.6.0-test* for
me, with 2.4 it is ok) - it goes to sleep, but when resuming it hangs
after displaying "PM: Finishing up."


Maciej Freudenheim.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@xxxxxxxxxxxxxxx
More majordomo info at http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.tux.org/lkml/

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131937AbQKZAUS>; Sat, 25 Nov 2000 19:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132015AbQKZAUI>; Sat, 25 Nov 2000 19:20:08 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:24984 "EHLO
        horus.its.uow.edu.au") by vger.kernel.org with ESMTP
        id <S131937AbQKZATs>; Sat, 25 Nov 2000 19:19:48 -0500
Message-ID: <3A20501E.32EEB3C8@uow.edu.au>
Date: Sun, 26 Nov 2000 10:49:50 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <Pine.LNX.3.96.1001124183828.385A-100000@sneaker.sch.bme.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice report.  Wish they were all like that.

Look:

"Mr. Big" wrote:
> 
> I thought that the khttpd is guilty, I won't use it anymore. Next morning
> it crashed again, now without khttpd, without high load, without high
> memory usage, just the 3Com driver said:
> kernel: eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is caused by the APIC(s) forgetting how to deliver interrupts
for a particular IRQ.  Normally, reloading the driver doesn't help.
But in your case it did.  This is odd.

It looks like the same thing is happening with the eepro NIC as
well.  But the eepro diagnostics aren't as informative when this
happens.

This can normally be prevented by booting with the `noapic' option
on the LILO command line.

So I suggest you stick with the 3c905C and boot with `noapic'.  Try
the eepro as well - it may well work fine with the APIC disabled.

You may also get some benefit from running:

# echo "512 1024 1536" > /proc/sys/vm/freepages

after booting.  The default values are a little too low for
applications which are very network intensive.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

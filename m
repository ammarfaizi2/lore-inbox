Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbWDMXW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWDMXW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWDMXW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:22:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:23761 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965040AbWDMXW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:22:27 -0400
Date: Fri, 14 Apr 2006 01:22:23 +0200 (CEST)
From: Bernhard Kaindl <bk@suse.de>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.1 crashing all the time
In-Reply-To: <20060330064014.2AF0112674C@dungeon.inka.de>
Message-ID: <Pine.LNX.4.64.0604140038160.18866@jbgna.fhfr.qr>
References: <20060330064014.2AF0112674C@dungeon.inka.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Andreas Jellinghaus wrote:
> 
> on a laptop, screen turns white. nothing in the log, no serial port, 

You could try to use the OHCI1394-compatible Firewire controller in
your laptop to read the dmesg at the time of the crash directly from
memory using ftp://ftp.suse.com/pub/people/ak/firescope

What you need for that in addition is a second computer which is connected
over a firewire cable at the time of the crash. Should this be the only
computer with Firewire which you have, you can find a Linux-compatible
card (only needs to be OHCI1394-compatible) in online shops in Germany
for about 10 Euro, a single OHCI1394-compatible Firewire Cardbus card
which works under Linux is auctioned for 8,88 Euro at this moment.

> and netconsole does not help either.

If it locks up hard, it may well be that firescope is the only feasible
way to read the kernel messages. But I can't give you a guarantee.

> but: 2.6.16+xen-unstable is 100% stable. so I'm posting lspci -vvv

There is only one lspci -vvv: It may be different between xen and vanilla.

> maybe someone can give me a hint which options could be related to the
> problem.

You could have provided a "diff -u" beween the configs and the dmesgs,
then people would have seen some things quite quickly. I noticed:

Xen uses ACPI very differently, you could try booting with some of the ACPI
boot options in Documentation/{kernel-parameters,x86_64/boot-options}.txt

Also APIC may possibly play a role, see e.g. this part of the dmesg diff:

-Kernel command line: root=/dev/hda1 ro                  (vanilla)
+Kernel command line: root=/dev/hda1 ro noapictimer      (Xen)

Related to that:
-.MP-BIOS bug: 8254 timer not connected to IO-APIC
- failed.
- works.
-Using local APIC timer interrupts.
-result 12436871
-Detected 12.436 MHz APIC timer.
-testing NMI watchdog ... OK.

These are only generic stupid hints, I'm not expert in such crashes.

If you get it to work, it would be good if you report the details
including which Laptop it is here.

Bernhard

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUASNu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbUASNu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:50:26 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:20568 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265063AbUASNuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:50:21 -0500
Subject: Re: APM and ACPI sleep issues with 2.6
From: Ross Burton <ross@burtonini.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040105140057.096c77f9.sfr@canb.auug.org.au>
References: <1073232351.21389.111.camel@localhost>
	 <20040105140057.096c77f9.sfr@canb.auug.org.au>
Content-Type: text/plain
Message-Id: <1074520065.32688.9.camel@carados.180sw.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 19 Jan 2004 13:47:45 +0000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2004 13:50:39.0872 (UTC) FILETIME=[39427000:01C3DE93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-05 at 03:00, Stephen Rothwell wrote:
> > With 2.6.1-rc1-mm, when I shut the lid with APM enabled nothing
> > happens.  No messages on the console, nothing.
> 
> Can you try booting with apm=debug and see if you get any messages
> when you shut the lid.

Sorry for the long delay...

hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
hda: Wakeup request inited, waiting for !BSY...
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
hda: start_power_step(step: 1000)
hda: completing PM request, resume
PCI: Found IRQ 5 for device 0000:00:1f.5
PCI: Sharing IRQ 5 with 0000:00:1f.3
PCI: Sharing IRQ 5 with 0000:02:03.1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49401 usecs
intel8x0: clocking to 48000
request_module: failed /sbin/modprobe -- snd-card-1. error = 256
request_module: failed /sbin/modprobe -- snd-card-1. error = 256
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on

Looks like e100 (network) and intel8x0 (sound) recovered okay.  The
second time I shut the lid, when I opened it the keyboard had locked up.

I've been told that building 2.6.1-mm4, making i8042 and atkdb modules
and unloading them before sleeping should fix this problem.  Is that the
blessed solution?  Unloading the modules for the keyboard controller
does seem a little too much like brute-force for me, especially since
2.4.x managed fine. :)

Thanks,
Ross
-- 
Ross Burton                                 mail: ross@burtonini.com
                                          jabber: ross@burtonini.com
                                     www: http://www.burtonini.com./
 PGP Fingerprint: 1A21 F5B0 D8D0 CFE3 81D4 E25A 2D09 E447 D0B4 33DF


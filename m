Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268713AbUJTRIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268713AbUJTRIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUJTRG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:06:59 -0400
Received: from bender.bawue.de ([193.7.176.20]:6289 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S268565AbUJTRC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:02:27 -0400
Date: Wed, 20 Oct 2004 18:54:08 +0200
From: Joerg Sommrey <jo175@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.9: io conflict between w83627hf_wdt and parport_pc
Message-ID: <20041020165408.GA5872@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo175@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the w83627hf WDT is no longer working on 2.6.9. The module refuses to
load with an error message:
|WDT driver for the Winbond(TM) W83627HF Super I/O chip initialising.
|w83627hf WDT: I/O address 0x002e already in use

/proc/ioports reports:
|002e-0030 : winbond_check

I found this function in parport_pc.  After unloading parport_pc,
w83627hf_wdt still refuses to load:
|jo@bear:/usr/src/linux-2.6.9:0$ sudo modprobe w83627hf_wdt
|FATAL: Error inserting w83627hf_wdt (/lib/modules/2.6.9/kernel/drivers/char/watchdog/w83627hf_wdt.ko): Input/output error

And I'm even unable to inspect /proc/ioports now:
|jo@bear:/usr/src/linux-2.6.9:0$ cat /proc/ioports
|Segmentation fault

Everything worked perfect with 2.6.8.1 and 2.6.9-rc4-mm1
The box is a Tyan MPX S2466 w/ 2x Athlon MP 2000+.

-jo

-- 
-rw-r--r--  1 jo users 63 2004-10-20 18:32 /home/jo/.signature

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTEYKgI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 06:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTEYKgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 06:36:07 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:30850 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261775AbTEYKgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 06:36:07 -0400
Date: Sun, 25 May 2003 12:49:14 +0200 (MEST)
Message-Id: <200305251049.h4PAnEIB028846@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: Valdis.Kletnieks@vt.edu
Subject: Re: [RFC] Fix NMI watchdog documentation
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 May 2003 23:29:15 -0400, Valdis.Kletnieks@vt.edu wrote:
>CONFIG_X86_UP_APIC=y
>CONFIG_X86_UP_IOAPIC=y
>CONFIG_X86_LOCAL_APIC=y
>CONFIG_X86_IO_APIC=y
>
>but 'dmesg' on my Dell Latitude C840 laptop tells me:
>
>Dell Latitude with broken BIOS detected. Refusing to enable the local APIC.
>
>Is this nmi_watchdog="forget about it dave" time, or is there some way to
>get this to work?

The blacklist rule treats all Latitudes the same, since most of
them are broken. Your C840 may or may not actually work. Simply
remove the blacklist entry in dmi_scan.c and run some tests:
- does it hang at boot?
- does the kernel fail to enable the local APIC? (it's HW absent
  in many mobile CPUs)
- does it hang when the power cord is attached or detached?
- does it hang when the BIOS setup hotkey is pressed?
  (Fn-F1 on my ancient Latitude, may be different now)
- does it hang under long periods of heavy load?
- does it hang when idle for a long time?
- does it hang at suspend or resume?

If it survives these tests, with nmi_watchdog=0 and =2, then
please tell us about it so we can white-list this particular model.

/Mikael

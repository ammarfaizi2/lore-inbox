Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129306AbRA3Lc4>; Tue, 30 Jan 2001 06:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129360AbRA3Lcq>; Tue, 30 Jan 2001 06:32:46 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:21352 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S129306AbRA3Lck>; Tue, 30 Jan 2001 06:32:40 -0500
Date: Tue, 30 Jan 2001 22:47:02 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Stephen Rothwell <sfr@linuxcare.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.2.18: apm initialised before dmi_scan?
Message-ID: <Pine.LNX.4.05.10101302229400.12161-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Looking more closely at a 2.2.18 bootup tonight I see that apm stuff
appears in dmesg before dmi_scan does (I added "#define DUMP_DMI" in
dmi_scan.c).

If this implies that apm is initialised *before* the dmi_scan then there
is potentially a problem with buggy BIOSen that oops instead of reporting
power status, given:

* passing the boot-parameter apm=debug causes a power status report as apm
is initialised

* dmi_scan is identifying at least one machine that oopses when the power
status report BIOS call is invoked.

... so with a buggy BIOS and "apm=debug" it's vital that the dmi_scan is
completed *before* apm is initialised - which is not what I am seeing with
2.2.18 (nor can I see where the order of such things is set).  The test
would be to boot a buggy Dell with "apm=debug" (and "#define DUMP_DMI" in
dmi_scan.c - but if my theory is right it won't get that far) and watch
for smoke leakage.

I think it's obvious that this would all go away if apm is a module (as it
can be with 2.4).

Regards,
Neale.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTEYKhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 06:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTEYKhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 06:37:24 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:44930 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261797AbTEYKhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 06:37:21 -0400
Date: Sun, 25 May 2003 12:50:28 +0200 (MEST)
Message-Id: <200305251050.h4PAoSoG028882@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: lkml@sigkill.net
Subject: Re: [RFC] Fix NMI watchdog documentation
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 May 2003 01:52:16 -0400, Disconnect <lkml@sigkill.net> wrote:
>I was reading that code the other day (just out of curiosity, believe it
>or not) and I'm wondering how recently that has been tested - most of
>the blacklist/oddness workarounds listed in dmi_scan.c are
>model-specific, but the APIC entry is any Dell Inspiron or Latitude.  
>
>I'm going to remove the test tomorrow sometime and see what happens -
>lots has changed since the Inspiron 8000, including a migration to
>p4-mobile, so its worth seeing if the newer Dells are fixed.  If so,
>I'll submit a patch to make that more model-specific (probably I'll just
>add a whitelist function - no_local_apic_kills_bios or some such; seems
>better than listing every dell inspiron individually..)
>
>I'm encouraged by the complete lack of APM or any of the 'enter bios
>while running' options present on the older laptops; according to the
>comments, even if the APIC kills the bios on entry/exit, it won't matter
>since you can't trigger it to begin with..

You'll also enter BIOS (System Management Mode actually) when inserting
or removing the power cord, or when thermal events occur, and possibly
also when suspending.

The blacklist rule is a catch-all since we don't have detailed DMI
data on all Inspiron/Latitude models, and at the time, _all_ of them
were broken. Looking through my records, Inspiron 8000 and 8100, and
Latitude C600, C610, C640, C800, and C810 are known to be broken. Note
that this includes at least one P4-based machine (C640), so it's not
restricted to "old" mobile P3s.

The only non-broken Dell laptop that I know of is the Latitude D600
(Centrino), and that was reported only two months ago.

I'm all for adding an explicit white-list to dmi_scan.c. For starters,
the D600 should be included. Partial dmidecode data for it is included
below.

(There is also a generic problem in that apm can enter the BIOS
asynchronously if you configure DISPLAY_BLANK or CPU_IDLE, or build
apm as a module and unload it. Both DISPLAY_BLANK and unloading the
module are known lock-up triggers if the local APIC is enabled.)

/Mikael

Handle 0x0100
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: Dell Computer Corporation
		Product Name: Latitude D600                   
Handle 0x0200
	DMI type 2, 9 bytes.
	Base Board Information
		Manufacturer: Dell Computer Corporation
		Product Name: 03U652

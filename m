Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276381AbRI2A3R>; Fri, 28 Sep 2001 20:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276382AbRI2A26>; Fri, 28 Sep 2001 20:28:58 -0400
Received: from sushi.toad.net ([162.33.130.105]:52185 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276381AbRI2A24>;
	Fri, 28 Sep 2001 20:28:56 -0400
Message-ID: <3BB515C4.E37C0B16@mail.com>
Date: Fri, 28 Sep 2001 20:28:52 -0400
From: Thomas Hood <jdthood@mail.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Stelian Pop <stelian.pop@fr.alcove.com>
Subject: [PATCH] PnPBIOS 2.4.9-ac1[56] Vaio fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a new patch against stock 2.4.9-ac16.
It is about the minimum change that is required to get
-ac16 working on Sony Vaio laptops.  I omit the
other changes to the PnP BIOS driver that I submitted
earlier ... we should get this straightened out first.
Once Alan releases a kernel with this or a similar
patch, I'll submit a new patch that fixes the 
disabled-device problems I was grappling with before.
(Did you know that 'Bios' is a Hindi word for 'quicksand'?
I'll bet you didn't.  That's because I just made it up.) 

The fix is required because Sony Vaio laptops' PnP BIOS
won't handle requests to get the "current" resource
configuration.

The fix:
In many cases it doesn't matter whether we get the
"current" or "boot" configuration of a device (e.g.,
when we are just looking for the PnP I.D.s), so for
the most part the fix consists of asking for the 
"boot" rather than the "current" config.

One thing that had to be done, however, was to eliminate
the /proc/bus/pnp interface to "current" config values
for those laptops that can't supply them.  Accordingly, now,
the PnP BIOS proc module is initialized with a flag that can
tell it to omit the "current" files.  The PnP BIOS driver
calls with this flag set when the is_sony_vaio_laptop global
variable is nonzero.  The DMI scan routine will set
is_sony_vaio_laptop to 1, but at present it runs
too late for this to be of use to the PnP BIOS driver.
With the patch the variable can also be set using the
"nobioscurrpnp" boot option; users of Sony Vaio laptops
will have to use this option until the DMI scan is put
earlier in the boot sequence.

--
Thomas

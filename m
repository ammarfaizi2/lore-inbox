Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbSKMWW0>; Wed, 13 Nov 2002 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264617AbSKMWWZ>; Wed, 13 Nov 2002 17:22:25 -0500
Received: from kim.it.uu.se ([130.238.12.178]:24788 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S264614AbSKMWWX>;
	Wed, 13 Nov 2002 17:22:23 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15826.53818.621879.661253@kim.it.uu.se>
Date: Wed, 13 Nov 2002 23:29:14 +0100
To: linux-kernel@vger.kernel.org
Subject: local APIC may cause XFree86 hang
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I installed a Radeon 8500 in a box. Suddenly the box
consistently hung hard every time I tried to shut down XFree86.

It turned out to be the local APIC timer: with it enabled,
the hangs occur; with it disabled but with the rest of the
local APIC and the performance counters in use, there are no
problems at all.

Does XFree86 (its core or particular drivers) use vm86() to
invoke, possibly graphics card specific, BIOS code?
That would explain the hangs I got. The fix would be to
disable the local APIC around vm86()'s BIOS calls, just like
we now disable it before APM suspend.

Doesn't the PCI code also do BIOS calls?

/Mikael

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTHFOkH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTHFOkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:40:06 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:24526 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263875AbTHFOkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:40:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16177.4928.365768.935653@gargle.gargle.HOWL>
Date: Wed, 6 Aug 2003 16:40:00 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 on Dell PE2650, ACPI_HT_ONLY strangeness
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before upgrading our PowerEdge 2650 (dual HT Xeons, Tigon3,
aic7899, workspace on sw raid5 over 4 disks, ext3) to RH9,
I gave 2.6.0-test2 a spin. Worked fine, except for one thing.

In 2.4, CONFIG_SMP automatically uses acpitable.c to detect
secondary threads via the MADT (since MPS doesn't handle them).

In 2.6.0-test2, with CONFIG_SMP and CONFIG_ACPI_HT_ONLY, this
doesn't happen, _unless_ I also pass acpismp=force on the command
line. Without acpismp=force, it only finds two CPUs.

The logic in arch/i386/kernel/setup.c, which defaults acpi to
disabled if HT_ONLY is chosen, seems backwards. Surely if I
configure HT_ONLY it's because I want to use it, no?

/Mikael

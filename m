Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267687AbTBUUcr>; Fri, 21 Feb 2003 15:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267688AbTBUUcr>; Fri, 21 Feb 2003 15:32:47 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:6294
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S267687AbTBUUcq>; Fri, 21 Feb 2003 15:32:46 -0500
Date: Fri, 21 Feb 2003 15:42:35 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: Mikael Pettersson <mikpe@user.it.uu.se>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: UP local APIC is deadly on SMP Athlon
In-Reply-To: <Pine.LNX.4.44.0302210959090.17290-100000@guppy.limebrokerage.com>
Message-ID: <Pine.LNX.4.44.0302211535510.17290-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2003, Ion Badulescu wrote:

> Anyway, I'll keep on digging.

And this is what I found: eliminating two lines from 
APIC_init_uniprocessor() makes the problem go away.

diff -urNX diff_kernel_excludes linux-2.4.10-pre12/arch/i386/kernel/apic.c linux-2.4.10-pre11++/arch/i386/kernel/apic.c
--- linux-2.4.10-pre12/arch/i386/kernel/apic.c	Wed Feb 19 23:53:15 2003
+++ linux-2.4.10-pre11++/arch/i386/kernel/apic.c	Fri Feb 21 15:37:06 2003
@@ -1087,9 +1087,6 @@
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = 1;
-	apic_write_around(APIC_ID, boot_cpu_id);
-
 	apic_pm_init2();
 
 	setup_local_APIC();

[patch against 2.4.10-pre12, but 2.4.21-pre4 is reasonably similar]

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbTATOxm>; Mon, 20 Jan 2003 09:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbTATOxm>; Mon, 20 Jan 2003 09:53:42 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:5806 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265909AbTATOxl>;
	Mon, 20 Jan 2003 09:53:41 -0500
Date: Mon, 20 Jan 2003 16:02:39 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301201502.QAA25383@harpo.it.uu.se>
To: ALESSANDRO.SUARDI@oracle.com
Subject: Re: "Latitude with broken BIOS" ?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> > Your P4-based Latitude probably has a different BIOS than the buggy
> > P3-based ones, and it may work better. Try commenting out the
> > local_apic_kills_bios entry for "Dell Latitude" at around line 692
> > in arch/i386/kernel/dmi_scan.c and rebuild the kernel. If it
> 
> (ahem) I had tried that in 2.5.58 already ;)
> 
> However I rebuilt 2.5.59 with that change, and I'm not going further:
> 
>  No local APIC present or hardware disabled

Ah, your P4 needs another patch. Edit arch/i386/kernel/apic.c, function
detect_init_APIC(), at line 631, and remove the "&& cpu_has_apic" after
the "boot_cpu_data.x86 == 15" test. (Or check if your BIOS can be set up
to boot with the local APIC enabled.)

/Mikael

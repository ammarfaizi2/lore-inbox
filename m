Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbTHXTh4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 15:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbTHXTh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 15:37:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:52135 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261200AbTHXThy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 15:37:54 -0400
Date: Sun, 24 Aug 2003 12:40:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wiktor Wodecki <wodecki@gmx.de>
Cc: felipe_alfaro@linuxmail.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org,
       vojtech@suse.cz, linux-acpi@intel.com
Subject: Re: 2.6.0-test3-bk6: hang at i8042.c when booting with no PS/2
 mouse attached
Message-Id: <20030824124020.72a1f03c.akpm@osdl.org>
In-Reply-To: <20030824131312.GA714@gmx.de>
References: <20030824120605.23981.qmail@linuxmail.org>
	<20030824131312.GA714@gmx.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor Wodecki <wodecki@gmx.de> wrote:
>
> > > >         if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ, 
>  > > >                                 "i8042", i8042_request_irq_cookie)) 
>  > >  
>  > > What happens if you remove the SA_SHIRQ and replace with 0? 
>  >  
>  > It does nothing: the kernel still hangs there. It seems to be a problem with the new ACPI code 
>  > changes cause the kernel boots fine with "pci=noacpi". 
> 
>  confirmed here. Although I have it on 2.6.0-test4 and had it since
>  al least test3-mm3.

Guys, please send a full report to linux-acpi@intel.com based on
the following:

 Regarding how to field these in general...
 Bugzilla would be really helpful, because we've got multiple bugs and
 multiple people working on them and bugzilla is better than e-mail at
 keeping the relevant bits together.  bugzilla with component=ACPI and
 owner len.brown@intel.com or andrew.grover@intel.com should do the
 trick.

 The dmesg output of the failing case is really helpful,
 As is the output of acpidmp to examine the ACPI tables on the system.
 (Red Hat includes both of these in their severn beta1, acpidmp is also
 in pmtools on intel's ACPI web page)
 dmidecode output is useful to identify the BIOS version.

 Of course the 1st thing to check with ACPI failures is that the BIOS
 version shown by dmidmp is the latest provided by the vendor...  Plus,
 if we determine the BIOS is toast, DMI provides what we need to add the
 system to the DMI or acpi blacklists.

 We're seeting the most problems on VIA chip-sets with no IO-APIC.
 The one below is unusual because it is a 2-way system with 3 IO-APICs.

 The latest code in linus' tree includes ACPICA 20030813, which is
 slightly newer than the one below, it might be a good idea to try that
 with CONFIG_ACPI_DEBUG.  Note that it will spit out the DMI info upon
 the mount root failure automatically.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTHWWWW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 18:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbTHWWWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 18:22:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:44426 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263584AbTHWWWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 18:22:15 -0400
Date: Sat, 23 Aug 2003 15:24:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: 2.6.0-test4 - lost ACPI
Message-Id: <20030823152437.59ed9c3e.akpm@osdl.org>
In-Reply-To: <20030823220438.GB1155@irc.pl>
References: <20030823105243.GA1245@irc.pl>
	<20030823145545.2b7d6ec9.akpm@osdl.org>
	<20030823220438.GB1155@irc.pl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz <zdzichu@irc.pl> wrote:
>
> On Sat, Aug 23, 2003 at 02:55:45PM -0700, Andrew Morton wrote:
> > Tomasz Torcz <zdzichu@irc.pl> wrote:
> > 
> > >  ACPI disabled because your bios is from 00 and too old
> > >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > Add "acpi=force" to your kernel boot command line and everything should work
> > as before.
> 
> It does not work. It halts in beetween ps/2 mouse init and serio init.
> Adding "acpi=force pci=noacpi" solves that.
> 

OK.  Please send a full report to linux-acpi@intel.com.  Here is Len's
how-to-report-ACPI problems recipe:


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


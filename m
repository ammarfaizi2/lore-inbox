Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVFNJjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVFNJjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 05:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVFNJjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 05:39:35 -0400
Received: from mail.suse.de ([195.135.220.2]:5844 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261163AbVFNJjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 05:39:31 -0400
Message-ID: <42AEA5CF.30100@suse.de>
Date: Tue, 14 Jun 2005 11:39:27 +0200
From: Thomas Renninger <trenn@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050524
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com> <200506130454.j5D4suNY006032@turing-police.cc.vt.edu> <20050613152507.GB7862@atomide.com> <200506131647.j5DGl0ke009926@turing-police.cc.vt.edu>            <42ADC9E7.30901@suse.de> <200506131907.j5DJ7e4G017545@turing-police.cc.vt.edu>
In-Reply-To: <200506131907.j5DJ7e4G017545@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 13 Jun 2005 20:01:11 +0200, Thomas Renninger said:
> 
>>>Should there be a C3/C4?  Is my laptop just plain borked? :)
>>Depends on your machine and BIOS, whether it's supported -> seems as if it's not.
>>
>>You could verify by having a deeper look in your FADT/DSDT.
>>You need the acpi tools from Len Brown (acpidmp/acpixtract) and the iasl Intel ACPI
>>compiler.
>>AFAIK checking for C-support is rather robust in recent kernels as long as you don't have a broken
>>DSDT table.
> 
> OK, found acpidmp and iasl, now have a decompiled DSDT - now to figure out
> if it's busticated or not.... :)

There are two ways C-state addresses are exported to OS.

     - Some flags in the FADT (-> ACPI spec) -> this gives you two C-states maximum, AFAIK.
     - Through the _CST function in your DSDT (-> ACPI spec, sorry). If you have
       have a look in dsdt.dsl at the _CST function there are that much packages returned as
       your BIOS claims to support. Hmm, _CST code is often in the SSDT an extention
       of the DSDT code. If you have one: acpidmp > acpidmp; acpixtract ssdt acpidmp >my_ssdt;
       iasl -d my_ssdt.

If your dsdt/ssdt compiles again without errors (better tell me privately if you get some),
you should not have much hope, higher states are probably not supported.

You could also increase ACPI debug output when loading the processor module to get more information:
cat /proc/acpi/debug_level /proc/acpi/debug_layer
echo 0x00000FFF >/proc/acpi/debug_level      (or whatever enables INFO, you need ACPI_DEBUG defined)
modprobe processor

      Thomas
> 
>>Maybe you find a newer BIOS supporting C3?
> 
> Nope, I just checked, and the A13 BIOS from 02/06/2004 is the latest that Dell
> has released for the C840.  Not much hope there unless there's some special
> secret site that even newer BIOS updates hide until they escape.. ;)
>  
>>To be honest, I doubt you save much power even with dyn tick enabled if you only have support
>>for C1 and C2. The pmstats tool from Tony (see link above)
>>could tell you nicely whether you gain anything.
> 
> Well, it's a start, anyhow. :)


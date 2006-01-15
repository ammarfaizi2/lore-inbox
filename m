Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751902AbWAOL3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbWAOL3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 06:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWAOL3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 06:29:24 -0500
Received: from smtp-6.smtp.ucla.edu ([169.232.48.138]:13503 "EHLO
	smtp-6.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1751902AbWAOL3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 06:29:23 -0500
Date: Sun, 15 Jan 2006 03:29:15 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Roberto Nibali <ratz@drugphish.ch>
cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <Pine.LNX.4.64.0601091654380.6479@potato.cts.ucla.edu>
Message-ID: <Pine.LNX.4.64.0601150322020.5053@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
 <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
 <1136030901.28365.51.camel@localhost.localdomain> <20051231130151.GA15993@alpha.home.local>
 <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu> <20060105054348.GA28125@w.ods.org>
 <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu> <43BF8785.2010703@drugphish.ch>
 <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu> <43C2C482.6090904@drugphish.ch>
 <Pine.LNX.4.64.0601091221260.1900@potato.cts.ucla.edu> <43C2E243.5000904@drugphish.ch>
 <Pine.LNX.4.64.0601091654380.6479@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Hits: 0.207
X-Spam-Report: UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Chris Stromsoe wrote:
> On Mon, 9 Jan 2006, Roberto Nibali wrote:
>
>>> That is the SCSI BIOS rev.  The machine is a Dell PowerEdge 2650 and 
>>> that's the onboard AIC 7899.  It comes up as "BIOS Build 25309".
>> 
>> Brain is engaged now, thanks ;). If you find time, could you maybe 
>> compile a 2.4.32 kernel using following config (slightly changed from 
>> yours):
>> 
>> http://www.drugphish.ch/patches/ratz/kernel/configs/config-2.4.32-chris_s
>
> If/when the current run with DEBUG_SLAB oopses, I'll reboot with the 
> config modifications.

I've been running stable with the propsed changes since the 10th.  The 
original config and the currently running config are both at 
<http://hashbrown.cts.ucla.edu/pub/oops-200512/>.  This is the diff:

cbs@hashbrown:~ > diff config-2.4.32 config-2.4.32-20060115

65c65
< CONFIG_HIGHIO=y
---
> # CONFIG_HIGHIO is not set
69c69
< CONFIG_NR_CPUS=32
---
> CONFIG_NR_CPUS=4
87c87
< CONFIG_ISA=y
---
> # CONFIG_ISA is not set
109c109
< # CONFIG_ACPI is not set
---
> CONFIG_ACPI=y
110a111,127
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_MMCONFIG=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SYSTEM=y
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_BATTERY is not set
> # CONFIG_ACPI_BUTTON is not set
> # CONFIG_ACPI_FAN is not set
> # CONFIG_ACPI_PROCESSOR is not set
> # CONFIG_ACPI_THERMAL is not set
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_DEBUG is not set
385c402
< # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
---
> CONFIG_AIC7XXX_DEBUG_ENABLE=y
387c404
< # CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
---
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
492,493d508
< # CONFIG_AT1700 is not set
< # CONFIG_DEPCA is not set
500d514
< # CONFIG_AC3200 is not set
585,589d598
< # Old CD-ROM drivers (not SCSI, not IDE)
< #
< # CONFIG_CD_NO_IDESCSI is not set
<
< #
864,865c873,874
< # CONFIG_DEBUG_HIGHMEM is not set
< # CONFIG_DEBUG_SLAB is not set
---
> CONFIG_DEBUG_HIGHMEM=y
> CONFIG_DEBUG_SLAB=y




-Chris

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTJHJ63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 05:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTJHJ63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 05:58:29 -0400
Received: from gprs150-16.eurotel.cz ([160.218.150.16]:49536 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261240AbTJHJ61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 05:58:27 -0400
Date: Wed, 8 Oct 2003 11:58:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Len Brown <len.brown@intel.com>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ACPI blacklisting: move year blacklist into acpi/blacklist.c
Message-ID: <20031008095814.GB288@elf.ucw.cz>
References: <20031001101826.GA3503@elf.ucw.cz> <1065595181.3370.478.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065595181.3370.478.camel@dhcppc4>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Re: dmi_check_blacklist()
> 
> Something like MATCH(DMI_BOARD_NAME, "P2B-DS") boils down to a strstr(a,
> b) -- probably something that can be fooled by substring, say "PB2-D"...
> 
> But more to the point, there is no way to compare before/after dates,
> say BEFORE(DMI_BIOS_DATE, "1/3/2002")
> 
> This is needed to blacklist things like the Toshiba Tecra 8100 which
> supplies a DMI date, but no other useful version info.
> 
> If we such a date comparison function, we could also use it to make the
> year-compare code below somewhat cleaner.

Well, my main problem is with having two blacklists at diferent places.

> Re: externs
> looks like using externs in the function protos in include/linux is
> common practice, so acpi.h should probably do it too -- even if it is
> just for consistent style.

Do you want me to submit patch or will you add externs?

> Re: diffs
> I couldn't get patch to digest this format w/o manual intervention
> --- /usr/src/tmp/linux/arch/...
> +++ /usr/src/linux/arch/...
> 
> and had to edit it into
> 
> --- a/arch/...
> +++ b/arch/...
> 
> for patch -Np1

Sorry. (I fixed generating script).

> Re: acpi_bios_year() definition
> note that CONFIG_ACPI_BOOT may be defined when CONFIG_ACPI is not.  Ie.
> in the case where just the ACPI boot code is used to enumerate LAPICs,
> say for HT, but ACPI_INTERPRETER is not even built in.
> 
> In this case, blacklist.c is not built into the kernel, but dmi_scan.c
> always is.

Okay, in such case is it feasible to move blacklist.c functionality
into dmi_scan.c? i386 blacklist is probably useless for ia64,
anyway... And 2 places seem like bad idea.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

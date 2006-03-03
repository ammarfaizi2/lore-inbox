Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752105AbWCCEAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbWCCEAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 23:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWCCEAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 23:00:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53908 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752105AbWCCEAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 23:00:34 -0500
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com, mm-commits@vger.kernel.org
Subject: Re: + pnp-mpu401-adjust-pnp_register_driver-signature.patch added 
 to -mm tree
References: <200603022340.k22Neq0o014875@shell0.pdx.osdl.net>
	<m1veuwgxd8.fsf@ebiederm.dsl.xmission.com>
	<1084.24.9.204.52.1141357193.squirrel@mail.atl.hp.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Mar 2006 20:57:37 -0700
In-Reply-To: <1084.24.9.204.52.1141357193.squirrel@mail.atl.hp.com> (Bjorn
 Helgaas's message of "Thu, 2 Mar 2006 20:39:53 -0700 (MST)")
Message-ID: <m1irqwgoy6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bjorn Helgaas" <bjorn.helgaas@hp.com> writes:

>>> This series of patches removes the assumption that pnp_register_driver()
>>> returns the number of devices claimed.  Returning the count is
>>> unreliable
>>> because devices may be hot-plugged in the future.  (Many devices don't
>>> support
>>> hot-plug, of course, but PNP in general does.)
>>
>> Huh?
>>
>> How do onboard devices or ISA plug and play devices support hot-plug?
>>
>> Or what devices supported by the pnp subsystem support hot-plug?
>
> I don't know for sure whether ISAPNP or PNPBIOS support hot-plug,
> but ACPI does, and ACPI devices are being integrated into the
> PNP subsystem via PNPACPI.
>
> One example is HP sx2000 hardware that supports hot-plug of cells.
> Each cell contains CPUs, memory, I/O bridges, and some miscellaneous
> hardware like on-board serial devices.  All this stuff is described
> by ACPI, and we'd like to use PNP drivers like 8250_pnp.c when we can.

Ok, hot plug of motherboards.  The pieces fall together now for me.

Most things controlled by isapnp are either cold plug or not even
pluggable (like most serial ports).  So imaging them in a hot-plug
situation takes some effort.  But node/cell based NUMA systems
where you plug and unplug motherboards.  That make sense.

Eric


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbUDOPUo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264319AbUDOPUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:20:44 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:46275 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264318AbUDOPUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:20:41 -0400
Date: Thu, 15 Apr 2004 11:21:01 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Len Brown <len.brown@intel.com>
Cc: ross@datscreative.com.au, christian.kroener@tu-harburg.de,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: IO-APIC on nforce2 [PATCH]
In-Reply-To: <1081893978.2251.653.camel@dhcppc4>
Message-ID: <Pine.LNX.4.58.0404151118180.10471@montezuma.fsmlabs.com>
References: <200404131117.31306.ross@datscreative.com.au> 
 <1081832914.2253.623.camel@dhcppc4>  <200404131703.09572.ross@datscreative.com.au>
 <1081893978.2251.653.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0404151118182.10471@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004, Len Brown wrote:

> Re: IRQ0 XT-PIC timer issue
>
> Since the hardware is connected to APIC pin0, it is a BIOS bug
> that an ACPI interrupt source override from pin2 to IRQ0 exists.
>
> With this simple 2.6.5 patch you can specify "acpi_skip_timer_override"
> to ignore that bogus BIOS directive.  The result is with your
> ACPI-enabled APIC-enabled kernel, you'll get IRQ0 IO-APIC-edge timer.
>
> Probably there is a more clever way to trigger this workaround
> automatcially instead of via boot parameter.

Nice, this is the problem which broke Andrew's and the systems i tested
my adaptation of Natalie's mp_override_legacy_irq() change. Whacking out
previous mp_irq entries would have worked if the BIOS had not forced the
pin2 override.

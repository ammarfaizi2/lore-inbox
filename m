Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275305AbTHSB5k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275307AbTHSB5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:57:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18627 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275305AbTHSB5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:57:37 -0400
Message-ID: <3F418403.709@pobox.com>
Date: Mon, 18 Aug 2003 21:57:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: Stian Jordet <liste@jordet.nu>, linux-kernel@vger.kernel.org
Subject: Re: [SOLVED] RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
References: <BF1FE1855350A0479097B3A0D2A80EE009FC78@hdsmsx402.hd.intel.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC78@hdsmsx402.hd.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:
> implementation.  Unless I screwed up the config dependencies, it should
> be impossible to enable the full CONFIG_ACPI without including
> CONFIG_ACPI_HT.


You got it right...

...unfortunately the current options are very non-obvious.  Linux kernel 
config has always presented a "subsystem switch", and under that, you 
have a bunch of options and modules and such.  It is not obvious to me 
at all that _disabling_ CONFIG_ACPI_HT means that CONFIG_ACPI will 
simply never appear.  And users who want ACPI, but don't have 
HyperThreading, would probably think similarly.  I think the current 
thread shows it generates at least a little bit of confusion, too.

To me, it makes sense for CONFIG_ACPI_HT to require CONFIG_ACPI -- from 
a Kconfig standpoint -- but not the other way around.  My first time 
configuring with the new options, I wanted to turn off CONFIG_ACPI_HT 
and turn on CONFIG_ACPI, but was frustrated when the config system 
wouldn't allow it.

I actually think the old method was a bit less confusing -- 
CONFIG_ACPI=N would never prompt me for any other ACPI config option. 
But if I wanted only the HT stuff, you had CONFIG_ACPI_HT_ONLY :)

So... concrete suggestions?  Overall, IMO, move everything under 
CONFIG_ACPI, or, make CONFIG_ACPI_BOOT a _peer_ option, whose selection 
or lackthereof doesn't affect CONFIG_ACPI visibility at all.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWFTTzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWFTTzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 15:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWFTTzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 15:55:20 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:45170 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750827AbWFTTzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 15:55:18 -0400
Message-ID: <449852F2.7000704@oracle.com>
Date: Tue, 20 Jun 2006 12:56:34 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       len.brown@intel.com, linux-acpi@vger.kernel.org
Subject: Re: [Ubuntu PATCH] acpi: Add IBM R60E laptop to proc-idle blacklist
References: <4491BC6B.5000704@oracle.com> <20060619203333.5e897ead.akpm@osdl.org> <20060620093016.GA27807@srcf.ucam.org>
In-Reply-To: <20060620093016.GA27807@srcf.ucam.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> On Mon, Jun 19, 2006 at 08:33:33PM -0700, Andrew Morton wrote:
>>> +	{ set_max_cstate, "IBM ThinkPad R40e", {
>>> +	  DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
>>> +	  DMI_MATCH(DMI_BIOS_VERSION, "1SET70WW") }, (void*)1},
> 
>> It seems that every R40e in the world is in that table.
>>
>> Can/should we wildcard it?  From my reading of dmi_check_system(), we can use
>> "" in place of the "1SET..." string and it'll dtrt?
> 
> Wouldn't that result in every machine with "IBM" as the BIOS vendor 
> having their maximum c-state limited?

Yes.  DMI_MATCH() specifies substring matching, so _if we knew_
that any BIOS version that began with "1SET4", "1SET5", "1SET6",
or "1SET7" needed C-state limiting, the table could be made a lot
smaller.  But then it may need some exceptions, so just sticking
with full version strings seems reasonable to me.

~Randy


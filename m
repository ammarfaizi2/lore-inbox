Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267264AbUHWAcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267264AbUHWAcs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 20:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUHWAcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 20:32:48 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:14052 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S267264AbUHWAcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 20:32:45 -0400
Message-ID: <41293B41.5040800@metaparadigm.com>
Date: Mon, 23 Aug 2004 08:33:05 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040802 Debian/1.7.1-5
X-Accept-Language: en
MIME-Version: 1.0
To: "Clark, Michael" <michael@metaparadigm.com>
Cc: Pavel Machek <pavel@suse.cz>, jeremy@goop.org, davej@codemonkey.org.uk,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - Initial dothan speedstep support
References: <41131120.5060202@metaparadigm.com>    <20040818135314.GJ467@openzaurus.ucw.cz> <56689.210.86.92.219.1093159902.squirrel@mail.metaparadigm.com>
In-Reply-To: <56689.210.86.92.219.1093159902.squirrel@mail.metaparadigm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/04 15:31, Clark, Michael wrote:
>>Hi!
>>
>>
>>>So here's a patch on top of the above patch that adds all of the
>>>dothan frequency/voltages for processors 715, 725, 735, 745, 755
>>>
>>>Tested and working as it should so far with a 745. The stepping in the
>>>model table for the others may need to be tweaked.
>>>
>>>The Dothan processor datasheet 30218903.pdf defines 4 voltages for
>>>each frequency (VID#A through VID#D) whereas Banias only suggests a
>>>typical voltage and no min or max for each freq so i've used the OP
>>>macro to allow definition of all voltages (A through D) but the macro
>>>currently just uses VID#C at compile time (the second lowest voltage
>>>profile).
>>
>>I thought that whether to use VID#A, B, C or D depends on
>>your concrete chip? Not all chips are certified to run on VID#C...
> 
> 
> Yes, I believe this is the case. When I read the processor spec
> document it did not mention this but since then i found this out. I've
> since changed the patch to use the VID#A voltages which is more
> conservative (assuming that all of them will run at the higher voltage
> okay which according to the upper voltage rating of 1.6 volts might be

On re-looking at the spec and the voltage tolerance tables in particular
I realize my approach is not valid. A VID#B can be driven at VID#A
voltages but there is no voltage in common for some frequencies between
all VID# variants.

> okay). It would of course be preferrable to work out the the type
> VID#A,B,C,D via software - not sure if this is possible.

Perhaps the VID# variant can be found via MSRs - if not the static tables
will not be workable and the ACPI approach will have to be the sole method.

~mc

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283438AbRLDOog>; Tue, 4 Dec 2001 09:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283403AbRLDOml>; Tue, 4 Dec 2001 09:42:41 -0500
Received: from gatekeeper.corp.netcom.net.uk ([194.42.224.25]:10151 "EHLO
	gatekeeper") by vger.kernel.org with ESMTP id <S284379AbRLDOes>;
	Tue, 4 Dec 2001 09:34:48 -0500
Message-ID: <3C0CDEC7.20967AD5@netcomuk.co.uk>
Date: Tue, 04 Dec 2001 14:33:43 +0000
From: Bill Crawford <billc@netcomuk.co.uk>
Reply-To: bill@eb0ne.net
Organization: Netcom Internet Ltd
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-0.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: MIDN Sean Jones <m053546@usna.edu>
Subject: Re: Possible bugs
In-Reply-To: <200112041201.fB4C14d23225@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Date: 02 Dec 2001 17:29:52 -0500
> From: MIDN Sean Jones <m053546@usna.edu>
> To: linux-kernel@vger.kernel.org

> I was looking for code to cleanup and found these warnings:
...
> agpgart_be.c:524: warning: `agp_generic_create_gatt_table' defined but
> not used
> agpgart_be.c:652: warning: `agp_generic_free_gatt_table' defined but not
> used
> agpgart_be.c:700: warning: `agp_generic_insert_memory' defined but not
> used
> agpgart_be.c:758: warning: `agp_generic_remove_memory' defined but not
> used
...
> Are these functions supposed to be there or are they leftovers from
> previous modifications.

 They're used in a number of places, but some (most? all?) chipsets do
override the "generic" forms, so depending on which chipset(s) you
select in the config, some of these functions may not get used.

 Putting in an explicit "generic" AGP backend might solve the problem;
the other solution is to put #if guards around those functions.  That
strikes me as a bit messy and fragile as any new chipset might need
them, and we don't want some over-zealous hacker removing them because
they're not used by anything at the moment :o)

 Splitting the different chipsets into separate files and putting the
"generic" forms in their own "library" file is probably an option, but
it's debatable whether that file is big enough to really be worth it.

 You could move the ALi-specific code from agp_lookup_host_bridge to
agp_find_supported_device while you're at it ;o) or I might try to do
that in my copious quantities of free time.

> Thanks,
> 
> Sean Jones

-- 
/* Bill Crawford, Unix Systems Developer, Ebone (formerly GTS Netcom) */
#include <stddiscl>
const char *addresses[] = {
    "bill@syseng.netcom.net.uk", "Bill.Crawford@ebone.com",     // work
    "billc@netcomuk.co.uk", "bill@eb0ne.net"                    // home
};

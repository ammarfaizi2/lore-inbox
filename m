Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992614AbWJTNyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992614AbWJTNyo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992616AbWJTNyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:54:43 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:4997 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S2992614AbWJTNyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:54:43 -0400
Date: Fri, 20 Oct 2006 08:54:37 -0500 (Central Daylight Time)
From: Dwayne Grant McConnell <decimal@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: Correct way to format spufs file output.
In-Reply-To: <200610201023.12796.arnd@arndb.de>
Message-ID: <Pine.WNT.4.64.0610200848580.5976@dwayne>
References: <Pine.WNT.4.64.0610182227120.6056@doodlebug> <200610201023.12796.arnd@arndb.de>
X-X-Sender: decimal@imap.linux.ibm.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006, Arnd Bergmann wrote:

> On Thursday 19 October 2006 05:30, Dwayne Grant McConnell wrote:
> > In a recent submission I added the lslr file and used "%llx" for the 
> > format string. You mentioned that it should probably be "0x%llx" so it 
> > would be clearly parsed as hex so I changed it in the next submission. But 
> > I noticed that there seems to be some inconsistent usage of 0x as follows:
> 
> Thanks for bringing this up, I guess I screwed up in some way here, so
> we should fix it up one way or another:
> 
> > signal1_type (%llu)
> > signal2_type (%llu)
> 
> These are fine, they can only ever be 1 or 0.
> 
> > npc (%llx)
> 
> I think we used to access this in _very_ old versions of libspe,
> before we move to a syscall based interface.
> 
> > decr (%llx)
> > decr_status (%llx)
> > spu_tag_mask (%llx)
> > event_mask (%llx)
> > event_status (%llx)
> > srr0 (%llx)
> 
> These are used exclusively for debugging purposes, and no publically
> available version of gdb accesses them, so I guess we can still change
> them, although it's not nice.
> 
> > phys_id (0x%llx)
> 
> This one is used in some forks of libspe, we should not change it.
> 
> > object_id (0x%llx)
> 
> This is used in libspe, gdb and oprofile, but only in fairly recent
> versions.
> 
> > lslr (0x%llx)
> 
> As this is introduced by your own patch, there is no precedent for
> it yet.
> 
> Current kernels now also have 'cntl' (0x%08lx), which was introduced
> in 2.6.19 and is so far unused. I guess we should change that one
> to be consistant with the others as well.
> 
> > Should all the %llx be changed to 0x%llx or should the 0x be dropped from 
> > those that have it or is the inconsistency acceptable?
> 
> I'd rather have it consistant. Moreover, I guess the "%llx" format is
> actually harmful, because that means you can not use the same format
> for read and write. The simple_attr_write function currently uses
> the simple_strtol helper to interpret the value written to it, and that
> requires the input to be wither decimal, or hexadecimal with a preceding
> 0x. I'd suggest we change all files to take a 0x%llx format on output.

I think %0xllx is the way to go. I would even advocate changing 
signal1_type and signal2_type unless it is actually too dangerous. Is 
there even a case where changing from %llu to %0xllx would break things? 
Perhaps with the combination of a old library with a new kernel?

-- 
Dwayne Grant McConnell <decimal@us.ibm.com>
Lotus Notes Mail: Dwayne McConnell [Mail]/Austin/IBM@IBMUS
Lotus Notes Calendar: Dwayne McConnell [Calendar]/Austin/IBM@IBMUS


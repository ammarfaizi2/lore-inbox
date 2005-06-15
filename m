Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVFOU3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVFOU3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVFOU3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:29:14 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41400 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261538AbVFOU3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:29:08 -0400
From: Russ Anderson <rja@sgi.com>
Message-Id: <200506152028.j5FKSuw91463066@clink.americas.sgi.com>
Subject: Re: [RFC] Linux memory error handling
To: rmk+lkml@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jun 2005 15:28:56 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org, rja@sgi.com (Russ Anderson)
In-Reply-To: <20050615204659.A14853@flint.arm.linux.org.uk> from "Russell King" at Jun 15, 2005 08:46:59 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Jun 15, 2005 at 04:26:13PM +0100, Maciej W. Rozycki wrote:
> > On Wed, 15 Jun 2005, Russ Anderson wrote:
> > > 	Memory DIMM information & settings:
> > > 
> > > 	    Use a /proc/dimm_info interface to pass DIMM information to Linux.
> > > 	    Hardware vendors could add their hardware specific settings.
> > 
> >  I'd recommend a more generic name rather than "dimm_info" if that is to 
> > be reused universally.
> 
> Agree.

I really don't care what it's called, as long as it's descriptive.
/proc/meminfo is taken.  :-)

One idea would follow the concept of /proc/bus/ and have /proc/memory/
with different memory types.  /proc/memory/dimm0 /proc/memory/dimm1
/proc/memory/flash0 .  
 
> I'd also suggest that there be some method to tell the kernel from
> architecture code about this "dimm_info" stuff - many embedded
> platforms already know their memory organisation.
> 
> BTW, Russ, could we have a better description of what information is
> intended to be supplied?

Part tracking info and configuration info.  For example, we were doing
some experiments to determine the relationship between refresh rates
and memory errors.  Could increasing the refresh rate reduce the number
of memory errors, therefor making memory more reliable for customers?
Could decreasing the refresh rate in manufacturing be used to identify
questionable DIMMs?  Having a convient interface to read the current
refresh rate setting and write a new setting would be useful.

This type info, not necessarily in this format:
------------------------------------------------------------------------------

EEPROM     JEDEC-SPD Info           Part Number        Rev  Speed  SGI      BC
---------- ------------------------ ------------------ ---- ------ -------- --
DIMM0 N0 L CE0000000000000006071D84 M3 12L6423DT0-CB3   0D    6.0  09/02/03 00
DIMM1 N0 L CE0000000000000006051CB2 M3 12L6423DT0-CB3   0D    6.0  09/02/03 00
DIMM2 N0 L no hardware detected
DIMM3 N0 L no hardware detected


-- 
Russ Anderson, OS RAS/Partitioning Project Lead  
SGI - Silicon Graphics Inc          rja@sgi.com

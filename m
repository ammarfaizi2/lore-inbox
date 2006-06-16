Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWFPPgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWFPPgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWFPPgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:36:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11905 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751455AbWFPPgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:36:53 -0400
Date: Fri, 16 Jun 2006 10:36:32 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>, Jes Sorensen <jes@sgi.com>,
       Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
In-Reply-To: <200606161656.40930.ak@suse.de>
Message-ID: <20060616102516.A91827@pkunk.americas.sgi.com>
References: <200606140942.31150.ak@suse.de> <44929CE6.4@sgi.com>
 <4492A5E4.9050702@bull.net> <200606161656.40930.ak@suse.de>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006, Andi Kleen wrote:

> On Friday 16 June 2006 14:36, Zoltan Menyhart wrote:

> > My idea is to map the current task structure at an arch. dependent
> > virtual address into the user space (obviously in RO).
> > 
> > 	#define current	((struct task_struct *) 0x...)
> 
> This means it cannot be cache colored (because you would need a static
> offset) and you couldn't share task_structs on a page.
> 
> Also you would make task_struct part of the userland ABI which
> seems like a very very bad idea to me. It means we couldn't change
> it anymore.

To this last point, it might be more reasonable to map in a page that
contained a new structure with a stable ABI, which mirrored some of
the task_struct information, and likely other useful information as
needs are identified in the future.  In any case, it would be hard
to beat a single memory read for performance.

Cache-coloring and kernel bookkeeping effects could be minimized if this
was provided as an mmaped page from a device driver, used only by
applications which care.  This does work somewhat contrary to the idea of
getting support into glibc, unless glibc only used this capability when
asked to through some sort of environment variable or other run-time
configuration.

Brent

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong

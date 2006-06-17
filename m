Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWFQG4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWFQG4D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 02:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWFQG4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 02:56:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:58295 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932464AbWFQG4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 02:56:02 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Sat, 17 Jun 2006 08:55:48 +0200
User-Agent: KMail/1.8
Cc: Chase Venters <chase.venters@clientec.com>,
       Brent Casavant <bcasavan@sgi.com>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>, Jes Sorensen <jes@sgi.com>,
       Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz, linux-ia64@vger.kernel.org
References: <200606140942.31150.ak@suse.de> <200606161740.18611.ak@suse.de> <Pine.LNX.4.64.0606161615450.23743@turbotaz.ourhouse>
In-Reply-To: <Pine.LNX.4.64.0606161615450.23743@turbotaz.ourhouse>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606170855.49123.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 June 2006 23:19, Chase Venters wrote:
> On Fri, 16 Jun 2006, Andi Kleen wrote:
> >> To this last point, it might be more reasonable to map in a page that
> >> contained a new structure with a stable ABI, which mirrored some of
> >> the task_struct information, and likely other useful information as
> >> needs are identified in the future.  In any case, it would be hard
> >> to beat a single memory read for performance.
> >
> > That would mean making the context switch and possibly other
> > things slower.
>
> Well, if every process had a page of its own, what would the context
> switch overhead be?

For process zero, for thread quite high on x86 because you
would need per CPU page tables. Doing that would be extremly
nasty because you would potentially need to allocate a new
set of page tables every time the process is scheduled to a new
CPU it hasn't run on before.

If you limit it to a process then you can't get the current CPU
from such a mapping because a process can run threaded on
multiple CPUs.

My reference was more to high suggestion of keeping a second version 
of task_struct for export. That would require changing everything
in task struct that is changed on switch_to and should be exported
in the other function too.

-Andi

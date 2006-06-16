Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWFPPka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWFPPka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 11:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWFPPka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 11:40:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:42972 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751462AbWFPPk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 11:40:27 -0400
From: Andi Kleen <ak@suse.de>
To: Brent Casavant <bcasavan@sgi.com>
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Fri, 16 Jun 2006 17:40:18 +0200
User-Agent: KMail/1.9.3
Cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>, Jes Sorensen <jes@sgi.com>,
       Tony Luck <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
References: <200606140942.31150.ak@suse.de> <200606161656.40930.ak@suse.de> <20060616102516.A91827@pkunk.americas.sgi.com>
In-Reply-To: <20060616102516.A91827@pkunk.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606161740.18611.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> To this last point, it might be more reasonable to map in a page that
> contained a new structure with a stable ABI, which mirrored some of
> the task_struct information, and likely other useful information as
> needs are identified in the future.  In any case, it would be hard
> to beat a single memory read for performance.

That would mean making the context switch and possibly other
things slower. 

In general you would need to make a very good case first that all this 
complexity is worth it.

> Cache-coloring and kernel bookkeeping effects could be minimized if this 
> was provided as an mmaped page from a device driver, used only by
> applications which care.

I don't see what difference that would make. You would still
have the fixed offset problem and doing things on demand often tends 
to be even more complex.


-Andi (who thinks these proposals all sound very messy) 

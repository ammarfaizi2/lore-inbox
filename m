Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272546AbRIWS2F>; Sun, 23 Sep 2001 14:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272540AbRIWS14>; Sun, 23 Sep 2001 14:27:56 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:33789 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S272619AbRIWS1o>; Sun, 23 Sep 2001 14:27:44 -0400
Date: Sun, 23 Sep 2001 14:28:09 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre13aa1
Message-ID: <20010923142809.A11346@redhat.com>
In-Reply-To: <3BADAF6A.8090400@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BADAF6A.8090400@colorfullife.com>; from manfred@colorfullife.com on Sun, Sep 23, 2001 at 11:46:18AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 11:46:18AM +0200, Manfred Spraul wrote:
> I don't think that this is a valid argument:
> you are testing on i386 and make design decisions for the architecture
> independant part.

The hook is only needed for x86-like architectures, as all of the risc like 
cpus perform the dirty state modification in the page fault handler while 
holding the page_table_lock.

> I'd prefer ptep_get_and_clear_and_flush(), then the arch part can do
> what's needed to get the final pte value. (if a single page is modified,
> otherwise the arch can define a suitable mmu_gather)

mmu_gather is the hook.  ia64 for instance can create a gather that uses 
the hardware tlb flush instruction to shootdown the entry across all cpus 
and eliminates the race.

		-ben

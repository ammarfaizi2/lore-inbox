Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRCPUrW>; Fri, 16 Mar 2001 15:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131052AbRCPUrM>; Fri, 16 Mar 2001 15:47:12 -0500
Received: from zeus.kernel.org ([209.10.41.242]:3302 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130487AbRCPUq7>;
	Fri, 16 Mar 2001 15:46:59 -0500
Date: Fri, 16 Mar 2001 12:53:38 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, george anzinger <george@mvista.com>,
        Alexander Viro <viro@math.psu.edu>, linux-mm@kvack.org,
        bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process information?)
Message-ID: <20010316125338.L30889@redhat.com>
In-Reply-To: <20010316094918.F30889@redhat.com> <Pine.LNX.4.21.0103160844300.5790-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0103160844300.5790-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Fri, Mar 16, 2001 at 08:50:25AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 16, 2001 at 08:50:25AM -0300, Rik van Riel wrote:
> On Fri, 16 Mar 2001, Stephen C. Tweedie wrote:
> 
> > > Write locks would be used in the code where we actually want
> > > to change the VMA list and page faults would use an extra lock
> > > to protect against each other (possibly a per-pagetable lock
> > 
> > Why do we need another lock?  The critical section where we do the
> > final update on the pte _already_ takes the page table spinlock to
> > avoid races against the swapper.
> 
> The problem is that mmap_sem seems to be protecting the list
> of VMAs, so taking _only_ the page_table_lock could let a VMA
> change under us while a page fault is underway ...

Right, I'm not suggesting removing that: making the mmap_sem
read/write is fine, but yes, we still need that semaphore.  But as for
the "page faults would use an extra lock to protect against each
other" bit --- we already have another lock, the page table lock,
which can be used in this way, so ANOTHER lock should be unnecessary.

--Stephen

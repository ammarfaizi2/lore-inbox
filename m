Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSCZS5W>; Tue, 26 Mar 2002 13:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312587AbSCZS5M>; Tue, 26 Mar 2002 13:57:12 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:41259 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S312443AbSCZS5H>; Tue, 26 Mar 2002 13:57:07 -0500
Date: Tue, 26 Mar 2002 13:57:03 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mmap bug with drivers that adjust vm_start
Message-ID: <20020326135703.B25375@redhat.com>
In-Reply-To: <20020325230046.A14421@redhat.com> <20020326174236.B13052@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2002 at 05:42:36PM +0100, Andrea Arcangeli wrote:
> However if the patch is needed it means the ->mmap also must do the
> do_munmap stuff by hand internally, which is very ugly given we also did
> our own do_munmap in a completly different region (the one requested by
> the user).

At least my own code checks for that and fails if there is a mapping 
already placed at the fixed address it needs to use.  If we're paranoid, 
we could BUG() on getting a vma back from the new find_vma_prepare call.

> Our do_munmap should not happen if we place the mapping
> elsewhere. If possible I would prefer to change those drivers to
> advertise their enforced vm_start with a proper callback, the current
> way is halfway broken still. BTW, which are those drivers, and why they
> needs to enforce a certain vm_start (also despite MAP_FIXED that they
> cannot check within the ->mmap callback)?

Video drivers, others that require specific alignment (4MB pages for 
example).  Historically, the mmap call has been the hook for doing this, 
hence the comment in do_mmap from davem.  Unless there's a really good 
reason for changing the hook, I don't see doing so as providing much 
benefit other than making source compatibility hard.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."

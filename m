Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288969AbSCKTSk>; Mon, 11 Mar 2002 14:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSCKTS3>; Mon, 11 Mar 2002 14:18:29 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:43005 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288969AbSCKTSX>; Mon, 11 Mar 2002 14:18:23 -0500
Date: Mon, 11 Mar 2002 14:18:12 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [bkpatch] do_mmap cleanup
Message-ID: <20020311141812.A31049@redhat.com>
In-Reply-To: <20020308185350.E12425@redhat.com> <20020311120818.A38@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020311120818.A38@toy.ucw.cz>; from pavel@suse.cz on Mon, Mar 11, 2002 at 12:08:18PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 12:08:18PM +0000, Pavel Machek wrote:
> Hi!
> 
> > Below is a vm cleanup that can be pulled from bk://bcrlbits.bk.net/vm-2.5 .
> > The bulk of the patch is moving the down/up_write on mmap_sem into do_mmap 
> > and removing that from all the callers.  The patch also includes a fix for 
> > do_mmap which caused mapping of the last page in the address space to fail.
> 
> Was not that a workaround for CPU bugs?

Not as far as I recall.  In fact it is just leading to more and more 
duplicated code as every arch writes their own version of the function 
to allow mapping that last page.  (Cleaning up all the sys_mmap calls 
is next.)

		-ben

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311839AbSCZQni>; Tue, 26 Mar 2002 11:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312358AbSCZQn2>; Tue, 26 Mar 2002 11:43:28 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:46634 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311839AbSCZQnO>; Tue, 26 Mar 2002 11:43:14 -0500
Date: Tue, 26 Mar 2002 17:42:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mmap bug with drivers that adjust vm_start
Message-ID: <20020326174236.B13052@dualathlon.random>
In-Reply-To: <20020325230046.A14421@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 11:00:47PM -0500, Benjamin LaHaise wrote:
> Hello all,
> 
> The patch below fixes a problem whereby a vma which has its vm_start 
> address changed by the file's mmap operation can result in the vma 
> being inserted into the wrong location within the vma tree.  This 
> results in page faults not being handled correctly leading to SEGVs, 
> as well as various BUG()s hitting on exit of the mm.  The fix is to 
> recalculate the insertion point when we know the address has changed.  
> Comments?  Patch is against 2.4.19-pre4.

The patch is obviously safe.

However if the patch is needed it means the ->mmap also must do the
do_munmap stuff by hand internally, which is very ugly given we also did
our own do_munmap in a completly different region (the one requested by
the user). Our do_munmap should not happen if we place the mapping
elsewhere. If possible I would prefer to change those drivers to
advertise their enforced vm_start with a proper callback, the current
way is halfway broken still. BTW, which are those drivers, and why they
needs to enforce a certain vm_start (also despite MAP_FIXED that they
cannot check within the ->mmap callback)?

Andrea

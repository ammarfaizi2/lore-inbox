Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTDDVef (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbTDDVef (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:34:35 -0500
Received: from mail-2.tiscali.it ([195.130.225.148]:49126 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S261367AbTDDVed (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 16:34:33 -0500
Date: Fri, 4 Apr 2003 23:45:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Hugh Dickins <hugh@veritas.com>, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030404214547.GB16293@dualathlon.random>
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain> <20030404105417.3a8c22cc.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404105417.3a8c22cc.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 10:54:17AM -0800, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > Truncating a sys_remap_file_pages file?  You're the first to
> > begin to consider such an absurd possibility: vmtruncate_list
> > still believes vm_pgoff tells it what needs to be done.
> 
> Well I knew mincore() was bust for nonlinear mappings.  Never thought about
> truncate.

IMHO sys_remap_file_pages and the nonlinear mapping is an hack and
should be dropped eventually. I mean it's not too bad but it's a mere
workaround for:

1) lack of 64bit address space that will be fixed
2) lack of O(log(N)) mmap, that will be fixed too

1) and 2) are the only reason why there's huge interest in such syscall
right now. So I don't like it too much and I'm not convinced it was
right to merge it in 2.5 given 2) is a software problem and I've the
design to fix it with a rbtree extension, and 1) is an hardware problem
that will be fixed very soon. the API is not too bad but there is a
reason we have the vma for all other mappings.

Maybe I'm missing something, I'm curious to hear what you think and what
other cases needs this syscall even after 1) and 2) are fixed.

Andrea

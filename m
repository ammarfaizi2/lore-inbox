Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274838AbTHFFdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 01:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274820AbTHFFdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 01:33:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:31405 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S274838AbTHFFc6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 01:32:58 -0400
Date: Wed, 6 Aug 2003 11:08:07 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jeremy@goop.org, dick.streefland@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs4 doesn't expire
Message-ID: <20030806053807.GC1298@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <4b0c.3f302ca5.93873@altium.nl> <20030805164904.36b5d2cc.akpm@osdl.org> <20030806042853.GA1298@in.ibm.com> <1060144454.18625.5.camel@ixodes.goop.org> <20030806050003.GB1298@in.ibm.com> <20030805220848.3ee1111a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805220848.3ee1111a.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 10:08:48PM -0700, Andrew Morton wrote:
> Maneesh Soni <maneesh@in.ibm.com> wrote:
> >
> >  +	if (vfs) {
> >  +		if (is_vfsmnt_tree_busy(vfs))
> >  +			ret--;
> >  +		/* just to reduce ref count taken in lookup_mnt
> >  +	 	 * cannot call mntput() here
> >  +	 	 */
> >  +		atomic_dec(&vfs->mnt_count);
> >  +	}
> 
> Doesn't work, does it?  If someone else does a mntput() just beforehand,
> __mntput() never gets run.
> 

no.. it will not work. looks like we have to unlock and lock dcache_lock and
use mntput as I did earlier. But I think, it will be really nice if Jermey
can revisit is_tree_busy() code.

There can be other problems like the checking d_count for dentries under
dcache_lock(). As users can do dget() or dput() manipulating d_count without
dcache_lock(). 

Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUEGWHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUEGWHM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 18:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbUEGWHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 18:07:12 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:63494 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263818AbUEGWHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 18:07:09 -0400
Date: Fri, 7 May 2004 17:06:54 -0500
From: Jack Steiner <steiner@sgi.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-ID: <20040507220654.GA32208@sgi.com>
References: <20040501120805.GA7767@sgi.com> <20040502182811.GA1244@us.ibm.com> <20040503184006.GA10721@sgi.com> <20040507205048.GB1246@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040507205048.GB1246@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 01:50:48PM -0700, Paul E. McKenney wrote:
> On Mon, May 03, 2004 at 01:40:06PM -0500, Jack Steiner wrote:
> > Paul - 
> > 
> 
> Hmmm...  I took a quick glance, but don't see why an "ls" would
> cause RCU to be invoked.  This should only happen if a dentry is
> ejected from dcache.
> 
> Any enlightenment appreciated!
> 


The calls to RCU are coming from here:

	[11]kdb> bt
	Stack traceback for pid 3553
	0xe00002b007230000     3553     3139  1   11   R  0xe00002b0072304f0 *ls
	0xa0000001000feee0 call_rcu
	0xa0000001001a3b20 d_free+0x80
	0xa0000001001a3ec0 dput+0x340
	0xa00000010016bcd0 __fput+0x210
	0xa00000010016baa0 fput+0x40
	0xa000000100168760 filp_close+0xc0
	0xa000000100168960 sys_close+0x180
	0xa000000100011be0 ia64_ret_from_syscall

I see this same backtrace from numerous processes.


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbTDFOjh (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 10:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbTDFOjh (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 10:39:37 -0400
Received: from mail-7.tiscali.it ([195.130.225.153]:53185 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S262987AbTDFOjd (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 10:39:33 -0400
Date: Sun, 6 Apr 2003 16:51:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406145105.GO1326@dualathlon.random>
References: <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405163003.GD1326@dualathlon.random> <20030405132406.437b27d7.akpm@digeo.com> <20030405220621.GG1326@dualathlon.random> <20030405143138.27003289.akpm@digeo.com> <20030405231008.GI1326@dualathlon.random> <20030406073836.GE1828@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030406073836.GE1828@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 11:38:36PM -0800, William Lee Irwin III wrote:
> On Sun, Apr 06, 2003 at 01:10:08AM +0200, Andrea Arcangeli wrote:
> > I still think we shouldn't associate any metadata with the nonlinear.
> > nonlinaer should be enabled via a sysctl and have it run at true full
> > speed, it's a bypass for the VM so you can mangle the pagetables from
> > userspace.
> > As soon as you start associating metadata to nonlinar, it's not the
> > "raw fast" thing anymore and it increases the complexity.
> 
> One of the big reasons why it's desirable is to reduce the metadata,
> so I agree here.
> 
> 
> On Sun, Apr 06, 2003 at 01:10:08AM +0200, Andrea Arcangeli wrote:
> > running bochs after echoing 1 into a sysctl should be fine, like also
> > uml should echoing 1 into a sysctl to get revirtualized vsyscalls
> > (unless we make it a prctl but that'll be more complex and slower).
> > When bochs starts and runs the mmap(VM_NONLINEAR) it will get -EPERM and
> > it will fall into the mmap mode (for 2.4 anyways). Or they can as well
> > require the echoing so they won't need to maintain two modes.
> > the nonlinear should work only in a separate special vma, its current
> > api is very unclean since it can mix with original linear stuff into the
> > same linear vma, and it doesn't allow more than one file into the same
> > nonlinear vma. I still reccomend all my points that I posted yesterday
> > to change the API to something much more approriate.
> 
> This is an unusual idea; I'd expect capable(CAP_IPC_LOCK) to suffice
> to provide the privilege checks for direct mlocking as well as other
> operations that lock memory (please don't look at hugetlbfs for this...).

that would be enough if you could ask any capability to those apps.
Still you could override the sysctl check and allow the
mmap(VM_NONLINEAR) to work even w/ the sysctl, iff CAP_IPC_LOCK is set,
that's certainly safe, I don't mind about it.

so it could be an additional way to gain access to such functionalty,
but it doesn't obviate the need of the sysctl IMHO.

Andrea

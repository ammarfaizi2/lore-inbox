Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbUCNIst (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 03:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbUCNIst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 03:48:49 -0500
Received: from holomorphy.com ([207.189.100.168]:57612 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263334AbUCNIsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 03:48:47 -0500
Date: Sun, 14 Mar 2004 00:48:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Hugetlbpages in very large memory machines.......
Message-ID: <20040314084825.GQ655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ray Bryant <raybry@sgi.com>, Andrew Morton <akpm@osdl.org>,
	Andi Kleen <ak@suse.de>, lse-tech@lists.sourceforge.net,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <40528383.10305@sgi.com> <20040313034840.GF4638@wotan.suse.de> <20040313184547.6e127b51.akpm@osdl.org> <40541A09.3050600@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40541A09.3050600@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 02:38:33AM -0600, Ray Bryant wrote:
> write mode and the mm->page_table_lock.  So not only does it take 500 s for
> the mmap() to return on our test system, but ps, top, etc all freeze for the
> duration.  Very irritating, especially on a 64 or 128 P system.
> My preference would be to do away with bugetlb_prefault() altogether.
> (If there was a MAP_NO_PREFAULT, we would have to make this the default on
> Altix to avoid the freeze problem mentioned above.  Can't have an arbitrary
> user locking up the system.)  As Andi pointed out, perhaps we can do some
> prereservation of huge pages so that we can return a ENONMEM to the mmap()
> if there are not enough huge pages to (lazily) be allocated to satisfy the
> request, but then still allocate the pages at fault time.  A simple count
> would suffice.

There is a patch which arranges to keep statistics ready in the mm so that
the mmap_sem need not be taken for /proc/ and furthermore renders
proc_pid_statm() nothing more than copying integers out of the mm that
I forward ported to 2.6.0-test*, originally by Ben LaHaise, that may
also be of interest to those concerned about tripping over other processes'
mmap_sem's in /proc/.


-- wli

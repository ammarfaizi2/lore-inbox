Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVBNSv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVBNSv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 13:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVBNSv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 13:51:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:20213 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261521AbVBNSvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 13:51:03 -0500
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration --
	sys_page_migrate
From: Dave Hansen <haveblue@us.ibm.com>
To: Robin Holt <holt@sgi.com>
Cc: Ray Bryant <raybry@sgi.com>, Hirokazu Takahashi <taka@valinux.co.jp>,
       Hugh DIckins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Marcello Tosatti <marcello@cyclades.com>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050214135221.GA20511@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	 <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
	 <1108242262.6154.39.camel@localhost>
	 <20050214135221.GA20511@lnx-holt.americas.sgi.com>
Content-Type: text/plain
Date: Mon, 14 Feb 2005 10:50:42 -0800
Message-Id: <1108407043.6154.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 07:52 -0600, Robin Holt wrote:
> The node mask is a list of allowed.  This is intended to be as near
> to a one-to-one migration path as possible.

If that's the case, it would make the kernel internals a bit simpler to
only take a "from" and "to" node, instead of those maps.  You'll end up
making multiple syscalls, but that shouldn't be a problem.  

> > There also probably needs to be a bit more coordination between the
> > other NUMA API and this one.  I noticed that, for now, the migration
> > loop only makes a limited number of passes.  It appears that either you
> > don't require that, once the syscall returns, that *all* pages have been
> > migrated (there could have been allocations done behind the loop) or you
> > have some way of keeping the process from doing any more allocations.
> 
> It is intended that the process would be stopped during the migration
> to simplify considerations such as overlapping destination node lists.

Requiring that the process is stopped will somewhat limit the use of
this API outside of the HPC space where so much control can be had over
the processes.  I have the feeling that very few other kinds of
applications will be willing to be stopped for the time that it takes
for a set of migrations to occur.  But, if stopping the process is going
to be a requirement, having more syscalls that take less time each
should be desirable.  

-- Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVBNWC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVBNWC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 17:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVBNWCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 17:02:25 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:56556 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261579AbVBNWCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 17:02:16 -0500
Date: Mon, 14 Feb 2005 16:01:49 -0600
From: Robin Holt <holt@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Robin Holt <holt@sgi.com>, Ray Bryant <raybry@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Hugh DIckins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Marcello Tosatti <marcello@cyclades.com>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration -- sys_page_migrate
Message-ID: <20050214220148.GA11832@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com> <1108242262.6154.39.camel@localhost> <20050214135221.GA20511@lnx-holt.americas.sgi.com> <1108407043.6154.49.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108407043.6154.49.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 10:50:42AM -0800, Dave Hansen wrote:
> On Mon, 2005-02-14 at 07:52 -0600, Robin Holt wrote:
> > The node mask is a list of allowed.  This is intended to be as near
> > to a one-to-one migration path as possible.
> 
> If that's the case, it would make the kernel internals a bit simpler to
> only take a "from" and "to" node, instead of those maps.  You'll end up
> making multiple syscalls, but that shouldn't be a problem.  

Then how do you handle overlapping nodes.  If I am doing a 5->4, 4->3,
3->2, 2->1 shift in the memory placement and had only a from and to node,
I would end up calling multiple times.  This would end up in memory shifting
from 5->4 on the first, 4->3 on the second, ... with the end result of
all memory shifting to a single node.

With the array-of-node maps, you make a single pass across the address
space.  This results in a clean mapping without the userspace needing to
know which nodes the pages are on.

On a seperate topic, I would guess the syscall time is trivial compared
to the time to walk the page tables.

Thanks,
Robin

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVBNPeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVBNPeL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 10:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVBNPeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 10:34:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29833 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261448AbVBNPeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 10:34:05 -0500
Date: Mon, 14 Feb 2005 07:52:21 -0600
From: Robin Holt <holt@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Ray Bryant <raybry@sgi.com>, Hirokazu Takahashi <taka@valinux.co.jp>,
       Hugh DIckins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Marcello Tosatti <marcello@cyclades.com>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration -- sys_page_migrate
Message-ID: <20050214135221.GA20511@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com> <1108242262.6154.39.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108242262.6154.39.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 01:04:22PM -0800, Dave Hansen wrote:
> On Fri, 2005-02-11 at 19:26 -0800, Ray Bryant wrote:
> > This patch introduces the sys_page_migrate() system call:
> > 
> > sys_page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);
> > 
> > Its intent is to cause the pages in the range given that are found on
> > old_nodes[i] to be moved to new_nodes[i].  Count is the the number of
> > entries in these two arrays of short.
> 
> Might it be useful to use nodemasks instead of those arrays?  That's
> already the interface that the mbind() interfaces use, and it probably
> pays to be consistent with all of the numa syscalls.

The node mask is a list of allowed.  This is intended to be as near
to a one-to-one migration path as possible.

> There also probably needs to be a bit more coordination between the
> other NUMA API and this one.  I noticed that, for now, the migration
> loop only makes a limited number of passes.  It appears that either you
> don't require that, once the syscall returns, that *all* pages have been
> migrated (there could have been allocations done behind the loop) or you
> have some way of keeping the process from doing any more allocations.

It is intended that the process would be stopped during the migration
to simplify considerations such as overlapping destination node lists.

Robin

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWDNAJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWDNAJV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 20:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWDNAJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 20:09:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965023AbWDNAJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 20:09:20 -0400
Date: Thu, 13 Apr 2006 17:08:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, clameter@sgi.com, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 0/5] Swapless page migration V2: Overview
Message-Id: <20060413170853.0757af41.akpm@osdl.org>
In-Reply-To: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> Swapless Page migration V2
> 
> Currently page migration is depending on the ability to assign swap entries
> to pages. However, those entries will only be to identify anonymous pages.
> Page migration will not work without swap although swap space is never
> really used.

That strikes me as a fairly minor limitation?

> ...
>
> Efficiency of migration is increased by:
> 
> 1. Avoiding useless retries
>    The use of migration entries avoids raising the page count in do_swap_page().
>    The existing approach can increase the page count between the unmapping
>    of the ptes for a page and the page migration page count check resulting
>    in having to retry migration although all accesses have been stopped.

Minor.

> 2. Swap entries do not have to be assigned and removed from pages.

Minor.

> 3. No swap space has to be setup for page migration. Page migration
>    will never use swap.

Minor.

> The patchset will allow later patches to enable migration of VM_LOCKED vmas,
> the ability to exempt vmas from page migration, and allow the implementation
> of a another userland migration API for handling batches of pages.

These seem like more important justifications.  Would you agree with that
judgement?

Is it not possible to implement some or all of these new things without
this work?



That all being said, this patchset is pretty low-impact:

 include/linux/rmap.h    |    1 
 include/linux/swap.h    |    6 
 include/linux/swapops.h |   32 +++++
 mm/Kconfig              |    4 
 mm/memory.c             |    6 
 mm/migrate.c            |  242 ++++++++++++++++++++------------------
 mm/rmap.c               |   88 ++++---------
 mm/swapfile.c           |   15 --
 8 files changed, 212 insertions(+), 182 deletions(-)


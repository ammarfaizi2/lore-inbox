Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbUDASei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbUDASei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:34:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:33696 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263037AbUDASec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:34:32 -0500
Date: Thu, 1 Apr 2004 10:34:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-Id: <20040401103425.03ba8aff.akpm@osdl.org>
In-Reply-To: <20040401171625.GE791@holomorphy.com>
References: <20040401135920.GF18585@dualathlon.random>
	<20040401164825.GD791@holomorphy.com>
	<20040401165952.GM18585@dualathlon.random>
	<20040401171625.GE791@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Thu, Apr 01, 2004 at 08:48:25AM -0800, William Lee Irwin III wrote:
> >> Something like this would have the minor advantage of zero core impact.
> >> Testbooted only. vs. 2.6.5-rc3-mm4
> 
> On Thu, Apr 01, 2004 at 06:59:52PM +0200, Andrea Arcangeli wrote:
> > I certainly like this too (despite it's more complicated but it might
> > avoid us to have to add further sysctl in the future), Andrew what do
> > you prefer to merge? I don't mind either ways.

What is the Oracle requirement in detail?

If it's for access to hugetlbfs then there are the uid= and gid= mount
options.

If it's for access to SHM_HUGETLB then there was some discussion about
extending the uid= thing to shm, but nothing happened.  This could be
resurrected.

If it's just generally for the ability to mlock lots of memory then
RLIMIT_MEMLOCK would be preferable.  I don't see why we'd need the sysctl
when `ulimit -m' is available?  (Where is that patch btw?)

> There are a couple of off-by-ones in there I've got fixes for below.

Using the security framework is neat.  There are currently large spinlock
contention problems in avc_has_perm_noaudit() which I suspect will make
SELinux problematic in some server environments.  But I trust it is
possible to disable SELinux in config while using Bill's security module?


I guess we could live with sysctl which simply nukes CAP_IPC_LOCK, but it
has to be the when-all-else-failed option, yes?

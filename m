Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVBJTTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVBJTTI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVBJTTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:19:08 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:39837 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261441AbVBJTQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:16:58 -0500
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20050210190521.GN18573@opteron.random>
References: <20050203035605.C981A7046E@sv1.valinux.co.jp>
	 <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com>
	 <Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com>
	 <20050210190521.GN18573@opteron.random>
Content-Type: text/plain
Date: Thu, 10 Feb 2005 11:16:44 -0800
Message-Id: <1108063004.29712.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 20:05 +0100, Andrea Arcangeli wrote:
> Overall I see nothing wrong in preventing memory removal while rawio is
> in flight. rawio cannot be in flight forever (ptrace and core dump as
> well should complete eventually). Why can't you simply drop pages from
> the freelist one by one until all of them are removed from the freelist?

We actually do that, in addition to the more active methods of capturing
the memory that we're about to remove.

You're right, I don't really see a problem with ignoring those pages, at
least in the active migration code.  We would, of course, like to keep
the number of things that we depend on good faith to get migrated to a
minimum, but things under I/O are the least of our problems.

The only thing we might want to do is put something in the rawio code to
look for the PG_capture pages to ensure that it gives the migration code
a shot at them every once in a while (when I/O is not in flight,
obviously).

-- Dave


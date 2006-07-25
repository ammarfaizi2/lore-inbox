Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWGYCd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWGYCd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 22:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWGYCd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 22:33:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51681 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932414AbWGYCd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 22:33:26 -0400
Date: Mon, 24 Jul 2006 19:33:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [RFC] ps command race fix
Message-Id: <20060724193318.d57983c1.akpm@osdl.org>
In-Reply-To: <20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060724184847.3ff6be7d.pj@sgi.com>
	<20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006 11:08:35 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> > Then the seek and read and such semantics are nice and stable and
> > simple.
> > 
> yes...
> I think snapshot at open() is okay.

We cannot do a single kmalloc() like cpuset does.

The kernel presently kind-of guarantees that a 32k kmalloc() will work,
although the VM might have to do very large amounts of work to achieve it.

But 32k is only 8192 processes, so a snapshot will need multiple
allocations and a list and trouble dropping and retaking tasklist_lock to
allocate memory and keeping things stable while doing that.  I suspect
it'll end up ugly.

And it permits userspace to pin rather a lot of memory.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWGYCrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWGYCrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 22:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWGYCrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 22:47:23 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:19372 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932415AbWGYCrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 22:47:22 -0400
Date: Tue, 25 Jul 2006 11:50:04 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [RFC] ps command race fix
Message-Id: <20060725115004.a6c668ca.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060724193318.d57983c1.akpm@osdl.org>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060724184847.3ff6be7d.pj@sgi.com>
	<20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724193318.d57983c1.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006 19:33:18 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Tue, 25 Jul 2006 11:08:35 +0900
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
> > > Then the seek and read and such semantics are nice and stable and
> > > simple.
> > > 
> > yes...
> > I think snapshot at open() is okay.
> 
> We cannot do a single kmalloc() like cpuset does.
> 
> The kernel presently kind-of guarantees that a 32k kmalloc() will work,
> although the VM might have to do very large amounts of work to achieve it.
> 
> But 32k is only 8192 processes, so a snapshot will need multiple
> allocations and a list and trouble dropping and retaking tasklist_lock to
> allocate memory and keeping things stable while doing that.  I suspect
> it'll end up ugly.
> 

Hm, how about using bitmap instead of table ? (we'll have many holes but...)
Implementing
- sytem-wide bitmap of used tgid which is updated only when /proc is opened
seems not to be much problem. 32k kmalloc can store 256k pids.

BTW, how large pids and how many proccess in a (heavy and big) system ?

-Kame


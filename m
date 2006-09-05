Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWIEBih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWIEBih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 21:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWIEBih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 21:38:37 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:31695 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964951AbWIEBig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 21:38:36 -0400
Date: Tue, 5 Sep 2006 10:41:56 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [RFC][PATCH] ps command race fix take 4 [1/4] callback
 subroutine
Message-Id: <20060905104156.3a91e941.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <m17j0j5juc.fsf@ebiederm.dsl.xmission.com>
References: <20060825182505.5e9ddc8f.kamezawa.hiroyu@jp.fujitsu.com>
	<m17j0j5juc.fsf@ebiederm.dsl.xmission.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2006 16:48:43 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
> 
> > Updated some dirty codes. maybe easier to read than previous one.
> >
> > This ps command fix (proc_pid_readdir() fix) fixes the problem by
> >
> > - attach a callback for updating pointer from file descriptor to a task invoked
> >   at release_task()
> > - no additional global lock is required.
> > - walk through all and only task structs which is thread group leader.
> >
> > *Bad* point is adding additonal (small) lock and callback in exit path.
> With an unbounded callback chain length influenced by user space.
> 
yes. 1000 ps process will add 1000 chains. 1000 callbacks are called if a task is
removed while 1000 ps task points to it.


-Kame


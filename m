Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWHVLZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWHVLZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHVLZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:25:09 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:60390 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932172AbWHVLZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:25:07 -0400
Date: Tue, 22 Aug 2006 20:28:10 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, ebiederm@xmission.com, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ps command race fix take2 [3/4] profile fix
Message-Id: <20060822202810.30bfdb60.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <p737j1181tq.fsf@verdi.suse.de>
References: <20060822174152.7105aa33.kamezawa.hiroyu@jp.fujitsu.com>
	<p737j1181tq.fsf@verdi.suse.de>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Aug 2006 13:08:49 +0200
Andi Kleen <ak@suse.de> wrote:

> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
> 
> > ===================================================================
> > --- linux-2.6.18-rc4.orig/include/linux/sched.h
> > +++ linux-2.6.18-rc4/include/linux/sched.h
> > @@ -808,6 +808,10 @@ struct task_struct {
> >  	struct list_head ptrace_children;
> >  	struct list_head ptrace_list;
> >  
> > +#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
> > +	struct list_head 	dead_tasks;
> > +#endif
> 
> Sorry I think this needs a cleaner solution without ifdef.   Why can't it use
> the token list? Or some other list head that's unused then.
> 

I added them because oprofile doesn't need tokened-list. But adding new
member only for this seems a bit expensive as you point out.
I'll find another way, reuse some list_head or use tokened-list.

-Kame


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVL3WSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVL3WSy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVL3WSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:18:54 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:42673 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751049AbVL3WSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:18:54 -0500
Subject: Re: [PATCH] protect remove_proc_entry
From: Steven Rostedt <rostedt@goodmis.org>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1135980542.6039.84.camel@localhost.localdomain>
References: <1135973075.6039.63.camel@localhost.localdomain>
	 <1135978110.6039.81.camel@localhost.localdomain>
	 <20051230215544.GI27284@gaz.sfgoth.com>
	 <1135980542.6039.84.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 17:18:44 -0500
Message-Id: <1135981124.6039.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 17:09 -0500, Steven Rostedt wrote:

> Index: linux-2.6.15-rc7/fs/proc/generic.c
> ===================================================================
> --- linux-2.6.15-rc7.orig/fs/proc/generic.c	2005-12-30 14:19:39.000000000 -0500
> +++ linux-2.6.15-rc7/fs/proc/generic.c	2005-12-30 17:05:56.000000000 -0500
> @@ -693,6 +693,8 @@
>  	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
>  		goto out;
>  	len = strlen(fn);
> +
> +	lock_kernel();
>  	for (p = &parent->subdir; *p; p=&(*p)->next ) {
>  		if (!proc_match(len, fn, *p))
>  			continue;
> @@ -713,6 +715,7 @@
>  		}
>  		break;
>  	}
> +	unlock_kernel();
>  out:
>  	return;
>  }
> 

FYI, to make sure that this solves the problem, I'm removing my locking
in my kernel and using this instead.  It usually crashes in a day or
two, so I can say this works if it makes it three days.

-- Steve



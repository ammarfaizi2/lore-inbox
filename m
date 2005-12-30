Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVL3V4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVL3V4D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 16:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVL3V4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 16:56:03 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:54481 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S964789AbVL3V4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 16:56:01 -0500
Date: Fri, 30 Dec 2005 13:55:44 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] protect remove_proc_entry
Message-ID: <20051230215544.GI27284@gaz.sfgoth.com>
References: <1135973075.6039.63.camel@localhost.localdomain> <1135978110.6039.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135978110.6039.81.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Fri, 30 Dec 2005 13:55:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> I've added a global remove_proc_lock to protect this section of code.  I
> was going to add a lock to proc_dir_entry so that the locking is only
> cut down to the same parent, but since this function is called so
> infrequently, why waste more memory then is needed.  One global lock
> should not cause too much of a headache here.

Are you sure that it's the only place where we need guard ->subdir?  It
looks like proc_lookup() and proc_readdir() use the BLK when walking that
list, so probably the best fix would be to use that lock everywhere else
->subdir is touched

-Mitch

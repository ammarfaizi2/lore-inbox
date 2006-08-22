Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWHVLLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWHVLLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWHVLLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:11:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:27364 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932170AbWHVLLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:11:40 -0400
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ps command race fix take2 [4/4] proc_pid_readdir
References: <20060822174302.e97f23d1.kamezawa.hiroyu@jp.fujitsu.com>
From: Andi Kleen <ak@suse.de>
Date: 22 Aug 2006 13:11:30 +0200
In-Reply-To: <20060822174302.e97f23d1.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <p733bbp81p9.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:

> proc_pid_readdir() by list_token.
> 
> Remember 'where we are reading' by inserting a token in the list.
> It seems a bit complicated because of RCU but what we do is very simple.
> 

What happens when you have multiple readers at the same time? Can't
the tokens then be mixed up?

>+		/* this small kmalloc() can fail in rare case, but readdir()
>+		 * is not allowed to return ENOMEM. retrying is reasonable. */

Who disallows this? Such retry loops are normally discouraged 
because they can lead to deadlocks in OOM situations.
I think it would be better to just return ENOMEM.

-Andi

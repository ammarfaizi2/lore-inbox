Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWCAUp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWCAUp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWCAUp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:45:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36531 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932433AbWCAUp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:45:58 -0500
Message-ID: <4406058A.1090303@redhat.com>
Date: Wed, 01 Mar 2006 15:35:22 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       laurent.riffard@free.fr, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, mbligh@mbligh.org,
       clameter@engr.sgi.com, ebiederm@xmission.com
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org>	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>	<4404CE39.6000109@liberouter.org>	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>	<4404DA29.7070902@free.fr>	<20060228162157.0ed55ce6.akpm@osdl.org>	<4405723E.5060606@free.fr>	<20060301023235.735c8c47.akpm@osdl.org>	<1141221511.7775.10.camel@homer>	<4405B4AA.7090207@free.fr>	<1141227199.10460.2.camel@homer> <20060301121218.68fb3f76.akpm@osdl.org>
In-Reply-To: <20060301121218.68fb3f76.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Maybe you're not running applications which install inotify watches.  This
>is apparently triggerable by doing `touch foo;rm foo;touch foo' in a watched
>directory.
>
>Nick, isn't it simply a matter of..
>
>--- devel/fs/dcache.c~inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix	2006-03-01 12:10:48.000000000 -0800
>+++ devel-akpm/fs/dcache.c	2006-03-01 12:11:33.000000000 -0800
>@@ -173,6 +173,7 @@ repeat:
> 		goto kill_it;
>   	if (list_empty(&dentry->d_lru)) {
>   		dentry->d_flags |= DCACHE_REFERENCED;
>+		dentry->d_flags &= DCACHE_INOTIFY_PARENT_WATCHED;
>   		list_add(&dentry->d_lru, &dentry_unused);
>   		dentry_stat.nr_unused++;
>   	}
>_
>
>-
>

This doesn;t look quite corect to me.  First set DCACHE_REFERENCED in
the d_flags and then clear every bit in d_flags except
DCACHE_INOTIFY_PARENT_WATCHED?  Should this be 
"~DCACHE_INOTIFY_PARENT_WATCHED"?

    Thanx...

       ps

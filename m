Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287645AbRLaUkw>; Mon, 31 Dec 2001 15:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287481AbRLaUkc>; Mon, 31 Dec 2001 15:40:32 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:54986 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S287649AbRLaUkW>;
	Mon, 31 Dec 2001 15:40:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Dave Jones <davej@suse.de>
Subject: Re: [patch] Prefetching file_read_actor()
Date: Mon, 31 Dec 2001 12:40:19 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0112312045130.17274-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112312045130.17274-100000@Appserv.suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16L9EJ-0004Rf-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 31, 2001 11:47, Dave Jones wrote:
> Completly puzzled right now. Moving the prefetching to copy_to_user
> (and doing the tlb preload & prefetching the whole chunk to be copied
> (or cachesize if smaller)) results in a performance drop instead of a win.
>
> My initial guess is that some of the callers of copy_to_user are
> doing something that is harmed the prefetching.
> (Maybe they are doing additional prefetch() calls)

Maybe syscalls that only have to move a very small chunk of data 
(gettimeofday(2), for instance), are hurt because of the wasted bytes they 
are prefetching after the intended data? Also, for sizes greater than 512, 
copy_to_user will call mmx_copy_user, which might call mmx_memcpy, which does 
prefetching already on x86 CPUs that support it.

-Ryan

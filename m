Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSJEAhg>; Fri, 4 Oct 2002 20:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261585AbSJEAhg>; Fri, 4 Oct 2002 20:37:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32007 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261907AbSJEAhf>; Fri, 4 Oct 2002 20:37:35 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [patch] futex-2.5.40-B5
Date: Sat, 5 Oct 2002 00:42:28 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <anlchk$1d0$1@penguin.transmeta.com>
References: <3D9E2B8A.653BEF9D@tv-sign.ru>
X-Trace: palladium.transmeta.com 1033778568 12968 127.0.0.1 (5 Oct 2002 00:42:48 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 5 Oct 2002 00:42:48 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3D9E2B8A.653BEF9D@tv-sign.ru>,
Oleg Nesterov  <oleg@tv-sign.ru> wrote:
>Hello.
>
>Ingo Molnar wrote:
>>   the new lookup code first does a lightweight follow_page(), then if no
>>   page is present we do the get_user_pages() thing.
>
>What if futex placed in VM_HUGETLB area?
>Then follow_page() return garbage.
>
>I beleive in i386 case it can be fixed something like this:

This will fix it for i386, but will break it for all other
architectures, as you're now depending on a x86-specific implementation
detail in an arch-independent file using a generic CONFIG test..

>Then follow_hugetlb_page() hook can be killed.

I'd much rather have a hook that works, than having #ifdef's in code
that don't..

		Linus

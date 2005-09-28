Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVI1PCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVI1PCc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 11:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVI1PCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 11:02:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15282 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751026AbVI1PCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 11:02:32 -0400
Date: Wed, 28 Sep 2005 08:01:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: KUROSAWA Takahiro <kurosawa@valinux.co.jp>, taka@valinux.co.jp,
       magnus.damm@gmail.com, dino@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] cpuset read past eof memory leak fix
In-Reply-To: <20050928064224.49170ca7.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0509280758560.3308@g5.osdl.org>
References: <20050908225539.0bc1acf6.pj@sgi.com> <20050909.203849.33293224.taka@valinux.co.jp>
 <20050909063131.64dc8155.pj@sgi.com> <20050910.161145.74742186.taka@valinux.co.jp>
 <20050910015209.4f581b8a.pj@sgi.com> <20050926093432.9975870043@sv1.valinux.co.jp>
 <20050927013751.47cbac8b.pj@sgi.com> <20050927113902.C78A570046@sv1.valinux.co.jp>
 <20050928092558.61F6170041@sv1.valinux.co.jp> <20050928064224.49170ca7.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied. 

Just a non-technical note: the sign-offs makes me suspect the patch (or an 
earlier version of it) may have been written by Kurosawa-san. However, it 
wasn't clear, so I didn't make that change, and so it now ends up being in 
git with Paul as the author.

If that was wrong, please for the future keep authorship intact by having 
a "From: A U Thor <author@mailbox.com>" at the head of the description, 
which will make authorship clear and allow the tools to pick that up.

		Linus

On Wed, 28 Sep 2005, Paul Jackson wrote:
>
> Don't leak a page of memory if user reads a cpuset file past eof.
> 
> Signed-off-by: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
> Signed-off-by: Paul Jackson <pj@sgi.com>
> 
> --- linux-2.6.14-rc2.orig/kernel/cpuset.c
> +++ linux-2.6.14-rc2/kernel/cpuset.c	2005-09-28 17:42:00.759401736 +0900
> @@ -969,7 +969,7 @@ static ssize_t cpuset_common_file_read(s
...

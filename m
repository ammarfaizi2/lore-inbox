Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751879AbWJWK3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbWJWK3k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWJWK3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:29:40 -0400
Received: from smtpout.mac.com ([17.250.248.185]:23756 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751880AbWJWK3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:29:39 -0400
In-Reply-To: <m1y7r7wl2e.fsf@ebiederm.dsl.xmission.com>
References: <m13b9fxzs0.fsf@ebiederm.dsl.xmission.com> <m1y7r7wl2e.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <837CA6CF-DA35-4AAF-8F92-0912B7D3166D@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jakub Jelinek <jakub@redhat.com>, Mike Galbraith <efault@gmx.de>,
       Albert Cahalan <acahalan@gmail.com>,
       Bill Nottingham <notting@redhat.com>,
       Marco Roeland <marco.roeland@xs4all.nl>,
       Linus Torvalds <torvalds@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFD][PATCH 2/2] sysctl:  Implement CTL_UNNUMBERED
Date: Mon, 23 Oct 2006 06:28:15 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 23, 2006, at 03:25:13, Eric W. Biederman wrote:
> --- a/fs/lockd/svc.c
> -/* Something that isn't CTL_ANY, CTL_NONE or a value that may  
> clash. */
> -#define CTL_UNNUMBERED		-2
> -

> --- a/fs/nfs/sysctl.c
> -/*
> - * Something that isn't CTL_ANY, CTL_NONE or a value that may clash.
> - * Use the same values as fs/lockd/svc.c
> - */
> -#define CTL_UNNUMBERED -2

> +++ b/include/linux/sysctl.h
>  #ifdef __KERNEL__
>  #define CTL_ANY		-1	/* Matches any name */
>  #define CTL_NONE	0
> +#define CTL_UNNUMBERED	CTL_NONE	/* sysctl without a binary number */
>  #endif

This change looks totally broken.  Before this patch, CTL_UNNUMBERED  
== -2, a number that isn't CTL_ANY, CTL_NONE, or a valid sysctl  
number.  After this patch, CTL_UNNUMBERED == 0, or CTL_NONE.

Cheers,
Kyle Moffett


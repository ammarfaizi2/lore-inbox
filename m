Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292293AbSCEWhz>; Tue, 5 Mar 2002 17:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292536AbSCEWhg>; Tue, 5 Mar 2002 17:37:36 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:19731 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S292656AbSCEWgn>; Tue, 5 Mar 2002 17:36:43 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 5 Mar 2002 14:39:53 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16i8x2-0008TV-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0203051433400.1475-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Rusty Russell wrote:

> +	pos_in_page = ((unsigned long)uaddr) % PAGE_SIZE;
> +
> +	/* Must be "naturally" aligned, and not on page boundary. */
> +	if ((pos_in_page % __alignof__(atomic_t)) != 0
> +	    || pos_in_page + sizeof(atomic_t) > PAGE_SIZE)
> +		return -EINVAL;

How can this :

	(pos_in_page % __alignof__(atomic_t)) != 0

to be false, and together this :

	pos_in_page + sizeof(atomic_t) > PAGE_SIZE

to be true ?
This is enough :

	if ((pos_in_page % __alignof__(atomic_t)) != 0)




- Davide



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266650AbSLJUti>; Tue, 10 Dec 2002 15:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266712AbSLJUti>; Tue, 10 Dec 2002 15:49:38 -0500
Received: from [66.70.28.20] ([66.70.28.20]:9988 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266650AbSLJUtg>; Tue, 10 Dec 2002 15:49:36 -0500
Date: Tue, 10 Dec 2002 21:59:06 +0100
From: DervishD <raul@pleyades.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [BK-2.4] [PATCH] Small do_mmap_pgoff correction
Message-ID: <20021210205906.GA82@DervishD>
References: <200212101931.gBAJV1K10639@hera.kernel.org> <20021210.121908.00373632.davem@redhat.com> <20021210204530.GA63@DervishD> <20021210.124740.86261163.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021210.124740.86261163.davem@redhat.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi David :)

>    >    + *	NOTE: in this function we rely on TASK_SIZE being lower than
>    >    + *	SIZE_MAX-PAGE_SIZE at least. I'm pretty sure that it is.
>    > This assumption is wrong.
>        OK, then another way of fixing the corner case that exists in
>    do_mmap_pgoff is needed. You cannot mmap a chunk of memory whose size
>    is bigger than SIZE_MAX-PAGE_SIZE, because 'PAGE_ALIGN' will return 0
>    when page-aligning the size.
> And after your patch, we'd use a zero length.  That is a bug.

    With my patch, we don't use a zero length :?? My patch sees if
PAGE_ALIGN will f*ck the length, and if so, it returns EINVAL. This
is better than getting '0' as a valid address when specifying a large
size, don't you think so?

> Look at what happens, you PAGE_ALIGN(len) after all the range checks
> then we use a len of '0' for the rest of the function.  How is that
> supposed to be better?

    Because PAGE_ALIGN won't return 0? I don't see your assumption of
'len' going to zero due to my patch :?? With my patch, if the
requested size is '0', then the hint address is returned, and if the
size is so high that PAGE_ALIGN will barf at it, returning 0 when it
shouldn't, mmap will return EINVAL. The function never uses a 'len'
of 0. Never.

    Raúl

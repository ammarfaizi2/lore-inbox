Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271747AbRIJV00>; Mon, 10 Sep 2001 17:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271789AbRIJV0R>; Mon, 10 Sep 2001 17:26:17 -0400
Received: from d117.dhcp212-140.cybercable.fr ([212.198.140.117]:20572 "HELO
	pridamix.molteni.net") by vger.kernel.org with SMTP
	id <S271747AbRIJV0F>; Mon, 10 Sep 2001 17:26:05 -0400
Message-ID: <3B9D3001.AF91D8B4@molteni.net>
Date: Mon, 10 Sep 2001 23:26:25 +0200
From: Olivier Molteni <olivier@molteni.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops NFS Locking in 2.4.x
In-Reply-To: <3B9C0D36.3EA20B24@molteni.net> <shsae03fizs.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>
> Looks like 2 processes are trying to free the same lock. The problem
> is that both processes can call filp_close() at the same
> time (by calling sys_close()).
>
> The bug boils down to:
>
>    -  locks_unlock_delete() assumes that the BKL (kernel_lock()) is
>       sufficient to protect against *thisfl_p from disappearing
>       beneath it due to some second process.
> BUT
>    -  The call to lock() in locks_unlock_delete() sleeps when the
>       underlying filesystem is NFS, hence 2 processes can race despite
>       the BKL assumption.
>
> Cheers,
>    Trond

Hi (2),

While searching on the sourceforge nfs list, I saw your message 4583160
posted on 10/31/2000 08:14:42 and concerning "[NFS] [PATCH] fix deadlocks
+ blocking in 2.4.0 pre6/7 knfsd locking..."
You give a patch modifying fs/loks.c wher, among other things, you were
added the new function locks_unlock_delete().

Do you know if all the patch had been included in the kernel or if some
part that deals with deadlocks were omited for some reasons ?
Do you think this corrections failed to definitively fix the deadlocks
problems ?

You are talking about semaphores in your post, do you think it's a
possible way to follow in order to fix the situation ?


Cheers,
Olivier.




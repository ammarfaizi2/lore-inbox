Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271658AbRIJT4w>; Mon, 10 Sep 2001 15:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271665AbRIJT4n>; Mon, 10 Sep 2001 15:56:43 -0400
Received: from d117.dhcp212-140.cybercable.fr ([212.198.140.117]:7259 "HELO
	pridamix.molteni.net") by vger.kernel.org with SMTP
	id <S271658AbRIJT43>; Mon, 10 Sep 2001 15:56:29 -0400
Message-ID: <3B9D1B01.53B0A391@molteni.net>
Date: Mon, 10 Sep 2001 21:56:49 +0200
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

Hi,
Thank for your help !!

I'm not a developper, but I would like to try to do something about
that...
Do you think that trying to replace the sleep by an other type of waiting
(at worst looping just to test the idea) could work ?

Cheers,
Olivier.





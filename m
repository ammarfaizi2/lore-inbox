Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRBZXk2>; Mon, 26 Feb 2001 18:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbRBZXkR>; Mon, 26 Feb 2001 18:40:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:62517 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129245AbRBZXkB>; Mon, 26 Feb 2001 18:40:01 -0500
Date: Tue, 27 Feb 2001 00:41:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rico Tudor <rico@patrec.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] highmem-2.4.2-A0
Message-ID: <20010227004111.A7143@athlon.random>
In-Reply-To: <20010226181049.G29254@athlon.random> <Pine.LNX.4.30.0102262139420.7414-200000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0102262139420.7414-200000@elte.hu>; from mingo@elte.hu on Mon, Feb 26, 2001 at 09:44:16PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 09:44:16PM +0100, Ingo Molnar wrote:
> -ac4. Differences: no need to complicate highmem.c with pool-fillup on
> bootup. It will get refilled after the first disk-accesses anyway.

I considered that, in practice it isn't going to make any difference, I
_totally_ agree. But to be also theorically correct we must refill it at boot
as well because we don't have the guarantee that the private pool isn't
necessary at the first I/O. As I just implemented it, I think it certainly
worth to keep it as the only penality will be a few more bytes in the bzImage.

> i'm unsure about the other changes done by your patch, could you explain
> them? Notably the pgalloc-3level.h and fault.c changes. Thanks,

I commented them in another parallel threads in l-k in the last days (I
included them into the code because I have stack traces with PAE that shows
weird things that at first looked closely related to the vmalloc race, but
quite frankly I still couldn't completly explain how the vmalloc race could
trigger such weird traces). Maybe it was the wakeup_bdflush(1) potential stack
overflow. I'm waiting feedback from the people who can reproduce.

Andrea

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274610AbRITS7H>; Thu, 20 Sep 2001 14:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274612AbRITS65>; Thu, 20 Sep 2001 14:58:57 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:44303 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S274610AbRITS6i>; Thu, 20 Sep 2001 14:58:38 -0400
Message-ID: <3BAA3C6D.AC20D953@zip.com.au>
Date: Thu, 20 Sep 2001 11:58:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Chris Mason <mason@suse.com>,
        "Dieter =?iso-8859-1?Q?N=FCtzel?=" <Dieter.Nuetzel@hamburg.de>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Andrew Morton <andrewm@uow.edu.au>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com> <773660000.1001006393@tiny>,
		<773660000.1001006393@tiny>; from mason@suse.com on Thu, Sep 20, 2001 at 01:19:53PM -0400 <20010920204712.T729@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> --- 2.4.10pre12aa2/fs/buffer.c.~1~      Thu Sep 20 20:14:19 2001
> +++ 2.4.10pre12aa2/fs/buffer.c  Thu Sep 20 20:45:58 2001
> @@ -2506,7 +2506,7 @@
>         spin_unlock(&free_list[isize].lock);
> 
>         page->buffers = bh;
> -       page->flags &= ~(1 << PG_referenced);
> +       page->flags |= 1 << PG_referenced;

I don't see how this can change anything - getblk() calls
touch_buffer() shortly afterwards, which does the same
thing?

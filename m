Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129932AbQKFIyA>; Mon, 6 Nov 2000 03:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129036AbQKFIxv>; Mon, 6 Nov 2000 03:53:51 -0500
Received: from cr630205-a.crdva1.bc.wave.home.com ([24.113.89.232]:48116 "EHLO
	ryan") by vger.kernel.org with ESMTP id <S129034AbQKFIxn>;
	Mon, 6 Nov 2000 03:53:43 -0500
Message-ID: <3A05F6B9.6A6BE9C7@netidea.com>
Date: Sun, 05 Nov 2000 16:09:29 -0800
From: ryan <ryan@netidea.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-raid i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Kernel 2.4.0test10 crash (RAID+SMP)
In-Reply-To: <1459.973469046@kao2.melbourne.sgi.com>
		<3A060BE5.8877F477@netidea.com> <14854.8617.282831.205647@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks like an interupt is happening while another interrupt is
> happening, which should be impossible... but it isn't.

Dont you love SMP? ;-)

> 
> raid1.c:end_sync_write calls raid1_free_buff which calls
> spin_lock_irq()/spin_unlock_irq(), which unmasks interrupts.  but
> end_sync_write is called from interupt context.  This is bad.
> 
> Try:
[patch goes here]
> 

This infact fixes the problem completely.  You probably already
suspected it did, but for verification it works like a charm.  Inclusion
into 2.4.0test11/whatever would probably be a Good Thing.

-ryan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277828AbRJIQup>; Tue, 9 Oct 2001 12:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277826AbRJIQug>; Tue, 9 Oct 2001 12:50:36 -0400
Received: from colorfullife.com ([216.156.138.34]:65297 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S277823AbRJIQuV>;
	Tue, 9 Oct 2001 12:50:21 -0400
Message-ID: <000901c150e2$97765470$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Richard Henderson" <rth@twiddle.net>
Cc: <linux-kernel@vger.kernel.org>,
        "\"Paul E. McKenney\"" <pmckenne@us.ibm.com>
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Date: Tue, 9 Oct 2001 18:51:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Tue, Oct 09, 2001 at 07:03:37PM +1000, Rusty Russell wrote:
> > I don't *like* making Alpha's wmb() stronger, but it is the
> > only solution which doesn't touch common code.
>
> It's not a "solution" at all.  It's so heavy weight you'd be
> much better off with locks.  Just use the damned rmb_me_harder.

rmb_me_harder? smp_mb__{before,after}_{atomic_dec,clear_bit} are already ugly enough.

What about hiding all these details in the list access macros? list_insert, list_get_next, etc. With a default implementation based
on a spinlock, and the capable SMP architectures could define an optimized version.

Then Alpha could do whatever flushing is required. But please do not scatter memory barrier instructions all around the kernel.

--
    Manfred


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131520AbQKQKWM>; Fri, 17 Nov 2000 05:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131487AbQKQKWC>; Fri, 17 Nov 2000 05:22:02 -0500
Received: from [213.8.185.152] ([213.8.185.152]:48400 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S131520AbQKQKVw>;
	Fri, 17 Nov 2000 05:21:52 -0500
Date: Fri, 17 Nov 2000 11:51:20 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Jacob Luna Lundberg <jacob@velius.chaos2.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (2.4)] atomic use count for proc_dir_entry
In-Reply-To: <Pine.LNX.4.21.0011170026130.10109-100000@velius.chaos2.org>
Message-ID: <Pine.LNX.4.21.0011171145190.28801-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Jacob Luna Lundberg wrote:

> On Fri, 17 Nov 2000, Dan Aloni wrote:
> > If you are right, I guess put_files_struct() of kernel/exit.c would
> > have cleaned files_struct everytime someones called it. 
> > Everywhere in the kernel, objects are freed when
> > atomic_dec_and_test() returns true.
> 
> Indeed, after studying the asm in question I think I see how it ticks.
> What is the reasoning behind reversing the result of the test instead of
> returning the new value of the counter?

Well, at 98% of the cases the code is in position where it 'ought to do
something' when the counter is 0, and do nothing when it's not, so instead
of not()'ing the counter value in the condition check, we just return the
value not()'ed already.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

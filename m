Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130875AbQLYQj3>; Mon, 25 Dec 2000 11:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131752AbQLYQjT>; Mon, 25 Dec 2000 11:39:19 -0500
Received: from mout0.freenet.de ([194.97.50.131]:20683 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S131750AbQLYQjI>;
	Mon, 25 Dec 2000 11:39:08 -0500
From: Andreas Franck <afranck@gmx.de>
Date: Mon, 25 Dec 2000 13:29:20 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.Linu.4.10.10012250531020.560-100000@mikeg.weiden.de>
In-Reply-To: <Pine.Linu.4.10.10012250531020.560-100000@mikeg.weiden.de>
Subject: Re: Fatal Oops on boot with 2.4.0testX and recent GCC snapshots
Cc: Mike Galbraith <mikeg@wen-online.de>
MIME-Version: 1.0
Message-Id: <00122513292000.00531@dg1kfa.ampr.org>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike, hello linux-kernel hackers,

Mike Galbraith wrote:
> I wouldn't (not going to here;) spend a lot of time on it.  The compiler
> has problems.  It won't build glibc-2.2, and chokes horribly on ipchains.

Maybe, but after having spent several hours debugging now, I think it was 
worth it: I am almost sure this is not a gcc bug, but a nasty race condition 
involving the semaphore handling bdflush_init. 

I figured out by spilling some printk's around in bdflush_init, which made 
the bug magically disappear, what wasn't what I intended - but which gave me 
a clearer impression of what's going on.

It seems that whyever, the cause for this failure is actually the down(sem) 
call on a not yet up()'ed semaphore, and this is where it starts to get ugly.


-- 
->>>----------------------- Andreas Franck --------<<<-
---<<<---- Andreas.Franck@post.rwth-aachen.de --->>>---
->>>---- Keep smiling! ----------------------------<<<-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

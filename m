Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267556AbRG2HMg>; Sun, 29 Jul 2001 03:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267563AbRG2HM0>; Sun, 29 Jul 2001 03:12:26 -0400
Received: from fozzie.eye-net.com.au ([203.41.228.19]:13484 "HELO
	fozzie.eye-net.com.au") by vger.kernel.org with SMTP
	id <S267556AbRG2HMP>; Sun, 29 Jul 2001 03:12:15 -0400
Date: Sun, 29 Jul 2001 17:12:09 +1000
To: Massimo Dal Zotto <dz@cs.unitn.it>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: strange problem with reiserfs and /proc fs
Message-ID: <20010729171209.D13366@eye-net.com.au>
In-Reply-To: <200107282004.f6SK455d002773@dizzy.dz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107282004.f6SK455d002773@dizzy.dz.net>
User-Agent: Mutt/1.3.18i
From: csmall@eye-net.com.au (Craig Small)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 28, 2001 at 10:04:05PM +0200, Massimo Dal Zotto wrote:
> I've found a strange problem with reiserfs. In some situations it interferes
> with the /proc filesystem and makes all processes unreadable to top. After
> a few seconds the situation returns normal. To verify the problem try the
> following procedure:
Have to be one of the strangest bugs I've seen.  Makes be a bit lucky
that reiser will oops on my machine so I cannot use it...
I have also passed this bug onto the procps author, who may be able to
shed a bit more light on the problem.

> 3)	type a few characters and save the file with C-x C-s. After the
> 	file is saved top will show 0 processes. Sometimes it will show
> 	only a few processes for an istant and then nothing. Sometimes
> 	it will work fine. After a few seconds the missing processes
> 	will show again. Modifying and saving the file again will show
> 	the same behavior.
When you say top prints nothing do you mean it only prints the header
and no processes in the list?  Does this problem happen with any other
program, say vi, or only in emacs?  Does ps have this bevhavour?

> In the attachments you will find two traces of the running top, one behaving
> normally and one exhibiting the problem, and my kernel config.
The interesting difference is that the good program does
stat64,open,read,close...
But the bad program does is just stat64.
I get 96 stat64s for both programs in that loop.

So obviously top doesn't like whatever stat64 is telling it.
Looking at the code (in readproc() in proc/readproc.c if anyone is
interested) I cannot see much that should upset it.  We know stat is
returning 0 so that is ok, about the only other thing is a alloc.

If you like, you can submit this as a bug report into the Debian Bug
Tracking System, but I suspect there is a kernel problem here giving
wierd stat returns for proc.
  - Craig
-- 
Craig Small VK2XLZ  GnuPG:1C1B D893 1418 2AF4 45EE  95CB C76C E5AC 12CA DFA5
Eye-Net Consulting http://www.eye-net.com.au/        <csmall@eye-net.com.au>
MIEEE <csmall@ieee.org>                 Debian developer <csmall@debian.org>

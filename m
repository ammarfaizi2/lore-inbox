Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131393AbRCSKgg>; Mon, 19 Mar 2001 05:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131408AbRCSKg1>; Mon, 19 Mar 2001 05:36:27 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:10308 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S131395AbRCSKgM>; Mon, 19 Mar 2001 05:36:12 -0500
Date: Mon, 19 Mar 2001 12:35:19 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: kees <kees@schoen.nl>
Cc: Aaron Lunansky <alunansky@rim.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'kees@shoen.nl'" <kees@shoen.nl>
Subject: Re: [OT] how to catch HW fault
Message-ID: <20010319123519.E5316@niksula.cs.hut.fi>
In-Reply-To: <A9FD1B186B99D4119BCC00D0B75B4D8104D4AA30@xch01ykf.rim.net> <Pine.LNX.4.21.0103182107460.20316-100000@schoen3.schoen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103182107460.20316-100000@schoen3.schoen.nl>; from kees@schoen.nl on Sun, Mar 18, 2001 at 09:11:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2001 at 09:11:46PM +0100, you [kees] claimed:
> Hi,
> 
> I tried memtest86 for 24 hours also and that didn't gave a clue. When bad
> ram was really involved I'd expected to find things like:
> failing fsck's, failing kernel compiles and such. But none of them
> the system runs perfect if it doesn't freeze(lockup).
> 
> So yes, only the CPU's and the mobo are at question. What I was looking
> for was a tool like memtest86 but now for motherboards.....

You really cannot say that bad memory is involved ONLY when fsck's fail and
kernel compiled fail. No way. 

Think about it: that failing bit can well be in a place that kernel never
touches, and gcc usually does not touch. Moreover the bit flip usually does
not happen every time; you have to stress the memory for hours and sometimes
use a specific bit pattern to trigger the problem.

I had one machine that compiled kernel just fine, and ran pretty smoothly
overall, but experienced weird hickups like dying apps, failing oracle
install etc. Not too much though, I was attributing them to buggy software.
Then I tried to take a large backup. Bzip failed (internal error) one third
of the time, and once produced a different result. I quickly hacked up an
user space memory tester, and sure enough it reported an error after five
hours. (The machine was already in production, so I couldn't just take it
down and launch memtest86.) I verified the problem with memtest86 during the
next night, and applied the marvellous badmem patch to the kernel. After
marking the problematic place unuable, all problem disappeared. I just lost
2MB out of 256.

What I learned is that spotting meory error can be difficult, and the
symptoms can be stealthy.


-- v --

v@iki.fi

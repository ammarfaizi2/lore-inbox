Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289102AbSBGTxO>; Thu, 7 Feb 2002 14:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291246AbSBGTxH>; Thu, 7 Feb 2002 14:53:07 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55290 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289102AbSBGTwY>;
	Thu, 7 Feb 2002 14:52:24 -0500
Message-ID: <3C62DABA.3020906@us.ibm.com>
Date: Thu, 07 Feb 2002 11:51:22 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020202
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Robert Love <rml@tech9.net>, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel@vger.kernel.org, mingo@elte.hu, nigel@nrg.org
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C629F91.2869CB1F@dlr.de>,		<3C629F91.2869CB1F@dlr.de> <1013107259.10430.29.camel@phantasy> <3C62D49A.4CBB6295@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Robert Love wrote:
>>On Thu, 2002-02-07 at 10:38, Martin Wirth wrote:
>>Some of the talk I've heard has been toward an adaptive lock.  These are
>>locks like Solaris's that can spin or sleep, usually depending on the
>>state of the lock's holder.  Another alternative, which I prefer since
>>it is much less overhead, is a lock that spins-then-sleeps
>>unconditionally.
> I dunno.  The spin-a-bit-then-sleep lock has always struck me as
> i_dont_know_what_the_fuck_im_doing_lock().  Martin's approach puts
> the decision in the hands of the programmer, rather than saying
> "Oh gee I goofed" at runtime.

The spin-then-sleep lock could be interesting as a replacement for the 
BKL in places where a semaphore causes performance degredation.  In 
quite a few places where we replaced the BKL with a more finely grained 
semapore (not a spinlock because we needed to sleep during the hold), 
instead of spinning for a bit, it would schedule instead.  This was bad 
:).  Spin-then-sleep would be great behaviour in this situation.

-- 
Dave Hansen
haveblue@us.ibm.com


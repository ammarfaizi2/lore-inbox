Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291324AbSBMCxU>; Tue, 12 Feb 2002 21:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291321AbSBMCxK>; Tue, 12 Feb 2002 21:53:10 -0500
Received: from holomorphy.com ([216.36.33.161]:12965 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291320AbSBMCxE>;
	Tue, 12 Feb 2002 21:53:04 -0500
Date: Tue, 12 Feb 2002 18:52:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What is a livelock? (was: [patch] sys_sync livelock fix)
Message-ID: <20020213025246.GJ767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <3C69A18A.501BAD42@zip.com.au> <3C69A18A.501BAD42@zip.com.au> <87y9hyw4b6.fsf@tigram.bogus.local> <3C69C7E9.E01C3532@zip.com.au> <87pu3aw1ue.fsf@tigram.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <87pu3aw1ue.fsf@tigram.bogus.local>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 03:30:01AM +0100, Olaf Dietsche wrote:
> I still don't get it :-(. When there is more work, this more work
> needs to be done. So, how could livelock be considered a bug? It's
> just overload. Or is this about the work, which must be done _after_
> the queue is empty?

The false assumption made here is that it has exclusive access to the
queue for the duration. It appears to acquire the lock, dequeue one, 
drop the lock, do some work, and return to the queue. During the time
between the lock being released and then being reacquired more work
can be generated, ensuring nontermination, as it iterates until the
queue is empty, which can never happen while work is generated at a
faster rate than it can process.


Cheers,
Bill

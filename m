Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbRBAHxB>; Thu, 1 Feb 2001 02:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129272AbRBAHwm>; Thu, 1 Feb 2001 02:52:42 -0500
Received: from smtp.mountain.net ([198.77.1.35]:15121 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S129210AbRBAHwj>;
	Thu, 1 Feb 2001 02:52:39 -0500
Message-ID: <3A7915AF.5C9C54CF@mountain.net>
Date: Thu, 01 Feb 2001 02:52:15 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Ford <david@linux.com>, Stephen Frost <sfrost@snowman.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
In-Reply-To: <E14NxKP-0002KH-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > It's not an incompatibility with the k7 chip, just bad code in
> > include/asm-i386/string.h. in_interrupt() cannot be called from there.
> 
> The string.h code was fine, someone came along and put in a ridiculous loop
> in the include dependancies and broke it. Nobody has had the time to untangle
> it cleanly since

Yes, bitrot. I don't see a rearrangement of system headers happening in 2.4.
I'm pretty sure if I committed such a patch it would have no measurable
lifetime.

> 
> > I have posted a patch here many times since last May. Most recent was
> > Saturday.
> 
> uninlining the code is too high a cost.

I question that. Athlon does branch prediction on call targets, function
calls are cheap. 3dnow saves 25%-50% of cycles on a copy. How many function
calls can be paid for with 1000 cycles or so?

My patch still inlines the standard string const_memcpy for the case of
small known length.

If I configure SMP for a UP box, performance is clearly not my first
concern. If I have a real SMP Athlon system, performance should not improve
by only using one processor.

How about we get it to build before we optimize it?

Regards,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

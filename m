Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287591AbSAPVHt>; Wed, 16 Jan 2002 16:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287593AbSAPVHk>; Wed, 16 Jan 2002 16:07:40 -0500
Received: from zero.tech9.net ([209.61.188.187]:10506 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287588AbSAPVHY>;
	Wed, 16 Jan 2002 16:07:24 -0500
Subject: Re: [PATCH] I3 sched tweaks...
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201162343290.18971-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201162343290.18971-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 16 Jan 2002 16:10:09 -0500
Message-Id: <1011215440.814.82.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-16 at 17:46, Ingo Molnar wrote:

> we pass pointers across functions regularly, even if the pointer could be
> calculated within the function. We do this in the timer code too. It's
> slightly cheaper to pass an already existing (calculated) 'current'
> pointer over to another function, instead of calculating it once more in
> that function. This will be especially true once we make 'current' a tiny
> bit more expensive (Alan's kernel stack coloring rewrite will do that i
> think, it will be one more instruction to get 'current'.)

Maybe we should benchmark it?  It is very easy to calculate current.

Certainly I see the benefit if we start coloring the pointer (it adds 2
instructions I believe) but let's make sure it is worth passing another
32-bit argument.  It could very well be, schedule_tick is called
enough...

> > Moreover, the function doesn't make *sense* if p != current...
> 
> yes - would it be perhaps cleaner then to name the variable 'this_task' or
> something like that?

Yes, good idea.

	Robert Love


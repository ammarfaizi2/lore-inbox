Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSDQIEr>; Wed, 17 Apr 2002 04:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314087AbSDQIEq>; Wed, 17 Apr 2002 04:04:46 -0400
Received: from [195.163.186.27] ([195.163.186.27]:56486 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S314080AbSDQIEo>;
	Wed, 17 Apr 2002 04:04:44 -0400
Date: Wed, 17 Apr 2002 11:04:40 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, Mark Mielke <mark@mark.mielke.cc>,
        davidm@hpl.hp.com, Davide Libenzi <davidel@xmailserver.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020417110440.G12961@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.33.0204162227530.15675-100000@home.transmeta.com> <1019023303.1670.37.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 02:01:42AM -0400, Robert Love wrote:
> On Wed, 2002-04-17 at 01:34, Linus Torvalds wrote:
> > No, it also makes it much easier to convert to/from the standard UNIX time
> > formats (ie "struct timeval" and "struct timespec") without any surprises,
> > because a jiffy is exactly representable in both if you have a HZ value
> > of 100 or 100, but not if your HZ is 1024.
> 
> Exactly - this was my issue.  So what _was_ the rationale behind Alpha
> picking 1024 (and others following)?  More importantly, can we change to
> 1000?

   Alpha processors don't have full division hardware, they have to
   iterate it one bit at the time. They do have a flash multiplier,
   and a barrel-shifter.  Shifts take one pipeline cycle, like to
   addition and substraction.  Multiply takes 6-12 depending on model,
   but division takes 64...

   Converting the  tick  to  gettimeofday()  seconds is faster when
   the tick is power of two.

> 	Robert Love

/Matti Aarnio

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261606AbTCGOS3>; Fri, 7 Mar 2003 09:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbTCGOS3>; Fri, 7 Mar 2003 09:18:29 -0500
Received: from uni01du.unity.ncsu.edu ([152.1.13.101]:13953 "EHLO
	uni01du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S261606AbTCGOS2>; Fri, 7 Mar 2003 09:18:28 -0500
From: jlnance@unity.ncsu.edu
Date: Fri, 7 Mar 2003 09:28:46 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <20030307142846.GA4485@ncsu.edu>
References: <Pine.LNX.4.44.0303060936301.7206-100000@home.transmeta.com> <Pine.LNX.4.44.0303070653050.2873-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303070653050.2873-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 06:57:58AM +0100, Ingo Molnar wrote:

> so the correct approach is both to make X more interactive (your patch),
> _and_ to make the compilation jobs less interactive (my patch). This is
> that explains why Andrew saw roughly similar interactivity with you and my
> patch applied separately, but the best result was when the combo patch was
> applied. Agreed?

Ingo,
    Forgive me if this is what your patch does, I have only looked at
Linus'es.  But I dont think this is what you are doing.
    Linus'es patch gives a boost to non-interactive proceses that wake
up interactive ones.  It seems that we could solve the make problem by
applying the same idea in the reverse direction.  Lets unboost interactive
processes that are woken up by non-interactive ones.  So if make gets
woken up by gcc (which is hopefully non-interactive), make does not
get "credit" for having been asleep.
    I am trying to think if this would break anything.  The only thing
I can think of is that if the X server gets marked as non-interactive,
then it is going to cause its clients to get marked as non-interactive
as well when it sends them data.  But this may be a good thing.  If
X is marked as non-interactive it means that it is busy, so this may
have the effect of preventing the X clients from sending it a lot of
extra work while its already busy.

Thanks,

Jim

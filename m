Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272137AbRIENge>; Wed, 5 Sep 2001 09:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272175AbRIENgZ>; Wed, 5 Sep 2001 09:36:25 -0400
Received: from sync.nyct.net ([216.44.109.250]:60677 "HELO sync.nyct.net")
	by vger.kernel.org with SMTP id <S272137AbRIENgQ>;
	Wed, 5 Sep 2001 09:36:16 -0400
Date: Wed, 5 Sep 2001 09:38:51 -0400
From: Michael Bacarella <mbac@nyct.net>
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getpeereid() for Linux
Message-ID: <20010905093851.A24280@sync.nyct.net>
In-Reply-To: <tgsne23sou.fsf@mercury.rus.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tgsne23sou.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would anyone like to give me a helping hand in implementing the
> getpeereid() syscall for Linux?  See the following page for the
> documentation of the OpenBSD implementation:
> 
> http://www.openbsd.org/cgi-bin/man.cgi?query=getpeereid&sektion=2&apropos=0&manpath=OpenBSD+Current
> 
> I think I could work out the kernel data structures to gather the
> relevant data from, however, I won't get all the locking stuff right.
>
> OTOH, is there any chance that the addition of such a syscall would be
> accepted?

There's no need. The equivalent functionality can already be
implemented in userspace.

------

#include <sys/socket.h>

uid_t getpeereuid(int sd)
{
	struct ucred cred;
	int len = sizeof (cred);

	if (getsockopt(sd,SOL_SOCKET,SO_PEERCRED,&cred,&len))
		return -1;

	return cred.uid;
}

------

The same can be done for gid, and even pid.

Yes, Linux rules.

-- 
Michael Bacarella <mbac@nyct.net>
Technical Staff / System Development,
New York Connect.Net, Ltd.

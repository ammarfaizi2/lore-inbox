Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272090AbRHVTI2>; Wed, 22 Aug 2001 15:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272096AbRHVTIT>; Wed, 22 Aug 2001 15:08:19 -0400
Received: from web10904.mail.yahoo.com ([216.136.131.40]:37383 "HELO
	web10904.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272091AbRHVTIF>; Wed, 22 Aug 2001 15:08:05 -0400
Message-ID: <20010822190820.57208.qmail@web10904.mail.yahoo.com>
Date: Wed, 22 Aug 2001 12:08:20 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: brlock_is_locked()?
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010822.120051.25423285.davem@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1368128843-998507300=:53007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1368128843-998507300=:53007
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Mr. Miller,

--- "David S. Miller" <davem@redhat.com> wrote:
>    From: Brad Chapman <kakadu_croc@yahoo.com>
>    Date: Wed, 22 Aug 2001 11:53:51 -0700 (PDT)
> 
>    	It's not really a deficiency. Rusty apparently decided that in
>    order to be SMP-compliant and to prevent Oopses, that the unregistration
>    function should grab the brlock so that all the packets would pass through
>    the protocol-handling functions.
> 
> So arrange you code such that you aren't holding the netproto
> lock when you call the unregistration function.
> 
> It is possible to shut down all references to whatever you
> are unregistering, safely drop the lock, then call the
> netfilter unregister routine.

	I understand that. What I'm afraid of is someone who writes a third-party
protocol module for ip_conntrack (or ip6_conntrack) and tries to call the wrapper
with BR_NETPROTO_LOCK held. LISB, IMHO the primary difficulty is not protecting
the protocol linked-list from packets inside the conntrack; it's protecting the
protocol linked-list from packets in the netfilter stack. FWICT, it should
be almost impossible for packets to move around in conntrack with the rwlock
but not the brlock; but strange things can happen......

> 
>    (I checked the brlock code and didn't find any schedule()s; there's
>     probably a reason for that).
> 
> Ummm, this is SMP 101, you can't sleep with a lock held.
> The global kernel lock is special in this regard, but all
> other SMP locking primitives may not sleep.

	Grrr....I read Rusty's Unreliable Guide to Kernel Locking (twice) and
still didn't remember that. Guess you have to schedule() yourself.

> 
> Later,
> David S. Miller
> davem@redhat.com

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net

Reply to the address I used in the message to you,
please!

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
--0-1368128843-998507300=:53007--

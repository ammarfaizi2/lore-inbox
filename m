Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272072AbRHVSSR>; Wed, 22 Aug 2001 14:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272073AbRHVSSB>; Wed, 22 Aug 2001 14:18:01 -0400
Received: from web10905.mail.yahoo.com ([216.136.131.41]:21264 "HELO
	web10905.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272072AbRHVSRk>; Wed, 22 Aug 2001 14:17:40 -0400
Message-ID: <20010822181755.39925.qmail@web10905.mail.yahoo.com>
Date: Wed, 22 Aug 2001 11:17:55 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: brlock_is_locked()?
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010822.110316.57459277.davem@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1379469606-998504275=:39301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1379469606-998504275=:39301
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

--- "David S. Miller" <davem@redhat.com> wrote:
>    From: Brad Chapman <kakadu_croc@yahoo.com>
>    Date: Wed, 22 Aug 2001 11:00:56 -0700 (PDT)
> 
>    	I'm not talking about _who_ owns the lock, I'm talking about whether
>    the lock itself is locked. I don't care which process is using the lock;
>    I just want to know if _somebody_ is using it. Is this possible?
> 
> Show a valid use for such a boolean state, then
> the discussion may proceed :-)
> 
> Later,
> David S. Miller
> davem@redhat.com

Mr. Miller,

	I am debugging my port of the Netfilter IPv4 connection tracking
subsystem to IPv6. In some sections of the code, I had to split the code
into core functions, which did the actual work and could be used by people
with the appropriate locks, and wrapper functions, which grabbed the locks
themselves. 
	One such group of functions was the ip6_conntrack_protocol API.
To make life easier in the future, and to make third-party protocol
registration easier, I split the functions. In the unregistration function,
in order to be SMP-compliant we needed to grab BR_NETPROTO_LOCK to seal
the netfilter stack and prevent any packets from being scanned by the protocol
functions. When I split the unregistration function, I realized that there
was no way to detect if BR_NETPROTO_LOCK was locked, by _anyone_. Thus, if
someone  had BR_NETPROTO_LOCK and tried to call
ip6_conntrack_protocol_unregister() (the wrapper), we would deadlock.
	At this section of the code, it doesn't really matter who in the
netfilter/network stack has BR_NETPROTO_LOCK, just that we need to know if
it's already locked by someone else, or unlocked for us to use. Is what I'm
asking for physically possible?

Thanks,

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
--0-1379469606-998504275=:39301--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271624AbRHPT1q>; Thu, 16 Aug 2001 15:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271627AbRHPT10>; Thu, 16 Aug 2001 15:27:26 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:51211 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S271626AbRHPT1X>; Thu, 16 Aug 2001 15:27:23 -0400
Date: Thu, 16 Aug 2001 22:41:10 +0300 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: "Magnus Naeslund(f)" <mag@fbab.net>
cc: Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <401901c12595$77273ea0$020a0a0a@totalmef>
Message-ID: <Pine.LNX.4.30.0108162009260.2660-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Aug 2001, Magnus Naeslund(f) wrote:

> The problem is that i can shh in as root, but not as any other user ( not
> via login or su or either ).

Are you using < 0.73 PAM without the change_uid pam_limit option? You
set in /etc/security/limits.conf:
*               soft    nproc           40

the '*' valid for users but not for root, the relevant parts of
a default login/pam works like:

<running as root>
setrlimit()
fork()
setuid(user_uid)

So if you have at least 40 root processes running already for whatever
reason then the result is what you see.

The livelocks what I mentioned is indeed different and fixed in 2.4.9 (I
guess the 'kswapd thought shortage for highmem zone when its size is
actually 0' issue what Linus said in the 'kswapd using all cpu for long
periods' thread). Sorry for the confusion, hope the above fixes your
problem.

	Szaka


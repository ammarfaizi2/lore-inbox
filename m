Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283016AbRLQXLn>; Mon, 17 Dec 2001 18:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283012AbRLQXLW>; Mon, 17 Dec 2001 18:11:22 -0500
Received: from mons.uio.no ([129.240.130.14]:61117 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S282993AbRLQXLV>;
	Mon, 17 Dec 2001 18:11:21 -0500
To: war <war@starband.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Limits broken in 2.4.x kernel.
In-Reply-To: <3C1E5A88.57F5A68A@starband.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Dec 2001 00:11:07 +0100
In-Reply-To: <3C1E5A88.57F5A68A@starband.net>
Message-ID: <shspu5dv3w4.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == war  <war@starband.net> writes:

     > Problem: Per-user process limits to not work correctly with a
     > 2.4.x kernel.

     > Say I want to limit a user to [5] processes.

     > Example: Edit [/etc/security/limits.conf]
     >               user hard nproc 5 -or- @group hard nproc 5

     > The result: The user cannot login.

     > How to fix?

One thing I noticed when doing the BSD cred patch for 2.5.x is that
somebody broke the process accounting in 2.[45].x at least for the
case of reparent_to_init():
If you just charge current->user without moving over the process from
the old uid to the new uid (such as is done in kernel/sys.c with the
set_user() routine) then you risk seriously corrupting the counters.

I'm not sure really what the point was of setting the user in
reparent_to_init() in the first place, since it doesn't setreuid().

Cheers,
  Trond

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282838AbRLQUvN>; Mon, 17 Dec 2001 15:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbRLQUux>; Mon, 17 Dec 2001 15:50:53 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:22465 "EHLO
	c0mailgw02.prontomail.com") by vger.kernel.org with ESMTP
	id <S282838AbRLQUul>; Mon, 17 Dec 2001 15:50:41 -0500
Message-ID: <3C1E5A88.57F5A68A@starband.net>
Date: Mon, 17 Dec 2001 15:50:16 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Limits broken in 2.4.x kernel.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem: Per-user process limits to not work correctly with a 2.4.x
kernel.

Say I want to limit a user to [5] processes.

Example: Edit [/etc/security/limits.conf]
              user            hard         nproc 5
              -or-
              @group       hard         nproc 5

The result: The user cannot login.

How to fix?

Say the total number of user processes is always 100.
This is never the case, however I am showing it only for example.
Currently, you would have to set user or @group to 103, so the user
would be limited to 3 processes.

I was curious if this fix would ever be merged into the Linux Kernel so
limits would actually work properly?


Discussion:

<war> 1] set nproc to 4
<war> 2] try to login -> you cant login if there are more than 4 procs
running on the system
<riel> war: that bug is known
<riel> war: I fixed it a while ago in -ac
<riel> war: the problem is as follows
<riel> 1) login applies the rlimit to itself
<riel> 2) login forks and changes UID
<riel> 3) login exec()s the shell
<riel> of course, step 2) will fail because it set the maximum number of
processes on itself
<war> riel, so in the fixed version, if I set a user/group limit to 3
proc, ten the user will only be able to launch 3 proc, right?
<riel> war: exactly
<war> riel, is this fixed in 2.4.17?
<war> s/is/will
<riel> war: dunno if the fix got carried over from -ac
<war> riel, I would have never been able to say 'damn thats a bug' -
thanks for the information btw.
<riel> war: I tracked it down some time ago and fixed it for Conectiva
7.0's release ;)
<riel> also sent it to Linus and Alan the same day, but of course only
Alan applied it
<war> riel, can you post that information to LKML since you know the
exact problem and see what linus says?
<riel> war: Linus said nothing and won't say anything
<riel> war: as far as I'm concerned the problem is all yours
<riel> feel free to use my info to try to convince Linus
<war> riel, but isn't it considered broken then?
<war> I mean it doesn't work right, heh.
<riel> yes, I consider it broken
<riel> war: but ... if you want to get the fix integrated, you'll have
to do it yourself
<riel> war: I think http://surriel.com/patches/ has the patch somewhere
<riel> war: then you can try to get the thing merged with Linus
<war> riel, btw if you use a group with limits.conf, it should effect
each person in that group individually and not the group as a whole
right?
<riel> war: indeed


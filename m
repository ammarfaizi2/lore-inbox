Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTGALny (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 07:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTGALny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 07:43:54 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:32752 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262254AbTGALnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 07:43:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Fredrik Tolf <fredrik@dolda2000.cjb.net>, linux-kernel@vger.kernel.org
Subject: Re: PTY DOS vulnerability?
Date: Tue, 1 Jul 2003 06:57:49 -0500
X-Mailer: KMail [version 1.2]
References: <200306301613.11711.fredrik@dolda2000.cjb.net>
In-Reply-To: <200306301613.11711.fredrik@dolda2000.cjb.net>
MIME-Version: 1.0
Message-Id: <03070106574900.01125@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 June 2003 09:18, Fredrik Tolf wrote:
> Has someone considered PTYs as a possible attack vector for DOS
> attacks? Correct me if I'm wrong, but cannot someone just open
> all available PTYs on a console-less server and make everyone
> unable to log in?
>
> I mean, what if eg. apache is hacked, and the first thing the
> attacker does is to tie up all PTYs, so that noone can log in to
> correct the situation while the attacker can go about his
> business? Then the only possible solution would be to reboot the
> server, which might very well not be desirable.
>
> If you want proof of concept code, look at
> http://www.dolda2000.cjb.net/~fredrik/ptmx.c
> I successfully ran this on one of my servers which effectively
> disabled anyone from logging in via SSH.
>
> Shouldn't PTYs be a per-user resource limit?
>
> Someone must have thought of this before me, right? How am I
> wrong?

One problem is that ptys are not just "used by the user". Every terminal
window opened uses a pty. As does a network connection.

As does "expect" - which is less visible to the user since it is intended
to be invisible.

The real question is "how many PTYs should a single user have?"
Which then prompts the question "How many concurrent users should there be?"

second, just providing a user limit doesn't prevent a denial of service..
Just have more connections than ptys and you are in the same situation.

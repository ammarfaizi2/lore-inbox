Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUCBTAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 14:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUCBTAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 14:00:18 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:3743 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261741AbUCBTAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 14:00:11 -0500
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: hpa@zytor.com, cloos@jhcloos.com, root@chaos.analogic.com, nuno@itsari.org
Content-Type: text/plain
Organization: 
Message-Id: <1078254284.2232.385.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Mar 2004 14:04:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As RBJ said, ptys are now recycled in pid-like fashion,
> which means numbers won't be reused until wraparound
> happens.  This is good for security/fault tolerance,
> at least to some minor degree.

Ouch. It's bad for display and bad for typing.
What is easier to type?

ps -t pts/6
ps -t pts/1014962

(and yes, I really type these -- I don't have a
third hand to operate the mouse simultaneously)

What looks better?

UID        PID  PPID  C    SZ  RSS PSR STIME TTY          TIME CMD
albert    3339  2114  0   771 1684   0 Feb26 pts/6    00:00:00 bash
albert    3149  2514  0   771 1684   0 Feb26 pts/1004922 00:00:00 bash
albert    3835  2164  0   771 1684   0 Feb26 pts/8    00:00:00 bash
albert    4136  3114  0   771 1684   0 Feb26 pts/1013866 00:00:00 bash
albert    4739  2119  0   771 1684   0 Feb26 pts/9    00:00:00 bash

Better way:

Have a soft limit, initially set at 99. When 2/3 of
the ptys are in use, increase the soft limit to 999,
then to 9999, 99999, and finally to 999999.

This way, a plain 1-person desktop user would never
have a pty name longer than pts/99 and an insanely
busy server could go as high as needed.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbTBMUfa>; Thu, 13 Feb 2003 15:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268289AbTBMUfa>; Thu, 13 Feb 2003 15:35:30 -0500
Received: from stingr.net ([212.193.32.15]:24516 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S268286AbTBMUf3>;
	Thu, 13 Feb 2003 15:35:29 -0500
Date: Thu, 13 Feb 2003 23:45:18 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030213204518.GC14764@stingr.net>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Linus Torvalds:
> It's a generic "synchronous signal delivery" method, and it uses a
> perfectly regular file descriptor to deliver an arbitrary set of signals
> that are pending.

The one functionality I miss way too much in linux (comparing to win32) is
FindFirstChangeNotification and ReadDirectoryChangesW thing.

These functions have one nice purpose: we can watch a directory hierarchy
for changes an efficient way. e.g. AFAIK via dnotify I can only see that
directory was changed, but cannot actually get all the changes. If I will
re-read all directory, I can miss some changes (if other process is
tampering with this dir too).

With ReadDirectoryChangesW I can read all changes happened with watched
hierarchy by doing sequence of, probably blocking, reads from some handle,
and each read will return some action/event "description" (e.g. "created file
a; renamed file a to file b; etc")

I was thinking about the way of implementing this functionality in linux. By
adding my own syscalls with semantics similar to sigfd.

And, thus, not only signals can be delivered through the same way. Maybe it
worth generalizing into some other "abstraction" ?

> Any real use would also probably be a select() or poll() loop.

P.S. Kernel already have an almost similar thing for different purpose -
rtnetlink.

-- 
Paul P 'Stingray' Komkoff Jr /// (icq)23200764 /// (http)stingr.net
 This message represents the official view of the voices in my head

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288058AbSBDBXh>; Sun, 3 Feb 2002 20:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288071AbSBDBX2>; Sun, 3 Feb 2002 20:23:28 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:34820 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S288058AbSBDBXS>; Sun, 3 Feb 2002 20:23:18 -0500
Date: Sun, 3 Feb 2002 20:30:11 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Dan Kegel <dank@kegel.com>
Cc: Kev <klmitch@MIT.EDU>, Arjen Wolfs <arjen@euro.net>,
        <coder-com@undernet.org>, <feedback@distributopia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <3C5DE0D2.77DDE891@kegel.com>
Message-ID: <Pine.LNX.4.44.0202032019250.3086-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Feb 2002, Dan Kegel wrote:

> I'd like to know how it disagrees.
> I believe rtsig requires you to tweak your I/O code in three ways:
> 1. you need to pick a realtime signal number to use for an event queue
Did that.

> 2. you need to wrap your read()/write() calls on the socket with code
> that notices EWOULDBLOCK
This is perhaps the part we it disagrees with our code.  I will
investigate this part.  The way we normally do things is have callbacks
per fd, that get called when our event occurs doing the read, or, write
directly.  We do check for the EWOULDBLOCK stuff and re-register the
event.  The thing we do not currently do is, attempt to read or write
unless we've received notification first.  This is what I am assuming is
breaking it.

> 3. you need to fall back to poll() on signal queue overflow.
Did that part too.


Regards,

Aaron


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSBDBdK>; Sun, 3 Feb 2002 20:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288083AbSBDBdB>; Sun, 3 Feb 2002 20:33:01 -0500
Received: from relay1.pair.com ([209.68.1.20]:11013 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S288071AbSBDBct>;
	Sun, 3 Feb 2002 20:32:49 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C5DE630.508DE9DB@kegel.com>
Date: Sun, 03 Feb 2002 17:38:56 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Sethman <androsyn@ratbox.org>
CC: Kev <klmitch@MIT.EDU>, Arjen Wolfs <arjen@euro.net>,
        coder-com@undernet.org, feedback@distributopia.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <Pine.LNX.4.44.0202032019250.3086-100000@simon.ratbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Sethman wrote:
> 
> > 2. you need to wrap your read()/write() calls on the socket with code
> > that notices EWOULDBLOCK
> This is perhaps the part we it disagrees with our code.  I will
> investigate this part.  The way we normally do things is have callbacks
> per fd, that get called when our event occurs doing the read, or, write
> directly.  

That sounds totally fine; in fact, it's how my Poller library works.

> We do check for the EWOULDBLOCK stuff and re-register the
> event.

But do you remember that this fd is ready until EWOULDBLOCK?
i.e. if you're notified that an fd is ready, and then you
don't for whatever reason continue to do I/O on it until EWOULDBLOCK,
you'll never ever be notified that it's ready again.
If your code assumes that it will be notified again anyway,
as with poll(), it will be sorely disappointed.

> The thing we do not currently do is, attempt to read or write
> unless we've received notification first.  This is what I am assuming is
> breaking it.

Yeah, that would break it, too, I think.

- Dan

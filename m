Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261620AbREOWCI>; Tue, 15 May 2001 18:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261623AbREOWB7>; Tue, 15 May 2001 18:01:59 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:59640 "EHLO tytlal")
	by vger.kernel.org with ESMTP id <S261619AbREOWAX>;
	Tue, 15 May 2001 18:00:23 -0400
Date: Tue, 15 May 2001 14:58:29 -0700
From: Chip Salzenberg <chip@valinux.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515145829.K3098@valinux.com>
In-Reply-To: <20010515145830.Y5599@sventech.com> <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com> <20010515154325.Z5599@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010515154325.Z5599@sventech.com>; from johannes@erdfelt.com on Tue, May 15, 2001 at 03:43:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Johannes Erdfelt:
> I had always made the assumption that sockets were created because you
> couldn't easily map IPv4 semantics onto filesystems. It's unreasonable
> to have a file for every possible IP address/port you can communicate
> with.

I think you're right on both counts, but I'm sure you'll agree that
just because some undergrad at Berkeley did something a certain way 20
years ago doesn't mean we have to follow it blindly. :-)

IIRC, Plan 9 allocate TCP connections rather like Linux allocates
ptys.  When we allocate a pty we don't have to say what program we're
going to connect to; we allocate it and then use it as we like.
Similarly, in Plan 9 you allocate a TCP connection without having to
say who you're going to connect to.  The main differences between the
Plan 9 approach and the socket approach are:

  1. Plan 9 connections are filesystem entities (like our ptys)
  2. Control is done via read/write on a separate control channel,
     which is *also* a filesystem entity.

USB could use a similar approach.  And since each client would
allocate a new connection entity for its own use -- even if it's going
to connect to a device that someone else is already connected to --
permissions becomes quite simple to manage.

Come to think of it, the mechanism I'm describing could address all
hotpluggable devices....
-- 
Chip Salzenberg              - a.k.a. -             <chip@valinux.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267639AbSLFVFx>; Fri, 6 Dec 2002 16:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267729AbSLFVFx>; Fri, 6 Dec 2002 16:05:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9480 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267639AbSLFVFw>; Fri, 6 Dec 2002 16:05:52 -0500
Date: Fri, 6 Dec 2002 13:12:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <3DF10610.A73AED68@mvista.com>
Message-ID: <Pine.LNX.4.44.0212061307310.3830-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Dec 2002, george anzinger wrote:
> 
> I have not looked at your code yet, but I am concerned that
> the restart may not be able to get to the original
> parameters.

The way the new system call restarting is done, it never looks at the old
parameters. They don't even _exist_ for the restarted call (well, they do,
but the restart function can't actually get at them). So it is up to the
original interrupted call to save off anything it needs saving off (and it
get sthe "restart_block" structure to do that saving in. Right now that's
just three words, but we can expand it if necessary).

Anyway, it sounds like the new nanosleep behaviour is acceptable (and
certainly closer to SuS than the old one), and that the "time remaining"
part is simply undefined for a successful sleep. I'd like to clean it up 
(either always clearing the time on success, or just never updating it at 
all), but at least standards lawyers aren't going to complain.


			Linus


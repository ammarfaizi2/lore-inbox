Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261785AbRESMAy>; Sat, 19 May 2001 08:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbRESMAp>; Sat, 19 May 2001 08:00:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32896 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261775AbRESMAm>;
	Sat, 19 May 2001 08:00:42 -0400
Date: Sat, 19 May 2001 08:00:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Andries.Brouwer@cwi.nl, bcrl@redhat.com, torvalds@transmeta.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
 in  userspace
In-Reply-To: <3B065C78.C20BBCA@uow.edu.au>
Message-ID: <Pine.GSO.4.21.0105190750380.5339-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Andrew Morton wrote:

> So.  When am I going to be able to:
> 
> 	open("/bin/ls,-l,/etc/passwd", O_RDONLY);

You are not. Think for a minute and you'll see why.

Linus' idea of /dev/tty/<parameters> is marginally sane - it makes sense
to consider that as configuring-upon-open. You _are_ going to do IO on
that file.

Ben's /dev/md0/<living_horror> is ugly - it's open just for side effects,
with no IO supposed to happen.

His idea of passing file descriptor instead of name makes these side effects
even messier.

The stuff you've proposed is a perversion worth of Albert. You've introduced
additional metacharacter into filenames, you will need some form of quoting
to be able to pass literal commas and you will need to quote slashes. It's
way past ugly.


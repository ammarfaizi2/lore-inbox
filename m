Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130172AbRASDQb>; Thu, 18 Jan 2001 22:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130894AbRASDQL>; Thu, 18 Jan 2001 22:16:11 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:46858 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S130548AbRASDQG>; Thu, 18 Jan 2001 22:16:06 -0500
Date: Thu, 18 Jan 2001 19:16:05 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Zach Brown <zab@zabbo.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <20010118124928.F8658@tetsuo.zabbo.net>
Message-ID: <Pine.LNX.4.30.0101181913540.16292-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Zach Brown wrote:

> We set TCP_CORK on the socket we handed to external programs that were
> being run via 'site exec' in an ftp server.  It resulted in much nicer
> packets being spit out, especially in the 'ls' case where it likes to
> write() on really goofy boundaries.
>
> [yes, ftp and 'site exec' in particular are far from sexy, but do the same
> with CGI scripts and the world might care :)]

actually in apache we deliberately writev() on (essentially) the same
boundaries the CGI passed to us.

the reason, gag puke, is for doing things such as sending "activity"
progress -- like a line at a time or whatever to indicate that the CGI is
there and still working.

this is obviously something that we really should enable nagle for, and
we've been in a dilemma of whether to nagle or not in this case for a few
years.  we want to not nagle if the CGI is bulk... we want to nagle if the
CGI is a dribbler (because that's what nagle is for).

CORK would probably be wrong for us.

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

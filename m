Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbRAOS7T>; Mon, 15 Jan 2001 13:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbRAOS67>; Mon, 15 Jan 2001 13:58:59 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:41732 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129532AbRAOS6r>; Mon, 15 Jan 2001 13:58:47 -0500
Date: Mon, 15 Jan 2001 10:58:46 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jonathan Thackray <jthackray@zeus.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <14947.17050.127502.936533@leda.cam.zeus.com>
Message-ID: <Pine.LNX.4.30.0101151052140.30402-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Jan 2001, Jonathan Thackray wrote:

> > TCP_CORK is useful for FAR more than just sendfile() headers and
> > footers.  it's arguably the most correct way to write server code.
>
> Agreed -- the hard-coded Nagle algorithm makes no sense these days.

hey, actually a little more thinking this morning made me think nagle
*may* have a place.  i don't like any of the solutions i've come up with
though for this.  the problem specifically is how do you implement an
efficient HTTP/ng server which supports WebMUX and parallel processing of
multiple responses.

the problem in a nutshell is that multiple threads may be working on
responses which are multiplexed onto a single socket -- there's some extra
mux header info used to separate each of the response streams.

like what if the response stream is a few hundred HEADs (for cache
validation) some of which are static files and others which require some
dynamic code.  the static responses will finish really fast, and you want
to fill up network packets with them.  but you don't know when the dynamic
responses will finish so you can't be sure when to start sending the
packets.

i don't know NFSv3 very much, but i imagine it's got similar problems --
any multiplexed request/response protocol allowing out-of-order responses
would have this problem.  any gurus got suggestions?

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269005AbRG3QqX>; Mon, 30 Jul 2001 12:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269007AbRG3QqN>; Mon, 30 Jul 2001 12:46:13 -0400
Received: from egghead.curl.com ([216.230.83.4]:17413 "HELO egghead.curl.com")
	by vger.kernel.org with SMTP id <S269005AbRG3QqE>;
	Mon, 30 Jul 2001 12:46:04 -0400
From: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Chris Mason <mason@suse.com>, Chris Wedgwood <cw@f00f.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva>
Date: 30 Jul 2001 12:46:13 -0400
In-Reply-To: <Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva>
Message-ID: <s5gvgkacqlm.fsf@egghead.curl.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rik van Riel <riel@conectiva.com.br> writes:

> Exactly what is wrong with doing fsync() on the
> directory ?

Nothing, except that it requires source code changes to every
application which expects BSD semantics for these operations.
Anecdotal evidence suggests at least the MTA authors are resistant to
making such changes.

> Why do you want us to turn link() and rename()
> into link_slowly() and rename_slowly() ?

I don't by default, only as an option.  You know, just like "chattr
-S" or "mount -o sync" means do_everything_slowly().

> Why can't you use a simple wrapper function to
> do this for you ?

It would not be all that simple; it would have to parse the arguments
to figure out the containing directories, open() a file descriptor on
each, and fsync() them.  Not impossible, but it does introduce several
those additional system calls as performance hits and points of
failure, not to mention possible race conditions.

Still, I suppose you could do this well enough in the C library.  You
might even want it to be the default when "__USE_BSD" is defined or
something.

But it still seems simpler to me just to make it an option in the file
system.

In your next message, you say:

> Besides BSD softupdates and the various journaling
> filesystems which are in use on other Unixen also
> don't provide the 4.3BSD solution any more ...

This surprises me if it is true; do you have a reference?  And what
mechanism *do* the modern BSDs provide to commit metadata changes to
disk?

 - Pat

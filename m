Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293657AbSCKWzq>; Mon, 11 Mar 2002 17:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293659AbSCKWzj>; Mon, 11 Mar 2002 17:55:39 -0500
Received: from code.and.org ([63.113.167.33]:8395 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S293657AbSCKWz0>;
	Mon, 11 Mar 2002 17:55:26 -0500
To: Hans Reiser <reiser@namesys.com>
Cc: Larry McVoy <lm@bitmover.com>, Tom Lord <lord@regexps.com>,
        jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.GSO.4.21.0203110051500.9713-100000@weyl.math.psu.edu>
	<3C8C4B8A.2070508@namesys.com>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 11 Mar 2002 17:51:25 -0500
In-Reply-To: <3C8C4B8A.2070508@namesys.com>
Message-ID: <nn4rjmoh02.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

> Alexander Viro wrote:
> 
> >
> >On Mon, 11 Mar 2002, Hans Reiser wrote:
> >
> >>So the problem was that it was not optional?
> >>
> >
> >The problem is that it doesn't play well with other things.
> 
> Your statement is information free so far, but could be the intro to
> an informative statement....;-)

 Think about what people want to do with SCM, think about how the
filesystem can help.
 Just having a special flag to open() that enables versioning on close()
is useless to 99% of people IMO.

 For something like that to be worth it it'd need to support rename(),
symlink(), link(), unlink() and _importantly_ chmod()/chown() (you
don't want previous versions of a file becoming readable just because
you chmod() the final version).

 Off the top of my head the places where I might find a use for it...

1. tar -x ... hack ... tell fs to generate diff
   (can be done via. cp -al now, but possibly easier with fs support)

2. Version control my mail box (the good readers have the mark deleted
and then purge, which removes some of the need). Version control
might be clumsy (say you delete 3 mails, and want only one back), and
doesn't work with a mailer that does any caching on the mailbox.

3. Putting an entire website under it.

...and all but 3. are probably better done a different way (a shared
library might be nice ... and would also be fs/kernel independent) and
I'd imagine it's overkill for 3. as the biggest problem is saving over
the wrong filename so undelete is enough.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null

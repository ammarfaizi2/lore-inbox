Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314093AbSEFFAq>; Mon, 6 May 2002 01:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314094AbSEFFAp>; Mon, 6 May 2002 01:00:45 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:38160 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S314093AbSEFFAp>;
	Mon, 6 May 2002 01:00:45 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205060500.g4650hm421691@saturn.cs.uml.edu>
Subject: Re: link() security
To: xystrus@haxm.com (xystrus)
Date: Mon, 6 May 2002 01:00:42 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020415174123.C16804@pizzashack.org> from "xystrus" at Apr 15, 2002 05:41:23 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xy writes:

> (IMO) link should
> be modified because it does not make sense to allow users to create
> hard links to files they have no access to, in general.  The mail
> spool example was simply one common example.
> 
> IMO, if I have created a file, and I own the file, then there are only
> two users who should get to decide whether that file gets deleted or
> not: me, and root.  Regular users should not be able to create hard
> links to my files, potentially without me knowing about it.  Allowing
> them to do so means that you allow users who do not own a resource,
> and have no access to that resource, to potentially manage control of
> that resource to some extent.  I don't see how this policy makes any
> sense.  It allows that a file I created may be hanging around despite
> the fact that I think it's been deleted.  And that just seems like a
> very bad idea to me.

It is a bad idea, especially since POSIX doesn't require it!
The 2001 UNIX/POSIX standard says:

   The implementation may require that the calling
   process has permission to access the existing file.

Then for error codes, EACCES means:

   A component of either path prefix denies search
   permission, or the requested link requires writing
   in a directory that denies write permission, or
   the calling process does not have permission to
   access the existing file and this is required by
   the implementation.

Maybe this should even apply to the owner.
("chmod 000 foo") Let's say that either
read or write permission is enough by default.
By mount option, both or neither may be required.

Pretty much any other restriction is OK as well,
due to the way the UNIX/POSIX standard uses the
term "access". For example:

   An implementation may include other security
   mechanisms in addition to those specified in
   POSIX.1, and an access attempt may fail
   because of those additional mechanisms, even
   though it would succeed according to the
   rules given in this section. (For example,
   the user's security level might be lower than
   that of the object of the access attempt.)

The standard defines an "additional file access
control mechanism" as pretty much any restriction
that one would care to add.

So restricting link() is 100% standards compliant.

How about: fail if (ctime^mtime+atime*owner)%3

:-)

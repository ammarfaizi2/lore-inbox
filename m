Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268708AbUIGWOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268708AbUIGWOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268709AbUIGWOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:14:32 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:50139 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S268702AbUIGWNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:13:13 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: Christer Weinigel <christer@weinigel.se>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200409070206.i8726vrG006493@localhost.localdomain>
	<413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>
	<413DFF33.9090607@namesys.com>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 08 Sep 2004 00:13:12 +0200
In-Reply-To: <413DFF33.9090607@namesys.com>
Message-ID: <m3vfepiv7r.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

> No, we want files and directories that can do what streams can do.
> This means files that are also directories, plugins that aggregate the
> contents of a directory, files that inherit stat data, maybe I forget
> something ---- it is on my website.
> 
> Streams themselves are a bad idea because they are a filesystem inside
> of a file which is double the overhead, and they fragment the
> namespace.

There really isn't a difference between your files are directories
think and named streams that can be accessed with openat.  Both are
concepts that won't fit into the classical Unix entity "file".

As far as I can tell, windows named streams could be exposed via a
file-as-directory model.  In that case what windows sees as
foo.txt:icon would be accessed as foo.txt/icon instead.  The question
in my mind is if that is a desirable concept.  I can see that it is
very a attractive concept because it's easy to explain to users, but
at the same time, a lot of things suggest that the files-as-
directories concept is a bad idea.  I mentioned a few of the possible
problems in the grand-grand-parent of this message.

Try to address those problems.  It may be that your answer is "I don't
give a shit about existing backup applications", or "I don't care
about security in existing web-servers, they'll have to be taught
about reiser4", but in that case say so.  Or show how it's not a
problem with existing applictions.

> It is always better to lead by example.  These ideas are too new for
> the other fs developers, they need 5 years to get used to them.
> Reiser4 should create something that works, and let others follow when
> they will.

Pretty please, give up the marketing bullshit.  I already know that
you belive reiser4 is the best thing since sliced bread.  You say that
"reiser4 should create something that works".  So far you haven't
convinced me that reiser4 actually "works".  It's a nice proof of
concept, but it definitely does not feel like something that I'd like
in the mainstream kernel until those problems are addressed.

Have you looked at the VFS deadlocks that Alexander Viro pointed at?

Does tar work with files-as-directories?  Can I use tar to make a
backup of my resier4 directory.  What changes would be required to the
tar application or to the tar file format to make this work?

Can I do a cp -a /home/wingel to a NFS-mounted drive on some other
computer to make a backup of my home directory or will I lose data
that way?  What changes would be required to cp to make this work?

Please remember that reiser4 does not exist in a vaccum.  If you want
to make a fundamental change to unix concepts that have been with us
for three decades, it's really up to you to show that it doesn't break
too many existing applications.

> This is the wrong question.  The right question is, what belongs in a
> unified namespace?  Then having answered that, the extent to which it
> is easier to have all aspects of name resolution together in one body
> of code is an implementation detail that can change and evolve with
> time.  A rapidly evolving namespace is easier to modify if it is all
> one body of code.  Furthermore, the people doing the work should
> really be left to decide such implementation details themselves
> because they are more expert on their code than anyone else. 

I still haven't seen a good answer to the namespace problem.  You say
that files-as-directories is great, I'm definitely not convinced.  

The VFS is the body of code that handles most aspects of name
resolution today, so it sounds as if reiser4 is supposed to be the new
super-VFS, and you want to keep it that way and do not want to
integrate with the current VFS.  In that case resier4 really does not
belong in the mainstream kernel since it's your pet research project.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se

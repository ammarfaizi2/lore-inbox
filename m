Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268011AbUH3NSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268011AbUH3NSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268014AbUH3NSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:18:39 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:52390 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S268011AbUH3NSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:18:31 -0400
In-Reply-To: <4132DA55.5080903@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: silent semantic changes with reiser4 
Cc: flx@msu.ru, pj@sgi.com, riel@redhat.com, ninja@slaphack.com,
       torvalds@osdl.org, diegocg@teleline.es, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com,
       viro@parcelfarce.linux.theplanet.co.uk
X-Mailer: BeMail - Mail Daemon Replacement 2.3.1 Final
From: "Alexander G. M. Smith" <agmsmith@rogers.com>
Date: Mon, 30 Aug 2004 09:17:28 -0400 EDT
Message-Id: <48730003943-BeMail@cr593174-a>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote on Mon, 30 Aug 2004 00:42:13 -0700:
> or, 2) we should ask Alexander Smith to help with applying the graph 
> traversal cycle detection code that he wrote.

I put my foot into it, didn't I?  It's not too bad, one trick to simplify
things is to have the concept of a main parent and step parents.  The file
system name space graph is kept structured so that by always going upward
through the main parent, you're guaranteed to reach the root.  It doesn't
save anything on traversal when deleting files (you still have to visit
all the relevant nodes to check for cycles), but allows you to replace
hard links with a new kind of dynamic symbolic link.  The hard link
pretends to be a symbolic link presenting the "true path" to its target,
which changes as the target moves around (so it's not as reliable as real
hard link).  Old software doesn't see the cycles in the graph, just follows
the single true path to any particular object like it currently does, and
sees a bunch of symbolic links to everything else.  New software can see
the full parent list (not just a single "..") and the actual hard links.

> Ok, Linus and Viro, now I see why it was hard. Being able to effectively 
> connect to compound documents only with symlinks is a bit distasteful, 
> but it is quite livable, and I very much hope you decide it is better 
> than fragmenting the namespace.

Still, having hard links to attributes or directories of attributes is
useful.  For example, if several contact manager entries reference the
same person, it would be nice to have that represented as a hard link to
the attribute directory tree describing that person.  That's assuming you
implement contacts (name, address, etc) as a bunch of attributes in a
directory.

- Alex

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUHYW3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUHYW3L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUHYW15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:27:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:55690 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266175AbUHYWYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:24:36 -0400
Date: Wed, 25 Aug 2004 15:28:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040825152805.45a1ce64.akpm@osdl.org>
In-Reply-To: <412CEE38.1080707@namesys.com>
References: <20040824202521.GA26705@lst.de>
	<412CEE38.1080707@namesys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> I had not intended to respond to this because I have nothing positive to 
> say, but Andrew said I needed to respond and suggested I should copy 
> Linus.

Yes, but I didn't say "flame Christoph and ignore the issues" ;)

There are lots of little things to do with implementation, coding style,
module exports, deadlocks, what code goes where, etc.  These are all normal
daily kernel business and we should set them aside for now and concentrate
on the bigger issues.

And as I see it, there are two big issues:

a) reiser4 extends the Linux API in ways which POSIX/Unix/etc do not
   anticipate and 

b) it does this within the context of just a single filesystem.

I see three possible responses:

a) accept the reiser4-only extensions as-is (possibly with post-review
   modifications, of course) or

b) accept the reiser4-only extensions with a view to turning them into
   kernel-wide extensions at some time in the future, so all filesystems
   will offer the extensions (as much as poss) or

c) reject the extensions.


My own order of preference is b) c) a).  The fact that one filesystem will
offer features which other filesystems do not and cannot offer makes me
queasy for some reason.

b) means that at some time in the future we need to hoist the reiser4
extensions (at a conceptual level) (and probably with restrictions) up into
the VFS.  This will involve much thought, argument and work.


To get us started on this route it would really help me (and, probably,
others) if you could describe what these API extensions are in a very
simple way, without referring to incomprehehsible web pages, and without
using terms which non-reiser4 people don't understand.

It would be best if each extension was addressed in a separate email
thread.

We also need to discuss what a reiser4 "module" is, what its capabilities
are, and what licensing implications they have.

Then, we can look at each one and say "yup, that makes sense - we want
Linux to do that" and we can also think about how we would implement it at
the VFS level.

If we follow the above route I believe we can make progress in a technical
direction and not get deadlocked on personal/political stuff.


Now, an alternative to all the above is to just merge reiser4 as-is, after
addressing all the lower-level coding issues.  And see what happens.  That
may be a thing which Linus wishes to do.  I'm easy.

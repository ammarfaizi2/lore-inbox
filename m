Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbUBZCdd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbUBZCdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:33:33 -0500
Received: from dp.samba.org ([66.70.73.150]:45788 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262607AbUBZCda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:33:30 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Brian King <brking@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Question on MODULE_VERSION macro 
In-reply-to: Your message of "Wed, 25 Feb 2004 22:36:59 BST."
             <20040225213659.GA9985@mars.ravnborg.org> 
Date: Thu, 26 Feb 2004 12:50:37 +1100
Message-Id: <20040226023341.42E862C270@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040225213659.GA9985@mars.ravnborg.org> you write:
> Hi Rusty.
> 
> I have not yet fully understood why you want to parse every source file.
> I can see in the implemntation that you only calculate the sum of
> code-lines, and not comments.
> But why do we want to add this complexity - compared to just
> calculating the sum of the whole file?
> If the calculated sum is being presented as based on the source code
> I assume people can understand that the sum does not match even after
> updating a comment.

The strongest example is that Andrew Morton always "fixes" whitespace
as patches go through his tree.  It's about 50 lines of code, and it's
not slow (but has definite room for optimization).

> The current implementation fails to locate include files in the local
> directory when compiled using "make O=...".

There's no documentation I could find for "O=", BTW.  I'm not even
sure what it does...

> This is due to the fact that some files are present in the _deps
> file with full path, others with relative path.

Right. 8(

> My next question. Since we only parse a subset of the headers, is it
> really needed to parse any of them?
> My thinking is that we should either:
> a) parse all header files (except those marked with $(wildcard))
> b) parse no header files.

I was thinking of the driver author.  Driver consists of three .c
files, and a local .h file.  They want to catch anyone touching any of
these files.  But they don't want the sum to change just because
someone adds a new inline function to linux/kernel.h.

If it's impractical, we can just skip all the headers.  But it would
be a real loss.

> > +	cmd = malloc(strlen(objfile) + sizeof("..cmd"));
> 
> You miss a "+ 1" to count for trailing '\0'.

Um, sizeof() vs strlen().

> > +		len = strcspn(p, " \\\n");
> > +		if (memcmp(objfile, p, dirlen) == 0) {
> > +			char source[len + 1];
> gcc extension, you do not want to use malloc here?

Yeah, I love GCC.  It's also in ISO C, BTW.

> > +			printf("parsing %s\n", source);
> Debug printf - to be deleted.

Ack.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVD0ITm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVD0ITm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 04:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVD0ITf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 04:19:35 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:43447 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261189AbVD0ITX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 04:19:23 -0400
Date: Wed, 27 Apr 2005 10:18:13 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: Bodo Eggert <7eggert@gmx.de>, akpm@osdl.org, Jan Hudec <bulb@ucw.cz>,
       hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] private mounts
In-Reply-To: <OFF84C9B1E.2214C52C-ON88256FEF.007799F7-88256FEF.0079B32B@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0504270832180.2866@be1.lrz>
References: <OFF84C9B1E.2214C52C-ON88256FEF.007799F7-88256FEF.0079B32B@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Bryan Henderson wrote:

> >> Just to be clear, then: this idea is fundamentally different from the 
> >> mkdir/cd analogy the thread starts with above.
> >
> >NACK, it's very similar to the cd "$HOME" (or ulimit calls) done by the
> >login mechanism,
> 
> That's not a NACK.  The cd "$HOME" and ulimit calls done by the login 
> process (more precisely, by a shell profile) are quite different from the 
> mkdir/cd the thread started with.  Who creates a new directory in his 
> shell profile?

I create a directory in /tmp and set $TMP to that directory, because I 
can't just mount a private tmpfs. But that's another topic.

>  I assume the mkdir/cd analogy is a case of a person doing 
> a mkdir and cd in a running shell.  (That is indeed analogous to what one 
> would like to do with a private mount).

ACK, with respect to lifetime and processes affected, it will be exactly
like creating/using a directory in a tmpfs. But as you noticed, you'd need
the shell builtin command to make this analogy complete. That's not going
to happen, but it's not needed for operation.

> When you said "by the login process or by wrappers like nice," in response 
> to my pointing out that setnamespace would need to be a shell builtin 
> command, I assumed you were talking about putting it in the code that 
> execs the shell as opposed to in the shell profile, thus eliminating the 
> need for a shell builtin.

Exactly. You can't patch all login daemons, so you'll need pam to do the
initial setup.

After that, the users may decide to ignore having a private namespace (it
will just DTRT), or they can decide to use that feature to lock in some of
their programs. Obviously pam won't allow private sub-namespaces at random
times, while the general system call would support this, and their shell
won't do that, too. In the same way you'll need a wrapper like "#!/bin/sh
cd $dir&&exec $prog" for doing the initial chdir on behalf of
chdir-ignorant programs, you'll need a wrapper for setnamespace-ignorant
programs. The only difference is that chdir-ignorant programs are rare.

> But the important thing is just to recognize, as you say explicitly now, 
> that setnamespace has to be shell builtin command for 
> setnamespace/mknamespace to be analogous to mkdir/cd.  That was my 
> original statement, if somewhat indirect:

For the analogy yes, for usage no.
-- 
The secret of the universe is #@*%! NO CARRIER 

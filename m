Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWINWiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWINWiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWINWiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:38:18 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:41183 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S932073AbWINWiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:38:17 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: R: Linux kernel source archive vulnerable
Date: Thu, 14 Sep 2006 22:38:06 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <eeclke$s44$1@taverner.cs.berkeley.edu>
References: <20060907182304.GA10686@danisch.de> <B7C6636B-03E9-4D4C-AC0E-2898181F419B@mac.com> <ee8a8j$gf7$1@taverner.cs.berkeley.edu> <45F1F6C1-FB19-4E6D-BEFE-B8C541D7A2F3@mac.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1158273486 28804 128.32.168.222 (14 Sep 2006 22:38:06 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Thu, 14 Sep 2006 22:38:06 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the impression that people are tired of hearing about this,
so I thought I'd collect my responses to the most recent set of posts
into a single message.  I'll try to make this my last message on this
subject.

Kyle Moffett wrote:
> I fail to see how you get world-writable  
> files from a kernel tree unless your umask is 0000 or you're using  
> tar in backup-mode [...]

Think about this from the point of view of the user, who may well
say something like: "Huh?  I don't know what you're talking about.
What do you mean, backup-mode?  I didn't tell tar to use some special
mode.  I used it with its default options."  It seems to me that it
would be reasonable to ask that extracting the Linux tarball using the
default options should lead to some fairly sane state on the filesystem.

Kyle Moffett wrote:
> For that matter, how do you determine which  
> user it should extract as?  UID 0?

Yes, that is the obvious choice.  It's a good default that will be
right for 99.99% of users.

Kyle Moffett wrote:
> Actually, if you start browsing random software tarballs you'll find  
> that 1 in 5 or so has world-write permissions on at _minimum_ the  
> root directory, more often the whole source tree.

I didn't realize that.  Thanks for checking.  Well, I consider that
unfortunate and poorly chosen.  I guess I'm out of date.

Martin Mares wrote:
> People extracting random archives as root with preserving permissions
> (and owners) are relying on *ALL* archive creators using what they suppose
> are the right permissions, which is at least simple-minded, if not completely
> silly.

I'm not suggesting extracting random archives as root.  But I don't
see a problem with extracting Linux kernel archives as root.  I'm prepared
-- or I was prepared -- to trust the Linux kernel developers not to
deliberately do anything that would harm my system.  After all, if the
Linux kernel developers are malicious, I'm totally screwed; the act of
running their code requires a great deal of trust, and extracting a tarball
as root seems very minor compared to that.

Martin Mares wrote:
> If you want to help such users, you should do so by helping them
> understand they do a wrong thing and not by hiding the problem in a single
> specific case.

You can do both.  You can educate users, *and* provide sensible defaults
in the meantime for those users who don't already know about the risks.

Stefan Richter wrote:
> Correction: Some users who set a wrong umask when creating files by
> extraction from these archives and then attempt to build an own kernel
> from that may screw themselves over.

No, this is not correct.  For non-root users who set their umask to
something silly, I agree that this is their problem, not Linux's problem.
But that's not what I'm talking about.  I'm talking about the case of a
root user who extracts the tar archive with 'tar xzvf'.  That's a very
natural thing to do, and what I'm saying is that unsuspecting users
are likely to get bitten by the presence of 0666 files in the Linux
kernel tarball.  That seems unfortunate.

Keep in mind that there are good reasons to extract the Linux tarball
as root.  There is a long-standing tradition of storing the kernel
source under /usr/src, and usually /usr/src is writeable only by root.
Moreover, I bet that many users are not intimately familiar with tar
and all its obscure options, and consequently are unaware of the need
for --no-same-permissions.  Those users are likely to get bitten by
this pitfall.  I still think it would be a kindness to users to not set
up this trap for them to fall into; to distribute the Linux tarball with
files that are not group- or world-writeable.

It feels to me like there is this attitude towards users that says "if you
don't know all of the esoteric tar options, you deserve what you get".
I don't believe in punishing users for their ignorance.

It's not like it would be a terrible hardship to change all the
0666 permissions to 0644.  There's basically no downside to doing so.
The Linux tarballs used to have 0644-style permissions for years, and I'm
not aware of any users complaining that they wished you would change all
the 0644 permissions to 0666.  Instead, it sounds like that the change to
0666 happened perhaps by accident, maybe without much discussion about
the consequences for users, and now there is inertia and resistance to
changing it back.

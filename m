Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbSJaW0c>; Thu, 31 Oct 2002 17:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265415AbSJaW0c>; Thu, 31 Oct 2002 17:26:32 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:45529 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265414AbSJaW0b>; Thu, 31 Oct 2002 17:26:31 -0500
Subject: Re: What's left over.
From: john stultz <johnstul@us.ibm.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021031184933.B2599@almesberger.net>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
	<Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com>
	<20021031031932.GQ15886@ns> <1036098562.12714.50.camel@cog> 
	<20021031184933.B2599@almesberger.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 14:32:12 -0800
Message-Id: <1036103533.12714.71.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 13:49, Werner Almesberger wrote:
> john stultz wrote:
> > groups for each project, I have no clue how anyone would be able to
> > handle the (unix)group management required. ACLs let the users
> > themselves manage what people got what access to their data.
> 
> Note that POSIX ACLs don't seem to solve this either: they only
> let you control access in terms of existing users or groups.

I've never looked at the POSIX ACL spec, so forgive my ignorance.
 
> IMHO, this is one of the standard pitfalls of ACLs: if they don't
> let you aggregate information, you quickly end up with huge ACLs
> hanging off every file, and each of those ACLs wants to be
> carefully maintained. I've seen a lot of this in my VMS days.
> (Unix is a bit better, because you can control access at a
> directory level, while VMS needs the ACL on each file, because
> you can open files directly by VMS' equivalent to an inode
> number, without traversing the directory hierarchy. Of course,
> many users didn't know that :-)

While it would be nice to have user-definable ACL groups ("my friends"
or "History 255 TAs") in addition to existing users and groups, I still
don't find this to be critical. Sure, it adds (possibly quite a bit of)
extra data to every file, but it gives you the granularity you need for
the situation I described.  It seems like user-definable ACL groups
would be a nice extra feature on top of existing users or groups, but
not a necessity.

> To make ACLs truly scalable, it would be nice to be able to
> express permissions in terms of access to other filesystem
> objects. E.g. "everybody who can read file ~me/acls/my_friends
> can write the directory on which this ACE hangs". This should
> work like a symlink, i.e. if I add new friends to my_friends, I
> don't have to update all my ACLs.

Ugh, that seems dangerous. Too many forgotten ACL links and then I could
accidentally give a vague acquaintance access to all my data meant for
close friends. 

Regardless, while ACLs do result in extra data per file being used, it
is my understanding that ACLs allow you to solve problems that currently
aren't solvable w/o administrator intervention. In my experience using
them w/ AFS, they have been extremely useful. 


-john



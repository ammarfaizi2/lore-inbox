Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265354AbSJaVnY>; Thu, 31 Oct 2002 16:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265363AbSJaVnX>; Thu, 31 Oct 2002 16:43:23 -0500
Received: from almesberger.net ([63.105.73.239]:60935 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265354AbSJaVnW>; Thu, 31 Oct 2002 16:43:22 -0500
Date: Thu, 31 Oct 2002 18:49:33 -0300
From: Werner Almesberger <wa@almesberger.net>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: What's left over.
Message-ID: <20021031184933.B2599@almesberger.net>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com> <20021031031932.GQ15886@ns> <1036098562.12714.50.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036098562.12714.50.camel@cog>; from johnstul@us.ibm.com on Thu, Oct 31, 2002 at 01:09:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Cc: trimmed ]

john stultz wrote:
> groups for each project, I have no clue how anyone would be able to
> handle the (unix)group management required. ACLs let the users
> themselves manage what people got what access to their data.

Note that POSIX ACLs don't seem to solve this either: they only
let you control access in terms of existing users or groups.

IMHO, this is one of the standard pitfalls of ACLs: if they don't
let you aggregate information, you quickly end up with huge ACLs
hanging off every file, and each of those ACLs wants to be
carefully maintained. I've seen a lot of this in my VMS days.
(Unix is a bit better, because you can control access at a
directory level, while VMS needs the ACL on each file, because
you can open files directly by VMS' equivalent to an inode
number, without traversing the directory hierarchy. Of course,
many users didn't know that :-)

To make ACLs truly scalable, it would be nice to be able to
express permissions in terms of access to other filesystem
objects. E.g. "everybody who can read file ~me/acls/my_friends
can write the directory on which this ACE hangs". This should
work like a symlink, i.e. if I add new friends to my_friends, I
don't have to update all my ACLs.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

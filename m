Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265145AbSJaDOe>; Wed, 30 Oct 2002 22:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265146AbSJaDOe>; Wed, 30 Oct 2002 22:14:34 -0500
Received: from dp.samba.org ([66.70.73.150]:40644 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265145AbSJaDN2>;
	Wed, 30 Oct 2002 22:13:28 -0500
To: torvalds@transmeta.com
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, geert@linux-m68k.org,
       rmk@arm.linux.org.uk, peter@chubb.wattle.id.au, tytso@mit.edu
In-reply-to: <20021031030143.401DA2C150@lists.samba.org> (message from Rusty
	Russell on Thu, 31 Oct 2002 14:00:31 +1100)
Subject: Re: What's left over.
Reply-To: tridge@samba.org
Message-Id: <20021031031954.56C772C156@lists.samba.org>
Date: Wed, 30 Oct 2002 22:19:54 -0500 (EST)
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > ext2/ext3 ACLs and Extended Attributes
> > 
> > I don't know why people still want ACL's. There were noises about them for 
> > samba, but I'v enot heard anything since. Are vendors using this?
> 
> SAMBA needs them, which is why serious Samba boxes use XFS.  Tridge,
> Ted?

oh yes, all the Linux based storage appliances use ACLs. Posix ACLs
aren't ideal for Samba, but they are *much* better than having no ACLs
at all. The Posix ACL code has been in Samba for a long time (getting
close to 3 years now?). 

Eventually I'd like to see a combination of LSM with a new ACL system
give the ability to support full NT ACLs on Linux (which is also
needed for full nfsv4 support), but that is way too much to do for
the 2.6 kernel.

For the majority of windows users the mapping Samba does internally
between Posix ACLs and NT ACLs is sufficient for now. 

I think that it would be a very good thing for Posix ACLs to be
included in the 2.6 kernel, especially in ext3.

Extended attributes are also important as they give a place to store
all the extra DOS info that has no other logical place in a posix
filesystem. For example, we can put the 'read only', 'archive', 'hidden'
and 'system' attributes there. If we don't have extended attributes
then we need to use a nasty kludge where these map to various unix
permission bits, but the mapping is terrible and doesn't give the
correct semantics (especially for things like read only on
directories). 

My main concern with using extended attributes in this way is
performance. My experience with XFS is that as soon as you start
adding extended attributes then the performance drops a lot, but I
haven't tested performance with the ext3 extended attributes so maybe
they don't have the same problem.

Cheers, Tridge

--
http://samba.org/~tridge/

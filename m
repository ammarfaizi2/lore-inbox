Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281199AbRKPAUy>; Thu, 15 Nov 2001 19:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281196AbRKPAUf>; Thu, 15 Nov 2001 19:20:35 -0500
Received: from mail309.mail.bellsouth.net ([205.152.58.169]:59871 "EHLO
	imf09bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281194AbRKPAUP>; Thu, 15 Nov 2001 19:20:15 -0500
Message-ID: <3BF45B9F.DEE1076B@mandrakesoft.com>
Date: Thu, 15 Nov 2001 19:19:43 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: synchronous mounts
In-Reply-To: <3BF376EC.EA9B03C8@zip.com.au> <20011115214525.C14221@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> It's not clear to me that chattr/mount sync options make _any_ sense
> for regular file metadata.  Rather than tightening up the semantics,
> I'd actually prefer to restrict them so that they only apply to
> directories.  Users who set the sync bits are usually doing so for
> applications like MTAs where it's directory syncing which is
> what matters: the apps typically fsync the files themselves, anyway.

I don't think it is correct to make that assumption.

When working on something likely to crash, I always remount my
filesystems 'sync' with the intention to have the kernel immediately
sync to disk anything and everything it is coded to do.  Since the
kernel is responsible to flushing data to disk, it makes perfect sense
to have an option to sync not only metadata but data to disk
immediately, if the user desires such.

Further, expecting all apps to fsync(2) files under the right
circumstances is not reasonable.  There are "normal" circumstances where
someone expects non-syncing behavior of "cat foo bar > foobar", and then
there are extentuating circumstances where another expects the shell to
sync that command immediately.  Should we rewrite cat/bash/apps to all
fsync, depending on an option?  Should we expect people to modify all
their shell scripts to include "/bin/sync" for those times when they
want data-sync?  Such is not scalable at all.

It would make more sense to me to implement 'sync' as sync-everything,
and add 'dirsync' or 'metasync' for syncing only directories or only
metadata.

As it stands, it seems like redefining 'sync' to sync less data than is
currently done is not only changing current behavior, but providing less
to users overall.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


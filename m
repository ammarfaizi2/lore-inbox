Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136681AbREARlv>; Tue, 1 May 2001 13:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136680AbREARll>; Tue, 1 May 2001 13:41:41 -0400
Received: from mons.uio.no ([129.240.130.14]:4277 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S136677AbREARl2>;
	Tue, 1 May 2001 13:41:28 -0400
To: Raphael Manfredi <ram@ram.fr.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3-ac9/4 - NFS corruption
In-Reply-To: <9cmd8l$s38$1@lyon.ram.loc>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 01 May 2001 19:41:16 +0200
In-Reply-To: ram@ram.fr.eu.org's message of "1 May 2001 13:21:25 GMT"
Message-ID: <shsn18x6k77.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Raphael Manfredi <ram@ram.fr.eu.org> writes:

     > My NFS client runs 2.4.3-ac4 (SMP).  My NFS server uses
     > user-land NFS and runs 2.4.3-ac9 (UP).

     > I've seens the following in my ~/mail/inbox, NFS mounted:

     > 	^@^@^@^@^@^@est-admin@lists.sourceforge.net Tue May 1 14:47:02
     > 	2001

     > On the server, the same line reads:

     > 	From test-admin@lists.sourceforge.net Tue May 1 14:47:02 2001

     > The above "^@" are NULL bytes, as displayed by "vi".  The data
     > around those NULL bytes were perfect, i.e. there was text
     > before in the mailbox that was correct.

     > An "ls -l" on the file yields:

     > 	-rw------- 1 ram users 1642491 May 1 00:00 inbox

     > (on the server, and via NFS), which is *abnormal*, since it's
     > 15:18 and I've just updated the file.  Therfore, the timestamp
     > is corrupted as well in the inode.

In that case you have some other task that has done a 'touch' or
something to the file. An NFS client does not explicitly set the
timestamp when doing ordinary reading/writing to a file - it leaves it
to the server to do so.

     > If I create a file, via "> ~/mail/test" on NFS, it reads:

     > 	-rw-r--r-- 1 ram users 0 May 1 15:19 test

     > with a proper timestamp.

     > The NFS access is done via a symlink to an NFS-mounted dir,
     > i.e. ~/mail is actually a symlink to /nfs/lyon/home/ram/mail.

     > Any hint as to what is happening?  Is that a known problem?

Would you happen to be delivering mail to the same file on the server
or something like that?
If so it's completely normal behaviour: the userland NFS doesn't
support file locking, so there's no way that the client can guarantee
that some task on the server won't write to the file behind its
back...

Cheers,
  Trond

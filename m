Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135801AbREANWo>; Tue, 1 May 2001 09:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135828AbREANWd>; Tue, 1 May 2001 09:22:33 -0400
Received: from AGrenoble-101-1-1-33.abo.wanadoo.fr ([193.251.23.33]:57587 "EHLO
	lyon.ram.loc") by vger.kernel.org with ESMTP id <S135801AbREANWU>;
	Tue, 1 May 2001 09:22:20 -0400
To: linux-kernel@vger.kernel.org
From: ram@ram.fr.eu.org (Raphael Manfredi)
Subject: 2.4.3-ac9/4 - NFS corruption
Date: 1 May 2001 13:21:25 GMT
Organization: Home, Grenoble, France
Message-ID: <9cmd8l$s38$1@lyon.ram.loc>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My NFS client runs 2.4.3-ac4 (SMP).
My NFS server uses user-land NFS and runs 2.4.3-ac9 (UP).

I've seens the following in my ~/mail/inbox, NFS mounted:

	^@^@^@^@^@^@est-admin@lists.sourceforge.net  Tue May  1 14:47:02 2001

On the server, the same line reads:

	From test-admin@lists.sourceforge.net  Tue May  1 14:47:02 2001

The above "^@" are NULL bytes, as displayed by "vi".
The data around those NULL bytes were perfect, i.e. there was text before
in the mailbox that was correct.

An "ls -l" on the file yields:

	-rw-------    1 ram      users     1642491 May  1 00:00 inbox

(on the server, and via NFS), which is *abnormal*, since it's 15:18 and
I've just updated the file.  Therfore, the timestamp is corrupted as well
in the inode.

If I create a file, via "> ~/mail/test" on NFS, it reads:

	-rw-r--r--    1 ram      users           0 May  1 15:19 test

with a proper timestamp.

The NFS access is done via a symlink to an NFS-mounted dir, i.e. ~/mail
is actually a symlink to /nfs/lyon/home/ram/mail.

Any hint as to what is happening?  Is that a known problem?

Raphael

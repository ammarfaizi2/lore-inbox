Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289939AbSAOPdj>; Tue, 15 Jan 2002 10:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289968AbSAOPdT>; Tue, 15 Jan 2002 10:33:19 -0500
Received: from moutng0.kundenserver.de ([212.227.126.170]:60926 "EHLO
	moutng0.schlund.de") by vger.kernel.org with ESMTP
	id <S289939AbSAOPdN>; Tue, 15 Jan 2002 10:33:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: [BUG] symlink problem with knfsd and reiserfs
Date: Tue, 15 Jan 2002 16:32:12 +0100
X-Mailer: KMail [version 1.3.2]
Cc: trond.myklebust@fys.uio.no, Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de> <15428.6953.453942.415989@charged.uio.no> <15428.14268.730698.637522@laputa.namesys.com>
In-Reply-To: <15428.14268.730698.637522@laputa.namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020115153224.5B55513E2@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 15. January 2002 15:07, Nikita Danilov wrote:
> Trond Myklebust writes:
>  > >>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:
>  >      > In syslog, this message appears: Jan 15 00:21:03 elfe kernel:
>  >      > nfs_refresh_inode: inode 50066 mode changed, 0100664 to 0120777
>  >
>  > The error is basically telling you that ReiserFS filehandles are being
>  > reused by the server. Doesn't Reiser provide a generation count to
>  > guard against this sort of thing?
>
> Yes, inode->i_generation is stored in the file handle:
> fs/reiserfs/inode.c:reiserfs_dentry_to_fh().
>
> Hans-Peter, what version of NFS are you using and have you remounted
> clients after upgrading to the newer kernel?

I can reproduce it with 2.4.5, 6, 13-ac7, 18-pre3 with and without Trond's
NFS-ALL patches applied. I don't understand your question, but testing this
implied several reboots of the server and some dozen reboots on the client.

The lm_sensors build reproduced it pretty stable (with a few exceptions,
and on different commands of the range ar, gcc and ln)
Test is pretty simple: clean make of lm_sensors almost all the time 
triggers it. If not, just rm lib/libsensors* and make again. This
created certainly stale files lib/libsensors.so|lib/libsensors.so.1
from within the client. You can only get rid of them by rebooting or
removing them on the server.

>  > My 'fix' just solves the immediate problem of the wrong file mode. It
>  > does not solve the problems of data corruption that can occur when the
>  > client is incapable of distinguishing the 'old' and 'new' files that
>  > share the same filehandle.
>
> This requires i_generation overflow (modulo bug in reiserfs).

Please, try to reproduce it, and let us know, if you can reproduce it.

>  > Cheers,
>  >   Trond
>
> Nikita.

Cheers,
  Hans-Peter

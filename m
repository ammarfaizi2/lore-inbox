Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289563AbSAONJD>; Tue, 15 Jan 2002 08:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289568AbSAONIy>; Tue, 15 Jan 2002 08:08:54 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:52999 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289563AbSAONIg>; Tue, 15 Jan 2002 08:08:36 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15428.14268.730698.637522@laputa.namesys.com>
Date: Tue, 15 Jan 2002 17:07:56 +0300
To: trond.myklebust@fys.uio.no
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Hans-Peter Jansen <hpj@urpla.net>,
        linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [BUG] symlink problem with knfsd and reiserfs 
In-Reply-To: <15428.6953.453942.415989@charged.uio.no>
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de>
	<15428.6953.453942.415989@charged.uio.no>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust writes:
 > >>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:
 > 
 >      > In syslog, this message appears: Jan 15 00:21:03 elfe kernel:
 >      > nfs_refresh_inode: inode 50066 mode changed, 0100664 to 0120777
 > 
 > The error is basically telling you that ReiserFS filehandles are being
 > reused by the server. Doesn't Reiser provide a generation count to
 > guard against this sort of thing?

Yes, inode->i_generation is stored in the file handle:
fs/reiserfs/inode.c:reiserfs_dentry_to_fh().

Hans-Peter, what version of NFS are you using and have you remounted
clients after upgrading to the newer kernel?

 > 
 > My 'fix' just solves the immediate problem of the wrong file mode. It
 > does not solve the problems of data corruption that can occur when the
 > client is incapable of distinguishing the 'old' and 'new' files that
 > share the same filehandle.

This requires i_generation overflow (modulo bug in reiserfs).

 > 
 > Cheers,
 >   Trond

Nikita.

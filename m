Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272619AbRIGM11>; Fri, 7 Sep 2001 08:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272620AbRIGM1G>; Fri, 7 Sep 2001 08:27:06 -0400
Received: from pat.uio.no ([129.240.130.16]:48366 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S272619AbRIGM0z>;
	Fri, 7 Sep 2001 08:26:55 -0400
MIME-Version: 1.0
Message-ID: <15256.48410.491658.624569@charged.uio.no>
Date: Fri, 7 Sep 2001 14:27:06 +0200
To: ptb@it.uc3m.es
Cc: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 NFS Problems
In-Reply-To: <200109071206.OAA24577@nbd.it.uc3m.es>
In-Reply-To: <shsae07md9d.fsf@charged.uio.no>
	<200109071206.OAA24577@nbd.it.uc3m.es>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Peter T Breuer <ptb@it.uc3m.es> writes:

     > It would be nice if nfs could do the a remount automatically
     > when the nfs handle it has goes stale an dit discovers it.  Is
     > that part of v3 nfs or not?

The exact wording in RFC1813 is

   NFS3ERR_STALE
       Invalid file handle. The file handle given in the
       arguments was invalid. The file referred to by that file
       handle no longer exists or access to it has been
       revoked.

The problem is with the 'access to it has been revoked'. It says
nothing about whether or not that is permanent, hence you have to be
very careful about applying this concept to the mount point.

In any case, remounting automatically is a very bad idea unless you do
it cleanly (i.e. kill all existing processes, unmount the disk, and
then start afresh). If you just do it transparently and don't clean
out the (d|i)caches, you will see some pretty odd things happening if
filehandles on the new disk don't match the filehandles on the old
disk.
This is BTW the reason why unfsd is badly broken wrt. CDROMS.

     > But soft mounts at least break nicely and automatically.  And
     > since failures are inevitable, I prefer them.

     > Come to think of it, why not have an option that does a
     > hard,intr but sends a ^C automatically to all referents when a
     > stale handle is detected.

See above.

Cheers,
   Trond

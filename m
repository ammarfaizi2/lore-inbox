Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269172AbUIBVhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269172AbUIBVhq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUIBVhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:37:20 -0400
Received: from advect.atmos.washington.edu ([128.95.89.50]:39575 "EHLO
	advect.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S269175AbUIBVen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:34:43 -0400
Message-Id: <200409022134.i82LYZBD006424@moist.atmos.washington.edu>
Date: Thu, 2 Sep 2004 14:34:26 -0700 (PDT)
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: NFS problem with 2.6.9-rc1-bk7
From: Harry Edmon <harry@atmos.washington.edu>
In-Reply-To: <1094058222.8528.45.camel@lade.trondhjem.org>
X-Mailer: Ishmail 2.1.0-20021115-i686-pc-linux-gnu <http://ishmail.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------1ljewotqxnja4nzqunda4ny5hz2z5y25rqgf0bw9zlndhc2hpb"
X-Spam-Score: -15.007 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*************************************************************************
* This message has been formatted as a MIME message.  If you are reading
* this, your mail reader does not support MIME.  To display the non-text
* portions of this message you will need a MIME-capable mail reader such
* as Ishmail (http://ishmail.sourceforge.net).
*************************************************************************

------------1ljewotqxnja4nzqunda4ny5hz2z5y25rqgf0bw9zlndhc2hpb
Content-Type: text/enriched
Content-Transfer-Encoding: quoted-printable

Well, the mount of /proc/fs/nfs helped, but it pointed out another
problem.  In my exports file have entries like the following:


/home/data    stormy.atmos.washington.edu(rw,sync,no_root_squash)
pond91.drizzle.com(rw,sync,insecure)
flake.atmos.washington.edu(rw,sync,no_root_squash)
dry.atmos.washington.edu(rw,sync,no_root_squash)
viking.atmos.washington.edu(rw,sync,insecure)
damp(rw,sync,no_root_squash)  *.atmos.washington.edu(rw,sync)


When I mount the nfsd file systems, machines individually listed in the
exports file have problems mounting the disk - they either get
"permission denied", or the mount hangs.  As soon as a shut down the nfs
server, unmount nfsd, and start it up again the hung mounts finish (just
stopping and starting does not fix the problem).  If I replace the
wildcard entry with a netgroup entry the problem does not occur with
nfsd mounted.


Trond Myklebust <<trond.myklebust@fys.uio.no> wrote:

<Excerpt>P=E5 on , 01/09/2004 klokka 12:06, skreiv Harry Edmon:

> I have been trying newer versions of the kernel on a web/NFS server

> tofix memory problems that seem to be associated with NFS for all

> 2.6versions through 2.6.8.1-mm4.  Andrew Morton suggested I try the

> latestsnapshot.  With this version (2.6.9-rc1-bk7) I have the problem

> that NFSclients will spontaneously find themselves without permission

> to accessthe files on the server.  When I type "exportfs -ar" on the

> server, theclients get better for awhile, and then fail.  The message

> I see on theserver is:

> =


> Sep  1 08:17:57 funnel rpc.mountd: getfh failed: Operation not

> permitted


Looks like that is more of a question for Neil Brown than for me.


That said 2.6 kernels require more recent versions of nfs-utils, and

require you to mount the "nfsd" pseudofilesystem on /proc/fs/nfsd or

/proc/fs/nfs (see the "exportfs" manpage). Have you checked that this is

indeed the case?


Cheers,

  Trond


</Excerpt>=

------------1ljewotqxnja4nzqunda4ny5hz2z5y25rqgf0bw9zlndhc2hpb
Content-Description: Signature
Content-Type: text/enriched


-- 
 Dr. Harry Edmon			E-MAIL: harry@atmos.washington.edu
 206-543-0547				harry@u.washington.edu
 Dept of Atmospheric Sciences		FAX:	206-543-0308
 University of Washington, Box 351640, Seattle, WA 98195-1640

------------1ljewotqxnja4nzqunda4ny5hz2z5y25rqgf0bw9zlndhc2hpb--

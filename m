Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbSKOTya>; Fri, 15 Nov 2002 14:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266627AbSKOTya>; Fri, 15 Nov 2002 14:54:30 -0500
Received: from mons.uio.no ([129.240.130.14]:21208 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S266622AbSKOTy3>;
	Fri, 15 Nov 2002 14:54:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15829.21137.152716.652146@helicity.uio.no>
Date: Fri, 15 Nov 2002 21:01:21 +0100
To: Juan Gomez <juang@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: Non-blocking lock requests during the grace period
In-Reply-To: <OF5A692563.A6ED6EBB-ON87256C72.0068B38D@us.ibm.com>
References: <OF5A692563.A6ED6EBB-ON87256C72.0068B38D@us.ibm.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Juan Gomez <juang@us.ibm.com> writes:

     > (note that F_GETLK man page does not provide EAGAIN as a
     > possible error code).

Hmm....

In the Single UNIX spec, there appears to be a rather unexpected
difference between expected behaviour for lockf and fcntl here:


http://www.db.opengroup.org/cgi-bin/dbcgi?CALLER=sud2/indx.tpl&TOKEN=FIYR&TPL=sd_fileframe&dir=xsh&file=lockf

[EACCES] or [EAGAIN]
       The function argument is F_TLOCK or F_TEST and the section is already
       locked by another process.

OTOH

http://www.db.opengroup.org/cgi-bin/dbcgi?CALLER=sud2/indx.tpl&TOKEN=FIYR&TPL=sd_fileframe&dir=xsh&file=fcntl

[EACCES] or [EAGAIN]
    The cmd argument is F_SETLK, and one of the following conditions
    is true:

        * The type of lock (l_type) is shared ( F_RDLCK) or exclusive
          ( F_WRLCK), and the segment of a file to be locked is
          already exclusive locked by another process.
        * The type of lock is exclusive, and some portion of the file
          segment to be locked is already shared locked or exclusive
          locked by another process.

Cheers,
  Trond

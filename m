Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSHHNjX>; Thu, 8 Aug 2002 09:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317541AbSHHNjX>; Thu, 8 Aug 2002 09:39:23 -0400
Received: from mons.uio.no ([129.240.130.14]:50110 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317540AbSHHNjW>;
	Thu, 8 Aug 2002 09:39:22 -0400
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: "'Jesse Pollard'" <pollard@tomcat.admin.navo.hpc.mil>,
       "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: O_SYNC option doesn't work (2.4.18-3)
References: <EE83E551E08D1D43AD52D50B9F511092E114E4@ntserver2>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 08 Aug 2002 15:42:30 +0200
In-Reply-To: <EE83E551E08D1D43AD52D50B9F511092E114E4@ntserver2>
Message-ID: <shsbs8d31rt.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Gregory Giguashvili <Gregoryg@ParadigmGeo.com> writes:

     > When the writer closes the file, how do you make the readers
     > see the latest changes (assuming that you always open/close
     > files per transaction type).

There is a convention amongst NFS clients that each client will always
flush *all* changes to the server upon close(), and it will always
check the file attributes upon a call to open() (and if the mtime or
file size have changed, one flushes the page cache).
This suffices to guarantee file cache consistency *provided* that only
one client opens the file at any given time.

If locking is used, all changes are flushed to the server upon
taking/releasing a lock, and the page cache is guaranteed to get
flushed upon taking a lock.

Cheers,
  Trond

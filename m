Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSELXtC>; Sun, 12 May 2002 19:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSELXtB>; Sun, 12 May 2002 19:49:01 -0400
Received: from pat.uio.no ([129.240.130.16]:2455 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315456AbSELXs7>;
	Sun, 12 May 2002 19:48:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15582.65383.578660.222454@charged.uio.no>
Date: Mon, 13 May 2002 01:48:55 +0200
To: Mario Vanoni <vanonim@dial.eunet.ch>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: NFS problem after 2.4.19-pre3, not solved
In-Reply-To: <3CDC4962.4B9393D7@dial.eunet.ch>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Mario Vanoni <vanonim@dial.eunet.ch> writes:

     > Hi Trond, hi Andrea, hi All In production environment, since >6
     > months, ethernet 10Mbits/s, on backup_machine mount -t nfs
     > production_machine /mnt.

     > find `listing from production_machine` | \ cpio -pdm
     > backup_machine

     > Volume ~320MB, nearly constant.

     > Medium times:

     > 2.4.17-rc1aa1: 1m58s, _the_ champion !!!

     > all later's, e.g.:

     > 2.4.19-pre8aa2; 4m35s 2.4.19-pre8-ac1: 4m00s
     > 2.4.19-pre7-rmap13a: 4m02s 2.4.19-pre7: 4m35s 2.4.19-pre4:
     > 4m20s

     > the last usable was:

     > 2.4.19-pre3: 2m35s, _not_ a champion

     > All benchmarks don't reflect some production needs, <2 minutes
     > or >4 minutes is a great difference !!!

     > Mario, not in lkml, but active reader (and tester).

Mario,

Your case where you transfer 320MB in 1'58" is either a measurement
error, or it involves some pretty heavy caching, since otherwise you
would be reading at ~3MB/sec == ~24Mbit/s over a 10Mbit line.

4 minutes is in fact wire speed for 320MB of data over a 10Mbit
connection. To imply that is 'unusable' would be a tad exaggerating...


It may indeed be that the CTO patch is having an effect on the cache
but it should only do so if the file's mtimes or inode number or NFS
filehandle are changing with time.
If not, then the only thing that could be causing cache invalidation
is memory pressure and the standard Linux memory reclamation scheme.

Cheers,
  Trond

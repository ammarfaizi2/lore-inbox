Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbTAVM5t>; Wed, 22 Jan 2003 07:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267473AbTAVM5t>; Wed, 22 Jan 2003 07:57:49 -0500
Received: from mons.uio.no ([129.240.130.14]:11243 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267472AbTAVM5s>;
	Wed, 22 Jan 2003 07:57:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15918.38755.480267.413305@charged.uio.no>
Date: Wed, 22 Jan 2003 14:06:43 +0100
To: Oliver Tennert <tennert@science-computing.de>
Cc: linux-kernel@vger.kernel.org, kw@science-computing.de
Subject: NFS client problem and IO blocksize
In-Reply-To: <Pine.GHP.4.02.10301221121260.4286-100000@alderaan.science-computing.de>
References: <Pine.GHP.4.02.10301221121260.4286-100000@alderaan.science-computing.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Oliver Tennert <tennert@science-computing.de> writes:

     > The problem is that the rsize/wsize options seem to be ignored:

     > hal9000:/home/tennert # mount -o
     > nfsvers=3,udp,rsize=1024,wsize=1024 ilka2000:/scr /mnt
     > hal9000:/home/tennert # stat /mnt/Snatch.avi
     >   File: `/mnt/Snatch.avi' Size: 724893696 Blocks: 1415816 IO
     >   Block: 4096 Regular File

rsize/wsize have in principle nothing to do with the blocksize that
'stat' returns. The f_bsize value specifies the 'optimal transfer
block size'. Previously this has been set to the rsize/wsize, but when
you add in O_DIRECT, then 32k becomes too large a value to align
to. For this reason, the f_bsize value was changed to reflect the
actual block size used by the *server*.

Cheers,
  Trond

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbTAVPXL>; Wed, 22 Jan 2003 10:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbTAVPXL>; Wed, 22 Jan 2003 10:23:11 -0500
Received: from mons.uio.no ([129.240.130.14]:46723 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S261593AbTAVPXJ>;
	Wed, 22 Jan 2003 10:23:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15918.47480.31996.510033@charged.uio.no>
Date: Wed, 22 Jan 2003 16:32:08 +0100
To: Oliver Tennert <tennert@science-computing.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client problem and IO blocksize
In-Reply-To: <Pine.GHP.4.02.10301221459090.7581-100000@alderaan.science-computing.de>
References: <15918.40855.583602.576856@charged.uio.no>
	<Pine.GHP.4.02.10301221459090.7581-100000@alderaan.science-computing.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Oliver Tennert <tennert@science-computing.de> writes:

     > OK thanks. But I am sorry to push you once more, Trond: can you
     > now give me just a brief explanation of difference between the
     > "wsize" option and the "wtmult" attribute? Is it better now to
     > disable O_DIRECT and use a larger wsize/rsize, or to enable it
     > and be content with the parameters it uses?

wsize gives you the maximum number of bytes NFS is allowed to send in
a single NFSPROC_WRITE RPC call. (rsize gives the same number for
NFSPROC_READ calls). The NFS client will usually wait until it has
'wsize' bytes or more in the page cache before it tries to send
anything over to the server.

OTOH wtmult has nothing to do with RPC, and has more to do with the
disk organization on the server.
As I understand it, in many cases the significance of this value lies
in the fact that hardware operations to the disk have a lower limit on
the number of bytes that can be read/written. IOW if your write is not
aligned to a 'wtmult' boundary, then the server may be forced to read
in the remaining data from the disk before it writes the entire block
back.

Cheers,
  Trond

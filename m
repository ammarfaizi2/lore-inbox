Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbTAMPsl>; Mon, 13 Jan 2003 10:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267679AbTAMPsl>; Mon, 13 Jan 2003 10:48:41 -0500
Received: from mons.uio.no ([129.240.130.14]:34947 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S267633AbTAMPsk>;
	Mon, 13 Jan 2003 10:48:40 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Performance problems with NFS under 2.4.20
References: <m3y95pkqpd.fsf@quimbies.gnus.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Jan 2003 16:57:28 +0100
In-Reply-To: <m3y95pkqpd.fsf@quimbies.gnus.org>
Message-ID: <shsfzrxrqjb.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Lars Magne Ingebrigtsen <larsi@gnus.org> writes:

     > Upgrading from 2.2.20, I'm seeing vastly increased network
     > traffic, and after poking around a bit, I find that all calls
     > to open() on files on NFS-mounted partitions generates one UDP
     > packet.  Switching on NFS debugging, and then saying

     > $ cat file $ cat file

     > shows me this:

     > Jan 13 16:27:23 litos kernel: NFS: refresh_inode(b/876609548
     > ct=1 info=0x2) Jan 13 16:27:23 litos kernel: nfs: read(//file,
     > 4096@0) Jan 13 16:27:23 litos kernel: nfs: read(//file,
     > 4096@17) Jan 13 16:27:23 litos kernel: nfs: flush(b/876609548)
     > Jan 13 16:27:23 litos kernel: NFS: dentry_delete(//file, 0) Jan
     > 13 16:27:24 litos kernel: NFS: refresh_inode(b/876609548 ct=1
     > info=0x2) Jan 13 16:27:24 litos kernel: nfs: read(//file,
     > 4096@0) Jan 13 16:27:24 litos kernel: nfs: read(//file,
     > 4096@17) Jan 13 16:27:24 litos kernel: nfs: flush(b/876609548)
     > Jan 13 16:27:24 litos kernel: NFS: dentry_delete(//file, 0)

     > The partition is mounted with just

     > $ mount server:/db /db

     > Adding a "-o actimeo=100" makes no difference.

     > Is this supposed 1) to be this way, or 2) a bug, or 3) a
     > misconfiguration on my part?

That is quite deliberate.

open() is supposed to generate an RPC call in order to ensure that
cached attributes (and hence cached data) are still valid (this is
part of what is known as NFS 'close-to-open' cache consistency).

If you are certain that you will never access the same file/directory
from 2 different machines, you can try to mount with the 'nocto' mount
option.

Cheers,
  Trond

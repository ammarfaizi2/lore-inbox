Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288955AbSA2JGP>; Tue, 29 Jan 2002 04:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSA2JF5>; Tue, 29 Jan 2002 04:05:57 -0500
Received: from pat.uio.no ([129.240.130.16]:56461 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S288955AbSA2JFh>;
	Tue, 29 Jan 2002 04:05:37 -0500
To: Xeno <xeno@overture.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4: NFS client kmapping across I/O
In-Reply-To: <3C560804.C68BC6F4@overture.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 29 Jan 2002 10:05:31 +0100
In-Reply-To: <3C560804.C68BC6F4@overture.com>
Message-ID: <shshep5wmqs.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == xeno  <xeno@overture.com> writes:

     > Trond, thanks for the excellent fattr race fix.  I'm sorry I
     > haven't been able to give feedback until now, things got busy
     > for a while.  I have not yet had a chance to run your fixes,
     > but after studying them I believe that they will resolve the
     > race nicely, especially with the use of nfs_inode_lock in the
     > recent NFS_ALL experimental patches.  FWIW.

Note: the nfs_inode_lock is not in itself part of any 'fix'. It is
merely a substitute for the current BKL protection of attribute
updates on NFS. The BKL gets dropped from NFS + rpciod in the patch
linux-2.4.x-rpc_bkl.dif which is, of course, included in NFS_ALL.

     > I've also thought about pushing the kmaps and kunmaps down into
     > the RPC layer, so the pages are only mapped while data is
     > copied to or from them, not while waiting for the network.
     > That would be more work, but it looks doable, so I wanted to
     > run the problem and the approach by you knowledgeable folks
     > while I'm waiting for hardware to free up for kernel hacking.

This is the long term solution. We will in any case want to make the
RPC layer 'page aware' in order to be able to make use of the
zero-copy socket stuff (a.k.a. sendpage()).
I'm still not ready to detail exactly how it should be done
though. I'll have to get back to you on this one...

Cheers,
   Trond

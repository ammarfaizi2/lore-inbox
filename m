Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131337AbRBUAz0>; Tue, 20 Feb 2001 19:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131334AbRBUAzG>; Tue, 20 Feb 2001 19:55:06 -0500
Received: from p3EE3C70F.dip.t-dialin.net ([62.227.199.15]:7429 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S131333AbRBUAyz>; Tue, 20 Feb 2001 19:54:55 -0500
Date: Wed, 21 Feb 2001 01:28:42 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.2.x: ReiserFS + NFSv3
Message-ID: <20010221012842.G14837@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current state of ReiserFS + kNFSd for NFS v3 is best described as
"broken", files get unaccessible when accessed across NFS (server logs
ReiserFS warning vs-13048 and cannot itself locally access those files
until the inode cache is flushed), at least for 2.2.18. I have seen that
some people (Neil Brown and Alan Cox among them, apologies to the ones
I missed, it's not meant as offense) have started to discuss the cause
of the problem, which I appreciate.

I cannot currently try 2.4.x on the production machines for various
reasons, one of these being called "vmware 1.x".

As to ReiserFS 3.5 + kNFSd, there have been some patches published
recently in various places to get those two FSs into the same kernel,
like knfsd patches for ReiserFS (originating from Andy Kleen), Chris
Mason's NFS patches, but the list of dependencies for those patches are
so long one and the patches so diverse that it's hardly possible to get
2.2.18 (e.  g.) up and running with ReiserFS AND knfsd v3. 

What I'm after is a single patch for ReiserFS and possibly another patch
to get ReiserFS play nicely with NFSv3, and if these patches require the
VM-global-7 patches by Andrea, that's still fine since these don't
interfere with ReiserFS AFAICS. 

Getting ext3fs and reiserfs into the same kernel is a piece of cake
compared to what seems to be required to get reiserfs and nfsv3 up and
running.

The current 2.2.18 + NFSv3 + ReiserFS is a horrible mess, the track of
recommendations/requirements looks like:

2.2.18 
+ ah's IDE patches (to get AMD Irongate IDE working fast)
+ aa's VM patches (to get the severe bugs out)
+ ReiserFS
+ knfsd-patches for ReiserFS
+ 2.2.19pre7aa1 NFS patches
+ Chris Mason's NFS patches

Heck, when's 2.2.19 released so we have a stable kernel with new VM
that's a base for other file systems to build upon?

Can the NFS and ReiserFS developers, possibly including ext2, xfs, jfs,
ext3 maintainers sit together, find out what the current problem with
knfsd v3 is and go fix it, regardless if it requires changes to the
architectures? If it's broken, it needs fixing, regardless which
version.

Plus, can the 2.2 release cycle please be shortened? I don't see that
2.2.19pre is being frozen, but I see lots of bug fixes going in, and I
cannot see when 2.2.19 is going to be out. You can't expect to get every
possible bug fix in for the next release, there's always one more bug to
fix.


This is a lot of rant and request, which I hope does not contain any
personal offense; since every single person involved and mentioned is
very helpful, but the big picture simply doesn't quite work out :-(



Is there anything which should keep me from switching from ReiserFS
3.5.29 to the latest 0.0.5 series ext3fs? Does knfsd with NFSv3 work out
when served from ext3fs?

-- 
Matthias Andree

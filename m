Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbUKSMsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbUKSMsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbUKSMpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:45:53 -0500
Received: from dp.samba.org ([66.70.73.150]:40380 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261399AbUKSMok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:44:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16797.60034.186288.663343@samba.org>
Date: Fri, 19 Nov 2004 23:43:46 +1100
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <1100865833.6443.17.camel@imp.csi.cam.ac.uk>
References: <16797.41728.984065.479474@samba.org>
	<1100865833.6443.17.camel@imp.csi.cam.ac.uk>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton,

 > Note, that NTFS supports all those things natively on the file system,
 > so it may be worth keeping in mind when designing your APIs.  It would
 > be nice if one day when ntfs write support is finished, when running
 > Samba on an NTFS partition on Linux, Samba can directly access all those
 > things directly from NTFS. 

yes, I have certainly thought about this, and at the core of Samba4 is
a "ntvfs" layer that allows for backends that can take full advantage
of whatever the filesystem can offer. The ntvfs/posix/ code in Samba4
is quite small (currently 7k lines of code) and I'm hoping that more
specialised backends will be written that talk to other types of
filesystems.

To get things started I've also written a "cifs" backend for Samba4,
that uses another CIFS file server as a storage backend, turning
Samba4 into a proxy server. That backend uses the full capabilities of
the ntvfs layer, and implements nearly all of the detailed stuff that
a NTFS can do.

 > I guess a good way would be if your interface is sufficiently
 > abstracted so that it can use xattrs as a backend or a native
 > backend which NTFS could provide for you or Samba could provide for
 > NTFS.  For example NTFS stores the 4 different times in NT format
 > in each inode (base Mft record) so you would not have to take an
 > xattr performance hit there.

The big question is what sort of API would you envisage between user
space and this filesystem? Are you imagining that Samba mmap the raw
disk and use a libntfs library? That would be possible, but would lose
one of the big advantages of Samba, which is that the filesystem is
available to both posix and windows apps.

Or are you thinking that we add a new syscall interface to, a bit like
the IRP stuff in the NT IFS? I imagine there would be quite a bit of
resistance to that in the Linux kernel community :-)

Realistically, I think that in the vast majority of cases Samba is
going to be running on top of "mostly posix" filesystems for the
forseeable future, unless you manage to do something pretty magical
with the ntfs code. But if you do manage to get ntfs in Linux to the
stage where its a viable alternative then I'd be delighted to help
write the Samba4 backend to match.

Cheers, Tridge

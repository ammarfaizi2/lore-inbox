Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265643AbUBJGIt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 01:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265646AbUBJGIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 01:08:49 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:36491 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265643AbUBJGIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 01:08:47 -0500
Date: Mon, 9 Feb 2004 22:08:26 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 4.1GB limit with nfs3, 2.6 & knfsd?
Message-ID: <20040210060826.GH18674@srv-lnx2600.matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040210043926.GG18674@srv-lnx2600.matchmail.com> <20040209215020.60cf2f93.akpm@osdl.org> <16424.29172.314124.933554@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16424.29172.314124.933554@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 04:53:56PM +1100, Neil Brown wrote:
> On Monday February 9, akpm@osdl.org wrote:
> > Mike Fedyk <mfedyk@matchmail.com> wrote:
> > >
> > > Hi,
> > > 
> > > I was trying to tar and bzip2 some directories over the weekend and I think
> > > I may have found a bug.
> > > 
> > > The operation would consistantly fail when the bzip2ed tar file hit 4.1GB
> > > when directed at a 2.6.1-bk2-nfs-stale-file-handles knfsd server from
> > > another computer running the same kernel.
> > > 
> > > If I try the operation against a local filesystem, or a 2.4.24 knfsd server
> > > on the network there are no failures and the file is at 18GB and growing on
> > > the local filesystem (not enough space on the 2.4 server...).
> > > 
> > > This is all from the same nfs client computer.
> > > 
> > > I plan on doing some more tests with dd and cat against the server after the
> > > files have finished compressing.
> > > 
> > > Anyone have any ideas?  I know this could be userspace, but why does it work
> > > against a 2.4 knfsd and on the local filesystem?
> > 
> > Yes, something funny does seem to be happening.
> > 
> > I have a simple NFS mount of an ext2 filesystem via localhost and a 6GB
> > `dd' fails after 4G:
> > 
> > vmm:/mnt/localhost> strace dd if=/dev/zero of=foo bs=1M count=6000
> > ...
> > write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
> > read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
> > write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
> > read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576
> > write(1, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = -1 EINVAL (Invalid argument)
> > 
> 
> This is probably fixed by the following patch that is sitting in my
> queue.
> While 2.4 technically needs the same patch, it isn't affected because
> it completely ignores the "offset", rather than almost-completely
> ignoring it.
> 
> NeilBrown

Would this patch work with 2.6.1-bk2-nfs-stale-file-handles, or does it
depend on any other patches?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbWGTJHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWGTJHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 05:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWGTJHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 05:07:37 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:16272 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S932574AbWGTJHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 05:07:37 -0400
Date: Thu, 20 Jul 2006 11:07:36 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Neil Brown <neilb@suse.de>
Cc: Martin Filip <bugtraq@smoula.net>, David Greaves <david@dgreaves.com>,
       linux-kernel@vger.kernel.org,
       Linux NFS mailing list <nfs@lists.sourceforge.net>
Subject: Re: NFS and partitioned md
Message-ID: <20060720090736.GB1408@janus>
References: <1151355145.4460.16.camel@archon.smoula-in.net> <17568.31894.207153.563590@cse.unsw.edu.au> <1151432312.11996.32.camel@reaver.netbox-in.cz> <17571.19699.980491.970386@cse.unsw.edu.au> <44BD2A29.8060405@dgreaves.com> <1153253099.26360.3.camel@archon.smoula-in.net> <17598.52873.335796.13969@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17598.52873.335796.13969@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2006 at 10:30:01AM +1000, Neil Brown wrote:
> On Tuesday July 18, bugtraq@smoula.net wrote:
> > Hi,
> > 
> > my solution was to use fsid parameter for exports... maybe some other
> > mechanism for selecting fsids could be created instead of fsid = device
> > minor
> 
> Yes.  Better management of fsid is on my wishlist for nfs-utils.
> Unfortunately I haven't had any really clever ideas yet.

I'd like to "virtualize" exports such that it is possible to transplant
disks/partitions from one machine into another without having to bother
with device numbering. One step in that direction is to derive the fsid
from an IP address. The server machine needs an additional IP address
for every export entry. This IP address is determined by deriving
a hostname from the last pathname component of the export entry and
resolving it. E.g. something like:

/etc/exports:
	/exported/path/name	*(rw,sync,no_root_squash,no_subtree_check,fsid="nfs-%s")

This would set the fsid to the IP address of host "nfs-name".

-- 
Frank

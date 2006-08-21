Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751804AbWHUCaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWHUCaW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 22:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWHUCaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 22:30:22 -0400
Received: from cantor2.suse.de ([195.135.220.15]:12683 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751804AbWHUCaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 22:30:22 -0400
From: Neil Brown <neilb@suse.de>
To: Frank van Maarseveen <frankvm@frankvm.com>
Date: Mon, 21 Aug 2006 12:29:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17641.6810.964679.839075@cse.unsw.edu.au>
Cc: Linux NFS mailing list <nfs@lists.sourceforge.net>,
       David Greaves <david@dgreaves.com>, linux-kernel@vger.kernel.org,
       Martin Filip <bugtraq@smoula.net>
Subject: Re: [NFS] NFS and partitioned md
In-Reply-To: message from Frank van Maarseveen on Thursday July 20
References: <1151355145.4460.16.camel@archon.smoula-in.net>
	<17568.31894.207153.563590@cse.unsw.edu.au>
	<1151432312.11996.32.camel@reaver.netbox-in.cz>
	<17571.19699.980491.970386@cse.unsw.edu.au>
	<44BD2A29.8060405@dgreaves.com>
	<1153253099.26360.3.camel@archon.smoula-in.net>
	<17598.52873.335796.13969@cse.unsw.edu.au>
	<20060720090736.GB1408@janus>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday July 20, frankvm@frankvm.com wrote:
> On Thu, Jul 20, 2006 at 10:30:01AM +1000, Neil Brown wrote:
> > On Tuesday July 18, bugtraq@smoula.net wrote:
> > > Hi,
> > > 
> > > my solution was to use fsid parameter for exports... maybe some other
> > > mechanism for selecting fsids could be created instead of fsid = device
> > > minor
> > 
> > Yes.  Better management of fsid is on my wishlist for nfs-utils.
> > Unfortunately I haven't had any really clever ideas yet.
> 
> I'd like to "virtualize" exports such that it is possible to transplant
> disks/partitions from one machine into another without having to bother
> with device numbering. One step in that direction is to derive the fsid
> from an IP address. The server machine needs an additional IP address
> for every export entry. This IP address is determined by deriving
> a hostname from the last pathname component of the export entry and
> resolving it. E.g. something like:
> 
> /etc/exports:
> 	/exported/path/name	*(rw,sync,no_root_squash,no_subtree_check,fsid="nfs-%s")
> 
> This would set the fsid to the IP address of host "nfs-name".

(I'm catching up on only mail - seems I missed this...)

I think that is very specific to your particular setup, but there
certainly is bits of a possibly usable idea in there.

As the fsid is limited in size, we really need some sort of lookup
table somewhere to make between fsid and some arbitrary name for the
filesystem.
You are suggesting using the DNS for this lookup.  
Maybe that make sense..... maybe.

My leaning is to make it somebody-elses-problem by enabling a
call-out.

i.e. we declare a program that will be used for mapping between fsid
and mount point.

So: when parsing /etc/exports, if we find "fsid=??", we run the
program passing the path get an fsid.
When we get a filehandle with an unknown fsid, we pass it to the
program which will return a pathname (possible auto-mounting something
or whatever).

You could quite easily make a script that does the mapping you
require.

Maybe one day...

NeilBrown

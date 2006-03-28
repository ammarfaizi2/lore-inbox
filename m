Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWC1HUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWC1HUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 02:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWC1HUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 02:20:39 -0500
Received: from ns.suse.de ([195.135.220.2]:4283 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932241AbWC1HUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 02:20:38 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: dcache leak in 2.6.16-git8
Date: Tue, 28 Mar 2006 09:15:48 +0200
User-Agent: KMail/1.9.1
Cc: bharata@in.ibm.com, linux-kernel@vger.kernel.org
References: <200603270750.28174.ak@suse.de> <200603271822.28043.ak@suse.de> <20060327190027.24498e3a.akpm@osdl.org>
In-Reply-To: <20060327190027.24498e3a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603280915.48793.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 March 2006 05:00, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > On Monday 27 March 2006 13:48, Bharata B Rao wrote:
> > > On Mon, Mar 27, 2006 at 07:50:20AM +0200, Andi Kleen wrote:
> > > > 
> > > > A 2GB x86-64 desktop system here is currently swapping itself to death after
> > > > a few days uptime.
> > > > 
> > > > Some investigation shows this:
> > > > 
> > > > inode_cache         1287   1337    568    7    1 : tunables   54   27    8 : slabdata    191    191      0
> > > > dentry_cache      1867436 1867643    208   19    1 : tunables  120   60    8 : slabdata  98297  98297      0
> > > > 
> > > 
> > > Would it be possible to try out this experimental patch which
> > > gets some stats from the dentry cache ?
> > 
> > It should be trivial to reproduce by other people. Biggest workload
> > is kernel compiles and quilt.
> > 
> > After a few hours with -git12 it's already at
> > 
> > dentry_cache      947013 952014    208   19    1 : tunables  120   60    8 : slabdata  50100  50106    480
> > 
> > and starting to go into swap.
> > 
> > I can't imagine I'm the only one seeing this?
> > 
> > I have a few x86-64 patches applied too, but they don't change anything
> > in this area.
> 
> I don't think I can reproduce this on x86 uniproc.  (avtab_node_cache
> is a different story - maintainers separately pinged).

This is x86-64 dual core.

> 
> I'd expect pretty much everything we have in there now was under test in
> -mm for quite some time - any obvious leaks would have been noticed.  I'd
> be suspecting recent changes in perhaps audit or nfs, at a guess.  Or
> something weird.
> 
> Which filesystems are in use?

ext3, NFS (not much)

-Andi

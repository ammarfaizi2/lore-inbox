Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVC2A2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVC2A2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 19:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVC2A2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 19:28:51 -0500
Received: from smtp08.web.de ([217.72.192.226]:50576 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S262109AbVC2A2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 19:28:49 -0500
Subject: Re: Kernel OOOPS in 2.6.11.6
From: Ali Akcaagac <aliakc@web.de>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <2cd57c9005032816126557d064@mail.gmail.com>
References: <1112008141.17962.1.camel@localhost>
	 <20050328224430.GO28536@shell0.pdx.osdl.net>
	 <2cd57c9005032814572b7e9bac@mail.gmail.com>
	 <20050328230416.GP30522@shell0.pdx.osdl.net>
	 <2cd57c9005032816126557d064@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 02:28:56 +0200
Message-Id: <1112056136.1849.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 08:12 +0800, Coywolf Qi Hunt wrote:
> > > > with eax == 00000000.  This corresponds to a vp->v_fops (or rather
> > > > vp->v_bh.bh_first->bd_ops) deref.  So, looks like the vnode has a
> > > > NULL v_bh.bh_first (which looks like it's meant to be used to mean
> > > > uninitialized).  May check with XFS folks if they've seen this type
> > > > of bug.
> > >
> > > I think it is f = kmem_cache_alloc(filp_cachep, GFP_KERNEL); returns an
> > > invalid pointer, then in memset(f, 0, sizeof(*f)); fault happens at address f.
> > > eax == 0 is to clear the memory in memset().
> > 
> > The trace indicates it's in linvfs_open
> > (EIP: 0060:[linvfs_open+89/160])
> > and the insturction dump at the end supports that.
> 
> How to explain:
> Call Trace: [get_empty_filp+89/208] get_empty_filp+0x59/0xd0 ?

I like to let you know that this was all I got as dump. Was simply
trying to copy some stuff from A to B on my harddisk using MC on a XFS
partition using 2.6.11.6.

Though I also detected another really strange thing together with this
issue. On a valid XFS partition (no errors or something) I tried to
delete about 160 CVS checked out modules (GNOME) and *buff* stuff
couldn't be deleted anymore but I wasn't aware of this at that moment.
Seconds later I was trying to copy stuff from A to B as described above
and this gave me that hit. Luckely the hit caused let me continue using
the System. I then tried to delete the stuff again and noticed that it
hadn't deleted the CVS checkout in A) properly and that I copied the
undeleted stuff to B) as well. I then inserted my own created rescue CD,
mounted the partition again, and voila was able to delete the stuff
xfs_repair check on it gave no errors or something.

Maybe this helps isolating the issue.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264804AbUDWNaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264804AbUDWNaX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 09:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264807AbUDWNaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 09:30:23 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:5135 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S264804AbUDWNaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 09:30:18 -0400
Date: Fri, 23 Apr 2004 21:33:10 +0800 (WST)
From: raven@themaw.net
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-mm1
In-Reply-To: <20040423131149.B1218@infradead.org>
Message-ID: <Pine.LNX.4.58.0404232125420.5889@donald.themaw.net>
References: <20040421014544.37942eb4.akpm@osdl.org>
 <Pine.LNX.4.58.0404222321310.6767@donald.themaw.net> <20040423131149.B1218@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004, Christoph Hellwig wrote:

> On Thu, Apr 22, 2004 at 11:32:39PM +0800, raven@themaw.net wrote:
> > +static int __may_umount_tree(struct vfsmount *mnt, int root_mnt_only)
> > +{
> > +	struct list_head *next;
> > +	struct vfsmount *this_parent = mnt;
> > +	int actual_refs;
> > +	int minimum_refs;
> > +
> > +	spin_lock(&vfsmount_lock);
> > +	actual_refs = atomic_read(&mnt->mnt_count);
> > +	minimum_refs = 2;
> > +
> > +	if (root_mnt_only) {
> > + 		spin_unlock(&vfsmount_lock);
> > +		if (actual_refs > minimum_refs)
> > +			return -EBUSY;
> > +		return 0;
> 
> Sorry for changing my opionin, but I somehow thought autofs3 could make
> more use of this function.  it it's really just a single atomic_read that's
> shared it doesn't really make a lot of sense, does it?
> 

That's right.

autofs3 requires it to behave as per the little description I put in.

So is the first version what we want?
Should I do a patch which reverts it or should I do a new patch that 
adds the prototype I originally missed?

Be good to clear up what I need to do before I spend more time on it.

Ian


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263229AbUDUPtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbUDUPtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 11:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbUDUPtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 11:49:04 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:55301 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263229AbUDUPtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 11:49:01 -0400
Date: Wed, 21 Apr 2004 23:52:18 +0800 (WST)
From: raven@themaw.net
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc1-mm1
In-Reply-To: <20040421141829.A5551@infradead.org>
Message-ID: <Pine.LNX.4.58.0404212348510.16711@donald.themaw.net>
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419202538.A15701@infradead.org>
 <Pine.LNX.4.58.0404200911090.12229@wombat.indigo.net.au>
 <20040419182657.7870aee9.akpm@osdl.org> <20040421100835.A3577@infradead.org>
 <Pine.LNX.4.58.0404212022370.3740@donald.themaw.net> <20040421141829.A5551@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004, Christoph Hellwig wrote:

> > +
> > +	spin_lock(&vfsmount_lock);
> > +	actual_refs = atomic_read(&mnt->mnt_count);
> > +	minimum_refs = 2;
> > +repeat:
> > +	next = this_parent->mnt_mounts.next;
> > +resume:
> > +	while (next != &this_parent->mnt_mounts) {
> > +		struct vfsmount *p = list_entry(next, struct vfsmount, mnt_child);
> > +
> > +		next = next->next;
> 
> Any chance to use list_for_each_entry here?

It looks to me like this macro can't be used for a tree traversal.
Please enlighten me if I'm wrong.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUBLBTI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 20:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUBLBTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 20:19:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:9664 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265772AbUBLBTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 20:19:04 -0500
Date: Wed, 11 Feb 2004 17:20:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: thockin@sun.com
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: PATCH - raise max_anon limit
Message-Id: <20040211172046.37e18a2f.akpm@osdl.org>
In-Reply-To: <20040212010822.GP9155@sun.com>
References: <20040211203306.GI9155@sun.com>
	<Pine.LNX.4.58.0402111236460.2128@home.osdl.org>
	<20040211210930.GJ9155@sun.com>
	<20040211135325.7b4b5020.akpm@osdl.org>
	<20040211222849.GL9155@sun.com>
	<20040211144844.0e4a2888.akpm@osdl.org>
	<20040211233852.GN9155@sun.com>
	<20040211155754.5068332c.akpm@osdl.org>
	<20040212003840.GO9155@sun.com>
	<20040211164233.5f233595.akpm@osdl.org>
	<20040212010822.GP9155@sun.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@sun.com> wrote:
>
> On Wed, Feb 11, 2004 at 04:42:33PM -0800, Andrew Morton wrote:
> On Wed, Feb 11, 2004 at 04:42:33PM -0800, Andrew Morton wrote:
> > > Indeed.  MKDEV() already masks off the high order stuff, so that is OK.
> >_
> > That means that we've lost the original idr key and can no longer remove
> > the thing, doesn't it?
> 
> No, it doesn't store the counter with the id.  They expect you to do that.
> My best understanding is that thi sis to prevent re-use of the same key.
> I'm not sure I grok why it is useful.  If you release a key, it should be
> safe to reuse.  Period.  I assume there was some use case that brought about
> this "feature" but if so, I don't know what it is.  The big comment about it
> is just confusing me.

Maybe Jim can tell us why it's there.  Certainly, the idr interface would
be more useful if it just returned id's which start from zero.


> > > On idr_get_new(), we can just check for
> > > 	dev & ((1<<MINORBITS)-1) == (1<<MINORBITS)-1)
> > > and return -EMFILE.
> > >_
> > > That combined with a gfp mask to idr and the assumption that idr's
> > > counter
> > > won't ever grow beyond (sizeof(int)*8 - MINORBITS) (12) bits
> > >_
> > > Shall I whip that up and test it?  Do you prefer a gfp mask to idr_init
> > > that
> > > sticks around for all allocations or a GFP mask to idr_pre_get?
> 
> Offer repeated. :)

Please.

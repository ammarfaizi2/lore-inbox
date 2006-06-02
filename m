Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWFBThG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWFBThG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWFBThG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:37:06 -0400
Received: from ns2.suse.de ([195.135.220.15]:35035 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932321AbWFBThE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:37:04 -0400
Date: Fri, 2 Jun 2006 21:37:02 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060602193702.GA9888@suse.de>
References: <20060529214011.GA417@suse.de> <20060530182453.GA8701@suse.de> <20060601184938.GA31376@suse.de> <20060601121200.457c0335.akpm@osdl.org> <20060601201050.GA32221@suse.de> <20060601142400.1352f903.akpm@osdl.org> <20060601214158.GA438@suse.de> <20060601145747.274df976.akpm@osdl.org> <20060602084327.GA3964@suse.de> <20060602021115.e42ad5dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060602021115.e42ad5dd.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Jun 02, Andrew Morton wrote:

> On Fri, 2 Jun 2006 10:43:27 +0200
> Olaf Hering <olh@suse.de> wrote:
> 
> >  On Thu, Jun 01, Andrew Morton wrote:
> > 
> > 
> > > > Do you want it like that?
> > > > 
> > > > lock_page(page);
> > > > if (PageUptodate(page)) {
> > > >         SetPageDirty(page);
> > > >         mb();
> > > >         return page;
> > > > }
> > > 
> > > Not really ;)  It's hacky.  It'd be better to take a lock.
> > 
> > Which lock exactly?
> 
> Ah, sorry, there isn't such a lock.  I was just carrying on.
> 
> > I'm not sure how to proceed from here.
> 
> I'd suggest you run SetPagePrivate() and SetPageChecked() on the locked
> page and implement a_ops.releasepage(), which will fail if PageChecked(),
> and will succeed otherwise:

No leak without tweaking PG_private.

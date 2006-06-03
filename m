Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWFCNNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWFCNNU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 09:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWFCNNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 09:13:20 -0400
Received: from ns1.suse.de ([195.135.220.2]:50921 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750785AbWFCNNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 09:13:20 -0400
Date: Sat, 3 Jun 2006 15:13:15 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060603131315.GA16173@suse.de>
References: <20060601184938.GA31376@suse.de> <20060601121200.457c0335.akpm@osdl.org> <20060601201050.GA32221@suse.de> <20060601142400.1352f903.akpm@osdl.org> <20060601214158.GA438@suse.de> <20060601145747.274df976.akpm@osdl.org> <20060602084327.GA3964@suse.de> <20060602021115.e42ad5dd.akpm@osdl.org> <20060602193702.GA9888@suse.de> <20060602124635.2d7a1d96.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060602124635.2d7a1d96.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Jun 02, Andrew Morton wrote:

> On Fri, 2 Jun 2006 21:37:02 +0200
> Olaf Hering <olh@suse.de> wrote:
> 
> > > I'd suggest you run SetPagePrivate() and SetPageChecked() on the locked
> > > page and implement a_ops.releasepage(), which will fail if PageChecked(),
> > > and will succeed otherwise:
> > 
> > No leak without tweaking PG_private.
> 
> Odd.  That would imply that PG_private is being left set somehow (it will
> make the page unreclaimable).  But I don't see it.
> 
> Plus if we have lots of PagePrivate() pages floating about you should see
> your ->releasepage() being called.

The change from Chris leaks as well, but very very slowly.

Please wait while I dig into the page states...

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUAERoB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUAERoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:44:00 -0500
Received: from intra.cyclades.com ([64.186.161.6]:17840 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265225AbUAERlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:41:47 -0500
Date: Mon, 5 Jan 2004 15:32:57 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Alex Buell <alex.buell@munted.org.uk>, linux-kernel@vger.kernel.org,
       riel@redhat.com, arjanv@redhat.com
Subject: Re: inode_cache / dentry_cache not being reclaimed aggressively
 enough  on low-memory PCs
In-Reply-To: <20040104072312.GM1882@matchmail.com>
Message-ID: <Pine.LNX.4.58L.0401051531040.5618@logos.cnet>
References: <Pine.LNX.4.58.0401031128100.2605@slut.local.munted.org.uk>
 <20040103103023.77bf91b5.jlash@speakeasy.net> <20040103145557.369a12c4.akpm@osdl.org>
 <Pine.LNX.4.58.0401040014360.4975@slut.local.munted.org.uk>
 <20040103190543.3b2d917f.akpm@osdl.org> <20040104072312.GM1882@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Jan 2004, Mike Fedyk wrote:

> On Sat, Jan 03, 2004 at 07:05:43PM -0800, Andrew Morton wrote:
> > Alex Buell <alex.buell@munted.org.uk> wrote:
> > >
> > > On Sat, 3 Jan 2004, Andrew Morton wrote:
> > >
> > > > John Lash <jlash@speakeasy.net> wrote:
> > > > >
> > > > > As it stands, it will maintain as many unused entries as there are used entries.
> > > > >  If this low memory system las a large, stable, number of inuse dentry objects,
> > > > >  the unused entries will match it thereby holding double the memory and possibly
> > > > >  causing the problem you see.
> > > >
> > > > Yup.   There is a fix in 2.6.1-rc1 for this.
> > >
> > > Which change would that be? It would be nice to back-port that to 2.4.x if
> > > that's possible?
> >
> > It is not backportable.
> >
> > You could try increasing `count' in shrink_dcache_memory() and
> > shrink_icache_memory().  Also you should be using 2.4.23 or later because
> > it does have improvements in the memory reclaim area.
>
> Also, if there are any improvements considered for the 2.4 VM, it should be
> on top of the -aa series.  That's where the latest updates are, and it
> doesn't make sence to work from a base that already has seperate
> improvements available.

The fix in -aa seems to reclaim inodes very aggressively. The 2.4 RH tree
seems to contain a better version. Need to look into that.

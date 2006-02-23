Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWBWXoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWBWXoa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWBWXoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:44:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62893 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932130AbWBWXo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:44:29 -0500
Date: Fri, 24 Feb 2006 00:44:03 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060223234403.GF1662@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602232337.31075.rjw@sisk.pl> <20060223230439.GC1662@elf.ucw.cz> <200602240927.51338.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602240927.51338.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > [Because pagecache is freeable, anyway, so it will be freed. Now... I
> > > > have seen some problems where free_some_memory did not free enough,
> > > > and schedule()/retry helped a bit... that probably should be fixed.]
> > >
> > > It seems I need to understand correctly what the difference between what
> > > we do and what Nigel does is.  I thought the Nigel's approach was to save
> > > some cache pages to disk first and use the memory occupied by them to
> > > store the image data.  If so, is the page cache involved in that or
> > > something else?
> >
> > I believe Nigel only saves pages that could have been freed anyway
> > during phase1. Nigel, correct me here... suspend2 should work on same
> > class of machines swsusp can, but will be able to save caches on
> > machines where swsusp can not save any.
> 
> I'm not used to thinking in these terms :). It would be normally be right, 
> except that there will be some LRU pages that will never be freed. These 
> would allow suspend2 to work in some (not many) cases where swsusp can't. 
> It's been ages since I did the intensive testing on the image preparation 
> code, but I think that if we free as much memory as we can, we will always 
> still have at least a few hundred LRU pages left. That's not much, but on 
> machines with less ram, it might make the difference in a greater percentage 
> of cases (compared to machines with more ram)?

Well, pages in LRU should be user pages, and therefore freeable,
AFAICT. It is possible that there's something wrong with freeing in
swsusp1...
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...

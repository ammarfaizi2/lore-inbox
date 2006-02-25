Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWBYArN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWBYArN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWBYArN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:47:13 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51102 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964825AbWBYArM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:47:12 -0500
Date: Sat, 25 Feb 2006 01:46:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060225004637.GF1930@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602250911.54850.ncunningham@cyclades.com> <200602250120.39936.rjw@sisk.pl> <200602251026.21441.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602251026.21441.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 25-02-06 10:26:17, Nigel Cunningham wrote:
> Hi.
> 
> On Saturday 25 February 2006 10:20, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Saturday 25 February 2006 00:11, Nigel Cunningham wrote:
> > > On Saturday 25 February 2006 06:22, Rafael J. Wysocki wrote:
> > > > On Friday 24 February 2006 14:12, Pavel Machek wrote:
> > > > > On Pá 24-02-06 11:58:07, Rafael J. Wysocki wrote:

> > > I mean, that only means that the poor system has more pages to fault back
> > > in at resume time, before the user can even begin to think about doing
> > > anything useful.
> >
> > Well, that's not the only possibility.  After we fix the memory freeing
> > issue we can use the observation that page cache pages need not be saved to
> > disk during suspend, because they already are in a storage.  We only need
> > to create a map of these pages during suspend with the information on where
> > to get them from and prefetch them into memory during resume independently
> > of the page fault mechanism.
> >
> > This way we won't have to actually save anything before we snapshot the
> > system and the system should be reasonably responsive after resume.
> 
> But this is going to be much more complicated than simply saving the pages in 
> the first place. You'll need some mechanism for figuring out what pages to 
> get, how to fault them in, etc. In addition, it will be much slower than 
> simply reading them back from (ideally) contiguous storage.

It will not be *much* slower. You gain some speed by not having to
write anything, too. And done properly, it is going to be simple. Lets
see what Rafael comes up with.

[Big advantage is that /proc/list-me-pagecache can be implemented
without any dependencies on the rest of swsusp code, and is likely to
be useful for speeding up boot, etc.]
									Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422681AbWA0XXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbWA0XXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422684AbWA0XXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:23:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35795 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422682AbWA0XXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:23:02 -0500
Date: Sat, 28 Jan 2006 00:22:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [ 00/23] [Suspend2] Freezer Upgrade Patches
Message-ID: <20060127232251.GC1617@elf.ucw.cz>
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <200601271404.08680.nigel@suspend2.net> <200601271318.01985.rjw@sisk.pl> <200601280520.28816.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601280520.28816.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 28-01-06 05:20:28, Nigel Cunningham wrote:
> Hi.
> 
> On Friday 27 January 2006 22:18, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Friday, 27 January 2006 05:04, Nigel Cunningham wrote:
> > > On Friday 27 January 2006 09:10, Rafael J. Wysocki wrote:
> > > > On Thursday, 26 January 2006 04:45, Nigel Cunningham wrote:
> > > > > Hi everyone.
> > > > >
> > > > > This set of patches represents the freezer upgrade patches from
> > > > > Suspend2.
> > > > >
> > > > > The key features of this changeset are:
> > > > >
> > > > > - Use of Christoph Lameter's todo list notifiers, which help with SMP
> > > > >   cleanness.
> > > > > - Splitting the freezing of kernel and userspace processes. Freezing
> > > > >   currently suffers from a race because userspace processes can be
> > > > >   submitting work for kernel threads, thereby stopping them from
> > > > >   responding to freeze messages in a timely manner. The freezer can
> > > > >   thus give up when it doesn't really need to. (This is not normally
> > > > >   a problem only because load is not usually high).
> > > >
> > > > Could you please describe specific situation?
> > >
> > > The simplest example would be:
> > >
> > > dd if=/dev/hda of=/dev/null
> > > echo disk > /sys/power/state
> >
> > Well, I don't think it's a usual kind of workload. :-)
> 
> No, but I/O alone shouldn't have such effect.
> 
> > Anyway, could you please give some details?  I mean how exactly your patch
> > helps in this particular case?
> 
> I thought I did :). Freezing userspace first means the dd thread gets stopped 
> first. Once the dd thread is stopped, the kernel threads processing the I/O 
> requests have a finite amount of work to do (instead of having new work being 
> submitted all the time), and can thus complete that and then be frozen in a 
> far more deterministic fashion.
> 
> Regarding the stats I promised to Pavel, I'm heading home from LCA today, so I 
> probably won't get them prepared until Monday now - unless I get lazy and 
> only do 10 attempts instead of 100 :)

You could swapoff -a to make your cycle a lot faster.... Freezing is
still done in that case, IIRC.
								Pavel
-- 
Thanks, Sharp!

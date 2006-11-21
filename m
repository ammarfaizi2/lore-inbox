Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030613AbWKUAv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030613AbWKUAv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 19:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbWKUAvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 19:51:55 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:60044 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030613AbWKUAvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 19:51:54 -0500
Subject: Re: [PATCH -mm 0/2] Use freezeable workqueues to avoid
	suspend-related XFS corruptions
From: Nigel Cunningham <nigelc@bur.st>
Reply-To: nigelc@bur.st
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Chinner <dgc@sgi.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200611202355.50487.rjw@sisk.pl>
References: <200611160912.51226.rjw@sisk.pl>
	 <1164061586.15714.1.camel@nigel.suspend2.net>
	 <1164062390.15714.5.camel@nigel.suspend2.net>
	 <200611202355.50487.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 11:51:50 +1100
Message-Id: <1164070310.15714.15.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-11-20 at 23:55 +0100, Rafael J. Wysocki wrote:
> On Monday, 20 November 2006 23:39, Nigel Cunningham wrote:
> > (Sorry to reply again)
> 
> (No big deal)
> 
> > On Tue, 2006-11-21 at 09:26 +1100, Nigel Cunningham wrote:
> > > Hi.
> > > 
> > > On Mon, 2006-11-20 at 23:18 +0100, Rafael J. Wysocki wrote:
> > > > I think I/O can only be submitted from the process context.  Thus if we freeze
> > > > all (and I mean _all_) threads that are used by filesystems, including worker
> > > > threads, we should effectively prevent fs-related I/O from being submitted
> > > > after tasks have been frozen.
> > > 
> > > I know that will work. It's what I used to do before the switch to bdev
> > > freezing. I guess I need to look again at why I made the switch. Perhaps
> > > it was just because you guys gave freezing kthreads a bad wrap as too
> > > invasive or something. Bdev freezing is certainly fewer lines of code.
> > 
> > No, it looks like I wrongly believed that XFS was submitting I/O off a
> > timer, so that freezing kthreads wasn't enough. In that case, it looks
> > like freezing kthreads should be a good solution.
> 
> Okay, so let's implement it. :-)

Agreed. I'm a bit confused now about what the latest version of your
patches is, but I'll be happy to switch back to kthread freezing in the
next Suspend2 release if it will help with getting them wider testing.

Nigel


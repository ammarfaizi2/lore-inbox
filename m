Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUEKMWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUEKMWC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbUEKMWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:22:02 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:63904
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S263040AbUEKMVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:21:54 -0400
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
From: John McCutchan <ttb@tentacle.dhs.org>
To: nf2@scheinwelt.at
Cc: Chris Wedgwood <cw@f00f.org>, nautilus-list@gnome.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1084276364.4081.63.camel@lilota.lamp.priv>
References: <1084152941.22837.21.camel@vertex>
	 <20040510021141.GA10760@taniwha.stupidest.org>
	 <1084227460.28663.8.camel@vertex>
	 <20040511024701.GA19489@taniwha.stupidest.org>
	 <1084276364.4081.63.camel@lilota.lamp.priv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1084278281.1225.15.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 May 2004 08:24:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 07:52, nf wrote:
> On Tue, 2004-05-11 at 04:47, Chris Wedgwood wrote: 
> > On Mon, May 10, 2004 at 06:17:40PM -0400, John McCutchan wrote:
> > 
> > > According to everyone who uses dnotify it is.
> > 
> > I don't buy that.  I have used dnotify and signals where not an issue.
> > Why is this an issue for others?
> 
> I believe the worst thing about dnotify is the "umount blocking"
> behaviour. It drives me crazy since i use the Linux desktop. So if this
> is the "Year of the linux desktop", please please switch OFF dnotify
> until it does not open files for monitoring anymore! Or until "inotify"
> works.
> 
> Btw, i have written a little tool to assist people with the
> umount-problem and collected some links
> http://www.scheinwelt.at/~norbertf/wbumount/. 

That will be fixed with inotify.

> 
> > > The idea is to encourage use of a user-space daemon that will
> > > multiplex all requests, so if 5 people want to watch /somedir the
> > > daemon will only use one watcher in the kernel. The number might be
> > > too low, but its easily upped.
> > 
> > If you are to use a daemon for this, why no use dnotify?
> 
> I don't understand, why the author of inotify wants to force people to
> use user-space daemons like fam (which requires xinetd, ...)? Does using
> a daemon for multiplexing really add efficiency? Is it really worth
> adding all the complexity of things like "fam" to the system, just
> because more than one application monitor the same directory once in a
> while? I doubt it.
> 

I doesn't have to be fam. I am not sure if having a daemon is the best
way to go either, but I think that having a daemon (not necessarily fam)
could be beneficial. Beyond multiplexing you could keep a buffer of
events and try and combine some events before sending them to the apps.
But if it turns out that a daemon is not the best way, we can adjust the
limits set on the driver and everyone can just use it directly. So relax
I am not trying to force anything, it was just an idea.

John

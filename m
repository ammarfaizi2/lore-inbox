Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269411AbUJLDDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269411AbUJLDDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 23:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269418AbUJLDDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 23:03:47 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:65421 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S269411AbUJLDDk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 23:03:40 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Totally broken PCI PM calls
Date: Mon, 11 Oct 2004 20:00:53 -0700
User-Agent: KMail/1.6.2
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
References: <1097455528.25489.9.camel@gaston> <200410111758.48441.dtor_core@ameritech.net> <1097536131.13795.40.camel@gaston>
In-Reply-To: <1097536131.13795.40.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410112000.53814.david-b@pacbell.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 October 2004 4:08 pm, Benjamin Herrenschmidt wrote:
> On Tue, 2004-10-12 at 08:58, Dmitry Torokhov wrote:
> 
> > Yes, I think that devices that failed to resume (and all their children)
> > have to be moved by the core resume function into a separate list and
> > then destroyed (again by the driver core). 

OHCI has to do this when the controller loses power during suspend;
which includes many suspend-to-disk cases.  It marks the devices dead,
kills the I/O queues, and then makes khubd do all the work.


> > For that we might need to add 
> > bus_type->remove_device() handler as it seems that all buses do alot
> > of work outside of driver->remove handlers. The remove_device should
> > accept additional argument - something like dead_device that would
> > suggest that driver should not be alarmed by any errors during unbind/
> > removal process as the device (or rather usually its parent) is simply
> > not there anynore.
> 
> They already do... think USB...

USB decided against the extra argument; drivers don't much care
at that point.  And anyway, they can tell the device is gone by looking
at status codes returned by URB completion or submission.

- Dave


> Ben.
> 
> 
> 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbVCDR5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVCDR5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVCDRzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:55:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:18098 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263009AbVCDRyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:54:08 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Date: Fri, 4 Mar 2005 09:50:03 -0800
User-Agent: KMail/1.7.2
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
References: <422428EC.3090905@jp.fujitsu.com> <200503010910.29460.jbarnes@engr.sgi.com> <20050304135429.GC3485@openzaurus.ucw.cz>
In-Reply-To: <20050304135429.GC3485@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503040950.03866.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 4, 2005 5:54 am, Pavel Machek wrote:
> Hi!
>
> > > If there's no ->error method, at leat call ->remove so one device only
> > > takes itself down.
> > >
> > > Does this make sense?
> >
> > This was my thought too last time we had this discussion.  A completely
> > asynchronous call is probably needed in addition to Hidetoshi's proposed
> > API, since as you point out, the driver may not be running when an error
> > occurs (e.g. in the case of a DMA error or more general bus problem). 
> > The async
>
> Hmm, before we go async way (nasty locking, no?) could driver simply
> ask "did something bad happen while I was sleeping?" at begining of each
> function?

This is what Seto is proposing, aiui.  I.e. calls around I/O so you can 
gracefully handle errors during that I/O.

> For DMA problems, driver probably has its own, timer-based,
> "something is wrong" timer, anyway, no?

The idea is to allow them to do something like that, or consolidate such 
threads in a platform specific error handling thread or interrupt handler 
that can call a driver's ->dma_error(dev) routine (or ->error(dev, ERROR_DMA) 
or whatever) routine.

Jesse

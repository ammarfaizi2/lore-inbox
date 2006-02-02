Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWBBXPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWBBXPW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWBBXPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:15:21 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:47765 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751185AbWBBXPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:15:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Thu, 2 Feb 2006 23:10:40 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602021353.30802.rjw@sisk.pl> <200602030727.48855.nigel@suspend2.net>
In-Reply-To: <200602030727.48855.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602022310.40783.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 02 February 2006 22:27, Nigel Cunningham wrote:
> On Thursday 02 February 2006 22:53, Rafael J. Wysocki wrote:
> > On Thursday 02 February 2006 10:38, Pavel Machek wrote:
> > > > Its limitation , however, is that it requires a lot of memory for the
> > > > system memory snapshot which may be impractical for systems with
> > > > limited RAM, and that's where your solution may be required.
> > >
> > > Actually, suspend2 has similar limitation. It still needs half a
> > > memory free, but it does not count caches into that as it can save
> > > them separately.
> >
> > I didn't know that.  [If that is the case, I wonder what Nigel means by
> > the "whole memory image".  Nigel?]
> 
> The LRU almost always easily accounts for more 50% of memory in use. Suspend2 
> writes LRU pages to disk, then uses those pages to store the atomic copy of 
> the remainder of memory. That's how I overcome the 50% problem and still 
> really do get a full image of memory. If the LRU is smaller than the 
> remainder of memory in use, we allocate extra memory if possible. If that 
> still doesn't give enough memory for the atomic copy, we seek to free memory 
> until that constraint is satisfied. If we free everything we can, and still 
> can't satisfy that constraint, we give up and return control to the user. In 
> 99% of the cases, however, no freeing of memory is required and the user 
> really can get a full image of memory saved.

Now that's clear to me.  Thanks for the explanation.

> > > That means that on certain small systems (32MB RAM?), suspend2 is going
> > > to have big advantage of responsivity after resume. But on the systems
> > > where [u]swsusp can't suspend (6MB RAM?), suspend2 is not going to be
> > > able to suspend, either. [Roughly; due to bugs and implementation
> > > differences there may be some system size where one works and second one
> > > does not, but they are pretty similar]
> >
> > Generally speaking, my perception is that suspend2 may be preferrable below
> > 256 MB of RAM.  Moreover there are some people who seem to prefer
> > entirely kernel-based suspend, and I'm not going to develop the code
> > in swap.c and disk.c any further (of course with the exception of bugfixes
> > etc.).  Nigel has done it already so perhaps there is a room for his code,
> > too, _provided_ _that_ it is accepted.
> 
> All of the machines I regularly use have 512M+ of memory. Suspend2 is 
> definitely preferable on them because I've worked hard to maximise I/O 
> throughput. Last time I measured swsusp throughput, it was 16MB/s on my old 
> Omnibook. Suspend2 achieved ~25MB writing and 50MB/s reading when using LZF 
> compression (933 Celeron), or the 35MB/s uncompressed (the maximum throughput 
> that could be achieved according to tools like hdparm -t) on the same system. 
> With the same drive in my new laptop (amd64 M34), I get ~70MB/s read/write 
> (depending on cpufreq settings). My 3G P4s at work and home do about 70
> (w)/110(r) MB/s. (All of this is using LZF compression).

I was referring to the (not so far) future situation when we have compression
in the userland suspend/resume utilities.  The times of writing/reading the image
will be similar to yours and IMHO it's usually possible to free 1/2 of RAM
in a box with 512+ MB of RAM at a little cost as far as the responsiveness
after resume is concerned.  Thus on machines with 512+ MB of RAM
both solutions will give similar results performance-wise, but the
userland-driven suspend gives you much more flexibility wrt what you can
do with the image (eg. you can even send it over the network if need be).

On machines with less RAM suspend2 will probably be better preformance-wise,
and that may be more important than the flexibility.

Greetings,
Rafael


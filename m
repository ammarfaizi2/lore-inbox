Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVEaJgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVEaJgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 05:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVEaJgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 05:36:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:6797 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261613AbVEaJfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 05:35:14 -0400
Date: Tue, 31 May 2005 11:35:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: randy_dunlap <rdunlap@xenotime.net>
cc: viro@parcelfarce.linux.theplanet.co.uk, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Subject: Re: more thread_info patches
In-Reply-To: <20050530182511.434b0e97.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0505311127330.3728@scrub.home>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
 <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be>
 <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
 <20050421173908.GZ13052@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.61.0505310113370.10977@scrub.home> <20050530182511.434b0e97.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 30 May 2005, randy_dunlap wrote:

> | Index: linux-2.6-mm/include/linux/sched.h
> | ===================================================================
> | --- linux-2.6-mm.orig/include/linux/sched.h	2005-05-31 01:19:01.636591190 +0200
> | +++ linux-2.6-mm/include/linux/sched.h	2005-05-31 01:19:05.913856451 +0200
> | @@ -617,6 +617,7 @@ struct mempolicy;
> |  struct task_struct {
> |  	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
> |  	struct thread_info *thread_info;
> | +	void *stack;
> 
> Any reason this is void * instead of being more strongly typed?
> Does the actual type vary?

Yes, on m68k it actually doesn't point to the thread_info at all.
The point of these patches are to allow archs to put the thread_info 
structure somewhere else. Archs with a thread register can keep 
task_struct and thread_info together and directly accessable via the 
thread register. Only because i386 has no usable thread register, doesn't 
mean everyone else has to suffer.

> And a general comments about the 4 emails:
> they all have the same subject.  :(

I know and I did this intentionally, as these patches were not intended to 
be applied, they are based on Al's patches and even these aren't in -mm 
yet. I maybe should have added a [RFC].

bye, Roman

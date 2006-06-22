Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161185AbWFVSgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWFVSgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbWFVSgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:36:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:64430 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161173AbWFVSgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:36:48 -0400
Date: Thu, 22 Jun 2006 11:35:08 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pavel Machek <pavel@suse.cz>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, ntl@pobox.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com,
       ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
In-Reply-To: <20060622182231.GC4193@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0606221132040.30182@schroedinger.engr.sgi.com>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
 <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain>
 <20060622084513.4717835e.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com>
 <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com>
 <20060622092422.256d6692.rdunlap@xenotime.net> <20060622182231.GC4193@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Pavel Machek wrote:

> > > Hm..
> > > Then, there is several ways to manage this sitation.
> > > 
> > > 1. migrate all even if it's not allowed by users
> 
> That's what I'd prefer... as swsusp uses cpu hotplug. All the other
> options are bad... admin will probably not realize suspend involves
> cpu unplugs..

You probably first suspend a process? If a process was suspended by 
swsusp then we can just ignore the restriction because it will be 
returned later.

The admin wants the system to behave in a consistent way. If he suddenly 
finds a process running on a cpu that was forbidden then that is weird 
and surprising to say the least and may go undetected for a long time.
If the process gets killed when he disables the cpu then he will have to 
fix up his cpu restrictions.




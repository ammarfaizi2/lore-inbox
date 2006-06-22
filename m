Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWFVREy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWFVREy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWFVREy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:04:54 -0400
Received: from rune.pobox.com ([208.210.124.79]:25235 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S932550AbWFVREw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:04:52 -0400
Date: Thu, 22 Jun 2006 12:04:31 -0500
From: Nathan Lynch <ntl@pobox.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, clameter@sgi.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com,
       pavel@ucw.cz, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
Message-ID: <20060622170431.GM16029@localdomain>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com> <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain> <20060622084513.4717835e.rdunlap@xenotime.net> <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com> <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com> <20060622092422.256d6692.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622092422.256d6692.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Fri, 23 Jun 2006 01:05:50 +0900 KAMEZAWA Hiroyuki wrote:
> 
> > On Thu, 22 Jun 2006 08:45:55 -0700 (PDT)
> > Christoph Lameter <clameter@sgi.com> wrote:
> > 
> > > On Thu, 22 Jun 2006, Randy.Dunlap wrote:
> > > 
> > > > Sounds much better than just killing the process.
> > > 
> > > Right and having active interrupts or devices using that processor should 
> > > also stop offlining a processor.
> > > 
> > > So just remove everything from a processor before offlining. If you cannot 
> > > remove all users then the processor cannot be offlined.
> > > 
> > Hm..
> > Then, there is several ways to manage this sitation.
> > 
> > 1. migrate all even if it's not allowed by users
> > 2. kill mis-configured tasks.
> 
> I would claim that the tasks are not misconfigured,
> but that the admin misconfigured the hardware (CPU).
> 
> > 3. stop ...
> > 4. cancel cpu-hot-removal.
> > 
> > I just don't like "1". 
> 
> I like it better than 2.
> 
> > I discussed this problem with my colleagues before sending patch,
> > one said "4" seems regular way but another said "4" is bad.
> > 
> > I sent a patch for "4" in the first place but Andi Kleen said it's bad.
> > As he said, I'm handling the problem for which I can't find a good answer :(
> > 
> > my point is that "1" is bad.
> 
> Sounds like we are getting nowhere.  The sysctl knob might
> have to be the answer.

I don't like having the kernel forcibly kill or stop tasks for this
case, regardless of whether the behavior is configurable.  What I
originally meant to suggest was a sysctl knob which will control
whether the offline will fail in this situation.  But I'm still more
inclined to leave the kernel's handling of this as it stands, since
this is policy that can be implemented in userspace.

We need to preserve the current behavior as the default, in any case.


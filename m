Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263243AbUCNBI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 20:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbUCNBI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 20:08:26 -0500
Received: from nils.bezeqint.net ([192.115.104.5]:9417 "EHLO nils.bezeqint.net")
	by vger.kernel.org with ESMTP id S263243AbUCNBIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 20:08:17 -0500
Date: Sun, 14 Mar 2004 03:07:30 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040314010730.GM5960@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com> <20040313221018.GE5960@luna.mooo.com> <1079217685.4915.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079217685.4915.2.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 11:41:25PM +0100, Arjan van de Ven wrote:
> On Sat, 2004-03-13 at 23:10, Micha Feigin wrote:
> > On Sat, Mar 13, 2004 at 06:24:31PM +0100, Arjan van de Ven wrote:
> > > On Thu, 2004-03-11 at 15:17, Micha Feigin wrote:
> > > > Is it possible to find out what the kernel's notion of HZ is from user
> > > > space?
> > > > It seem to change from system to system and between 2.4 (100 on i386)
> > > > to 2.6 (1000 on i386).
> > > 
> > > if you can see 1000 from userspace that is a bad kernel bug; can you say
> > > where you find something in units of 1000 ?
> > 
> > I can't see it from user space. Its in the kernel headers. The thing is
> > I am working on fixes to laptop mode. The problem is it requires
> > changing bdflush and journaled file systems journal flush times. The
> > problem is that some of these (bdflush, xfs) expect the value in jiffies
> > and not seconds or milliseconds so making the initiation script portable
> > requires knowing the value of HZ.
> 
> the kernel side is supposed to use clock_t_to_jiffies() and co for this
> to present a unified HZ to userspace. The internal kernel HZ should
> *NOT* leak out to usespace. Heck it's quite thinkable that in the future
> there will be no such HZ.
>  
> 

Kernel side doesn't do that at the moment. Even the fixed bdflush
interface in 2.6 which has dirty_writeback_centisecs as an example
converts it as
(dirty_writeback_centisecs * HZ) / 100

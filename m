Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTDONPy (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbTDONPx 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:15:53 -0400
Received: from galileo.bork.org ([66.11.174.148]:18445 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261364AbTDONPv 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 09:15:51 -0400
Date: Tue, 15 Apr 2003 09:27:41 -0400
From: Martin Hicks <mort@wildopensource.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Martin Hicks <mort@wildopensource.com>,
       hpa@zytor.com, pavel@ucw.cz, jes@wildopensource.com,
       linux-kernel@vger.kernel.org, wildos@sgi.com
Subject: Re: [patch] printk subsystems
Message-ID: <20030415132741.GR3413@bork.org>
References: <20030408161010.25de9e09.rddunlap@osdl.org> <Pine.LNX.4.44.0304141325010.14087-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304141325010.14087-100000@cherise>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Apr 14, 2003 at 01:33:54PM -0500, Patrick Mochel wrote:
> 
> > I don't like the #define DEBUG approach.  It's useless for users; it's a
> > developer debug tool.  It won't allow some support staff to ask users to
> > enable module debugging (or subsystem debugging) and see what gets printed.
> 
> Agreed. Having a runtime-tweakable field would be very handy, and 
> something that's been requested many times over. 
> 
> > Martin, you are ahead of my schedule, but I was planning to use sysfs
> > to add a 'debug' flag/file that could be dynamically altered on a per-module
> > basis.
> 
> Something I've pondered in the past is a per-subsystem (as in struct 
> subsystem) debug field and log buffer. When the subsystem is registered, a 
> sysfs 'debug' file is created, from which the user can set the noisiness 
> level. 
> 
> >From there, each subsystem can specify the size of a log buffer, which 
> would be allocated also when the subsystem is registered. Messages from 
> the subsystem, and kobjects belonging to it, would be copied into the 
> local log buffer. 
> 
> Wrapper functions can be created, similar to the dev_* functions, which 
> take a kobject as the first parameter. From this, the subsystem and log 
> buffer, can be derived (or rather, passed to a lower-level helper). 
> 
> This all falls under the 'gee-whiz-this-might-be-neat' category, and may
> inherently suck; I haven't tried it. Doing the core code is < 1 day's
> work, though there would be nothing that actually used it..

I'm not sure that this addresses the core problem that I'm trying to
deal with.  The problem is that machines with certain configurations
(large number of CPUs, Nodes, or a bunch of SCSI and disks) display far
too many messages to the console, resulting in the log buffer being
overflowed.  The method that I'm proposing simply allows you to decide
what gets logged when a printk() happens, depending on the message's
priority and which subsystem it originated from.

mh

-- 
Wild Open Source Inc.                  mort@wildopensource.com

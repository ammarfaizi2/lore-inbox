Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbUCDVDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 16:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbUCDVDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 16:03:39 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:50314 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S262139AbUCDVDh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 16:03:37 -0500
Date: Thu, 4 Mar 2004 14:03:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       piggy@timesys.com
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040304210333.GG26065@smtp.west.cox.net>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <200403041036.58827.amitkale@emsyssoft.com> <20040303211850.05d44b4a.akpm@osdl.org> <200403041059.43439.amitkale@emsyssoft.com> <40479774.9070308@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40479774.9070308@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 12:54:12PM -0800, George Anzinger wrote:
> Amit S. Kale wrote:
> >On Thursday 04 Mar 2004 10:48 am, Andrew Morton wrote:
> >
> >>"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> >>
> >>>Flashing keyboard lights is easy on x86 and x86_64 platforms.
> >>
> >>Please, no keyboards.  Some people want to be able to use kgdboe
> >>to find out why machine number 324 down the corridor just died.
> >>
> >>How about just doing
> >>
> >>
> >>char *why_i_crashed;
> >>
> >>
> >>{
> >>	...
> >>	if (expr1)
> >>		why_i_crashed = "hit a BUG";
> >>	else if (expr2)
> >>		why_i_crashed = "divide by zero";
> >>	else ...
> >>}
> >>
> >>then provide a gdb macro which prints out the string at *why_i_crashed?
> >
> >
> >If we can afford to do this (in terms of actions that can be done with the 
> >machine being unstable) we can certainly print a console message through 
> >gdb.
> 
> Not once you are connected to gdb.  The "O" packet can only be sent if the 
> program (i.e. kernel) is running as far as gdb knows.  So you could preceed 
> a connection with this, but could not used it after gdb knows the kernel is 
> stopped.

If GDB is already connected and sitting by waiting, you can send the O
packet.  If it is not, you could delay sending the O packet until you
know that GDB has now connected.

This isn't an unworkable idea, but it's probably better to just set
*why_i_crashed (think work work work, oh wait, what caused this again?)
and provide some handy macros (which we should be in the docs anyhow).

-- 
Tom Rini
http://gate.crashing.org/~trini/

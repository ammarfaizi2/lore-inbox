Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVAMWhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVAMWhC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVAMWeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:34:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:58049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261796AbVAMWck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:32:40 -0500
Date: Thu, 13 Jan 2005 14:32:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Oeser <ioe-lkml@axxeo.de>
cc: linux@horizon.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
In-Reply-To: <200501132246.37289.ioe-lkml@axxeo.de>
Message-ID: <Pine.LNX.4.58.0501131429400.2310@ppc970.osdl.org>
References: <20050108082535.24141.qmail@science.horizon.com>
 <Pine.LNX.4.58.0501081018271.2386@ppc970.osdl.org> <200501132246.37289.ioe-lkml@axxeo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, Ingo Oeser wrote:
> 
> Hmm, that's a pity, because it makes hardware support more difficult.
> 
> I thought you might consider an system call, which "wires up" fds.
> 
> Imagine a device fd, which gets lots of measuring data, wired through a 
> DSP pipe, spliced to realtime display fd and file storage fd. 

I think that the solution to that is to make the pipe _be_ the driver 
interface.

Remember: a pipe is just a set of buffers. If you have a hardware device 
that could use the buffers, then there is nothing to say that the driver 
couldn't be the "actor" that fills the buffers. So doing an "open()" on 
the device would just create a pipe that gets filled by the hardware.

But that doesn't make the pipe an "actor". The pipe just remains a 
standard way to encapsulate the notion of "set of buffers". It needs an 
external actor to do something, but that actor can be a device driver 
filling it up, or a system call that reads it or moves it to another 
destination.

		Linus

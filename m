Return-Path: <linux-kernel-owner+w=401wt.eu-S1750931AbWLMVCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWLMVCm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWLMVCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:02:42 -0500
Received: from cantor.suse.de ([195.135.220.2]:51015 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbWLMVCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:02:41 -0500
Date: Wed, 13 Dec 2006 13:02:20 -0800
From: Greg KH <gregkh@suse.de>
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061213210219.GA9410@suse.de>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org> <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 12:38:05PM -0800, Michael K. Edwards wrote:
> Seriously, though, please please pretty please do not allow a facility
> for "going through a simple interface to get accesses to irqs and
> memory regions" into the mainline kernel, with or without toy ISA
> examples.

Why?  X does it today :)

> Embedded systems integrators have enough trouble with chip vendors who
> think that exposing the device registers to userspace constitutes a
> "driver".

Yes, and because of this, they create binary only drivers today.  Lots
of them.  All over the place.  Doing crazy stupid crap in kernelspace.

Then there are people who do irq stuff in userspace but get it wrong.
I've seen that happen many times in lots of different research papers
and presentations.

This interface does it correctly, and it allows those people who for
some reason feel they do want to keep their logic in non-gpl code, to do
it.

It also allows code that needs floating point to not be in the kernel
and in one instance using this interface actually sped up the device
because of the lack of the need to go between kernel and userspace a
bunch of times.

> The correct description is more like "porting shim for MMU-less RTOS
> tasks"; and if the BSP vendors of the world can make a nickel
> supplying them, more power to them.  Just not in mainline, please.

Again, X does this today, and does does lots of other applications.
This is a way to do it in a sane manner, to keep people who want to do
floating point out of the kernel, and to make some embedded people much
happier to use Linux, gets them from being so mad at Linux because we
keep changing the internal apis, and makes me happier as they stop
violating my copyright by creating closed drivers in the kernel.

thanks,

greg k-h

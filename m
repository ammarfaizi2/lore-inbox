Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263005AbVALEGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbVALEGZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 23:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVALEGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 23:06:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9709 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263005AbVALEGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 23:06:13 -0500
Date: Tue, 11 Jan 2005 22:56:47 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: David Lang <dlang@digitalinsight.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
Message-ID: <20050112005647.GB27653@logos.cnet>
References: <20050111235907.GG2760@pclin040.win.tue.nl> <Pine.LNX.4.61.0501120203510.2912@dragon.hygekrogen.localhost> <Pine.LNX.4.60.0501111714450.18921@dlang.diginsite.com> <20050111223641.GA27100@logos.cnet> <20050112023218.GF4325@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112023218.GF4325@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 06:32:18PM -0800, Barry K. Nathan wrote:
> On Tue, Jan 11, 2005 at 08:36:41PM -0200, Marcelo Tosatti wrote:
> > On Tue, Jan 11, 2005 at 05:18:16PM -0800, David Lang wrote:
> [snip]
> > > how about something like the embedded, experimental, and broken options. 
> > > that way normal users can disable all of them at a stroke, people who need 
> > > them can add them in.
> 
> That is what I had in mind for the longer term. Now that I think about
> it, my current patch is probably a bad way to get from here to there --
> it adds a config option that would later *need* to be renamed and moved
> to a different category.
> 
> (To be specific, the concept I have in mind is to have an option that
> disables the syscalls that are usually used only by libc5 and earlier.)

Out of curiosity do you have a list of such syscalls?

"usually" is the problem - you cannot be sure what syscalls unknown applications are using. 

> > Thats just not an option - you would have zillions of config options. 
> 
> I don't see how it would be zillions, but it's possible there's
> something I'm not yet understanding.

I assumed David was talking about having every different feature as a config 
option.

> > Moreover this is a system call, and the system call interface is one of the few 
> > supposed to be stable. You shouldnt simply assume that "no one will ever use sys_uselib()" - 
> > there might be programs out there who use it.
> 
> And if you have programs that need it, you (or your vendor) can set the
> config option accordingly.

The possibility is that there might be unknown applications which use these "obsolete" system
calls. 

Vendors who want to support older applications (most distributions) will have to enable all 
these option(s), while users who do not need one or a few of them can disable accordingly 
("specialized" applications).

One thing is that ordinary users are not supposed to know what system calls his applications
are going to use, most of these users will be running vendor shipped kernels anyway.

I personally dont like the idea of disabling "obsolete" system calls with config options, 
but it is useful for specialized applications to save memory. 

Are many users going to benefit from it?


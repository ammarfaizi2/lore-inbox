Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbUKBXFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbUKBXFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbUKBXB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:01:58 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:14607 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S262497AbUKBW61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:58:27 -0500
Date: Tue, 2 Nov 2004 22:57:37 +0000 (GMT)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: adaplas@pol.net
cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org,
       geert@linux-m68k.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
In-Reply-To: <200411030540.06262.adaplas@hotpop.com>
Message-ID: <Pine.LNX.4.10.10411022257010.5391-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Will this work for a kernel Panic ?

Mark

On Wed, 3 Nov 2004, Antonino A. Daplas wrote:

> On Wednesday 03 November 2004 02:03, Mark Fortescue wrote:
> > Hi all,
> >
> > I have identified what is going on. My CG3 console uses the same font and
> > exactly overlaps prom console. [I have re-inserted the console margin code
> > for my CG3 driver]. The timing is such that the prom overwrites the
> > console text (using colour 255) a fraction later than the fbcon code.
> >
> > The two problems to be solved are (apart from seting the red,green and
> > blue structures up for the cg series fb cards):
> >
> > 1) The prom write (from -p) needs to be disabled as soon as an alternative
> > console becomes active (either prom console, fbcon console or serial
> > console). This has probably been the major cause of hassel.
> >
> > 2) The restore pallet function (see cgsix.c in the 2.2.x or 2.4.x kernels)
> > needs to be re-introduced in some form and called when exiting fbcon so
> > that the prom does not end up as black on black. My prom uses fg=255,
> 
> You can implement a cg3fb_open() and cg3fb_release() hooks and set up a
> use_count field. You increment the count on every open, decrement on every
> release. Then restore whatever on the last release. Optionally, you can even
> do hardware inits on the first open.
> 
> Tony 
> 
> 


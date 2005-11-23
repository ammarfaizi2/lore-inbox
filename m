Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVKWUur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVKWUur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVKWUuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:50:46 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:53131 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932386AbVKWUup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:50:45 -0500
Date: Wed, 23 Nov 2005 15:50:44 -0500
To: Rick Niles <niles@rickniles.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sub jiffy delay?
Message-ID: <20051123205044.GL9488@csclub.uwaterloo.ca>
References: <200511232039.PAA03184@bellona.cnchost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511232039.PAA03184@bellona.cnchost.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 03:39:17PM -0500, Rick Niles wrote:
> I need to service a piece of hardware about every 400-500
> microseconds, but I really don't want to change the value of HZ, which
> in my version of the 2.6 kernel is 1000.  The hardware doesn't have an
> interrupt so the nasty hack I've been doing is to service the hardware
> repeatedly in a loop for about 600 microseconds by watching the
> do_gettimeofday(), set a timer for the next jiffy and repeat.  This leaves less than 400 microseconds / millisecond for the kernel and anything else on the system to run.
> 
> Obviously, this sucks, but it does work. I am working with the
> hardware guy to add an interrupt to the hardware.  However, I don't
> want every user of the hardware without the interrupt to have to
> rebuild the kernel with a different value of HZ.  So does anyone have
> any better ideas on what I can do?

Use the RTC interrupt generator perhaps (if you have one)?  Call the
hardware people nasty things to tell them how dumb it is to make
hardware that requires frequent service without an efficient way to tell
the system when to do this.  Polling is never efficient, although it is
sometimes faster (although not usually in my experience). :)  After all
how did they think you were going to use the hardware?

Len Sorensen

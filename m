Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWAFCHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWAFCHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbWAFCHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:07:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15596 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752074AbWAFCHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:07:20 -0500
Date: Thu, 5 Jan 2006 15:52:21 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060105205221.GN20809@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20060105045212.GA15789@redhat.com> <1136468254.16358.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136468254.16358.23.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 01:37:33PM +0000, Alan Cox wrote:
 > On Mer, 2006-01-04 at 23:52 -0500, Dave Jones wrote:
 > > With this patch, if we oops, there's a pause for a two minutes..
 > > which hopefully gives people enough time to grab a digital camera
 > > to take a screenshot of the oops.
 > 
 > This appears to reduce the amount of information available as an oops
 > instead of spewing to the log

The huge number of oopses never hit the logs.
They either hit early in boot before syslog is even running, or
they kill the box.
 
 > and continuing generally will hang the box
 > stopping the scroll keys being used or dmesg being used to get the data
 > out. 

This is exactly the problem this patch addresses.
The 'scroll keys' do not work in cases where we lock up after an oops.

If the useful parts of the oops scrolled off the top of the screen, we've
lost any chance of debugging whatever just happened. 

 > Who is going to wait two minutes for an oops when for most users its
 > their only box.

The real-world disagrees with you. In the few weeks it's been in Fedora,
several previously undiagnosable oopses were caught, and even *users*
agreed it was a useful addition.   If the two minutes is excessive, we can
lower it, or even make it a boot-option.

Another possibility is instantly continuing after a keypress.

 > Instead of pasting reports people will now reboot, or
 > perhaps send you the half a report they can see (which because we dump
 > too much info by default to fit the screen is also useless).

See the other patch which halves the number of lines needed for a backtrace.
With that, even if the user is running 25 line high displays, we've
a pretty good chance it'll fit except for really long backtraces,
and if that's the case, we can ask users to try to reproduce after
 booting with vga=1, (or better, vga=791 for eg).

 > > The one case this doesn't catch is the problem of oopses whilst
 > > in X. Previously a non-fatal oops would stall X momentarily,
 > > and then things continue. Now those cases will lock up completely
 > > for two minutes. 
 > 
 > The console has awareness of graphic/text mode at all times and knows
 > what is going on. Why not use that information if you must go this way ?

If we've just oopsed, the console may have no awareness of what day it is,
yet alone anything about video modes. I'm not entirely sure what you're
suggesting, but it gives me the creeps. Are you talking about switching
away from X back to a tty when we oops?

		Dave


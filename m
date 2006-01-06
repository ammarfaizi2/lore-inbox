Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752544AbWAFUeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbWAFUeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbWAFUeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:34:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22228 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752551AbWAFUeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:34:04 -0500
Date: Fri, 6 Jan 2006 15:33:54 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060106203354.GJ4595@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20060105045212.GA15789@redhat.com> <1136468254.16358.23.camel@localhost.localdomain> <20060105205221.GN20809@redhat.com> <1136554270.30498.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136554270.30498.3.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 01:31:10PM +0000, Alan Cox wrote:
 > On Iau, 2006-01-05 at 15:52 -0500, Dave Jones wrote:
 > > The huge number of oopses never hit the logs.
 > > They either hit early in boot before syslog is even running, or
 > > they kill the box.
 > 
 > So you don't need a two minute delay for those because as you said it
 > froze the box

it froze *AFTER* the oops had scrolled off the top of the screen.

The sequence of events before

oops
scrolly scrolly
random crap about sleeping whilst atomic or the like
scrolly scrolly
HANG

with this patch..

oops
*pause for two minutes whilst user takes a picture/scribbles it down*
scrolly scrolly
random crap about sleeping whilst atomic or the like
scrolly scrolly
HANG

 > >  > and continuing generally will hang the box
 > >  > stopping the scroll keys being used or dmesg being used to get the data
 > >  > out. 
 > > 
 > > This is exactly the problem this patch addresses.
 > > The 'scroll keys' do not work in cases where we lock up after an oops.
 > 
 > And in those cases the 2 minute freeze is meaningless

it does if it stops the oops scrolling off the screen first long enough
to capture it.

 > > Another possibility is instantly continuing after a keypress.
 > If the input layer is running that would be sensible.

Yeah, questionable. And polling hardware won't work due to usb keyboards.

 > > If we've just oopsed, the console may have no awareness of what day it is,
 > > yet alone anything about video modes. I'm not entirely sure what you're
 > > suggesting, but it gives me the creeps. Are you talking about switching
 > > away from X back to a tty when we oops?
 > 
 > Well you could try and do that but I was more thinking that if the
 > console has been told we are in graphics mode then the 2 minute delay
 > shouldn't occur.

Hmm. I'll look into that.
Any pointers ? (I don't want to spend longer than necessary looking
in that code :-)

		Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVHaKeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVHaKeV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 06:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVHaKeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 06:34:21 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:43200 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S932316AbVHaKeU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 06:34:20 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 31 Aug 2005 13:34:03 +0300
From: Tony Lindgren <tony@atomide.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Con Kolivas <kernel@kolivas.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Christopher Friesen <cfriesen@nortel.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
Message-ID: <20050831103402.GA6496@atomide.com>
References: <1125354385.4598.79.camel@mindpipe> <200508301348.59357.kernel@kolivas.org> <20050830123132.GH6055@atomide.com> <200508301701.49228.s0348365@sms.ed.ac.uk> <20050831074419.GA1029@atomide.com> <1125477566.3213.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125477566.3213.6.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven <arjan@infradead.org> [050831 11:40]:
> On Wed, 2005-08-31 at 10:44 +0300, Tony Lindgren wrote:
> > * Alistair John Strachan <s0348365@sms.ed.ac.uk> [050830 18:57]:
> > > On Tuesday 30 August 2005 13:31, Tony Lindgren wrote:
> > > [snip]
> > > > >
> > > > > Same issue, it's waiting on dynticks before being reworked.
> > > >
> > > > Also one more minor issue; Dyntick can cause slow boots with dyntick
> > > > enabled from boot because the there's not much in the timer queue
> > > > until init.
> > > >
> > > > This probably does not show up much on x86 though because of the
> > > > short hardware timers.
> > > 
> > > You could disable it until jiffies >= 0; this covers the boot criteria and 
> > > still allows for moderate savings post boot (though maybe on embedded systems 
> > > the delay is too long?).
> > 
> > Yeah, that's true. Or just enable it from an init script via sysfs.
> 
> ehh
> why does it cause slow boots?
> if that kind of behavior changes... isn't that a sign there is a
> fundamental bug still ?
 
Well it seems like the next_timer_interrupt is something like 400
jiffies away and RCU code waits for completion for example in the
network code.

Tony

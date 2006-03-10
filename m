Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752038AbWCJTdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbWCJTdU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 14:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbWCJTdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 14:33:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8588 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752038AbWCJTdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 14:33:20 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com,
       gregkh@kroah.com, Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
In-Reply-To: <200603101107.27244.dsp@llnl.gov>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	 <200603100946.12448.dsp@llnl.gov>
	 <1142013481.2876.89.camel@laptopd505.fenrus.org>
	 <200603101107.27244.dsp@llnl.gov>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 20:33:15 +0100
Message-Id: <1142019195.2876.100.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 11:07 -0800, Dave Peterson wrote:
> On Friday 10 March 2006 09:58, Arjan van de Ven wrote:
> > > I'd be curious to hear people's opinions on the following idea:
> > > move the PCI bus parity error checking functionality from EDAC
> > > to the PCI subsystem.
> >
> > I can see the point on at least moving all the infrastructure there.
> > The actual call to run it... maybe. that's more debatable I suppose.
> 
> Regarding the actual call to run it, I guess it depends on which of
> the following you prefer:
> 
>     Scenario A
>     ----------
>     A more decentralized layout.  Here, the controls that govern the
>     error handling behavior for a given category of hardware (a
>     category might be "PCI devices" or "devices that use bus
>     technology XYZ") are grouped together with other stuff for that
>     category.

this would basically make edac a place to report "help something went to
the gutter". Sure. I see that useful. 

In fact there are 3 layers then

1) low level "do check" function

2) per bus code that calls the do check functions and whatever is needed
for bus checks

3) "EDAC" central command, which basically gathers all failure reports
and does something with them (push them to userspace or implement the
userspace chosen policy (panic/reboot/etc))


having 1) separate from 2) is useful, it means that drivers can do
synchronous checks in addition to the checks in 2) which will tend to be
asynchronous....




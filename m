Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWCJVNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWCJVNs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 16:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWCJVNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 16:13:48 -0500
Received: from smtp-4.llnl.gov ([128.115.41.84]:30711 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S932269AbWCJVNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 16:13:47 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Fri, 10 Mar 2006 13:13:09 -0800
User-Agent: KMail/1.5.3
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com,
       gregkh@kroah.com, Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603101107.27244.dsp@llnl.gov> <1142019195.2876.100.camel@laptopd505.fenrus.org>
In-Reply-To: <1142019195.2876.100.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603101313.09754.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 March 2006 11:33, Arjan van de Ven wrote:
> > Regarding the actual call to run it, I guess it depends on which of
> > the following you prefer:
> >
> >     Scenario A
> >     ----------
> >     A more decentralized layout.  Here, the controls that govern the
> >     error handling behavior for a given category of hardware (a
> >     category might be "PCI devices" or "devices that use bus
> >     technology XYZ") are grouped together with other stuff for that
> >     category.
>
> this would basically make edac a place to report "help something went to
> the gutter". Sure. I see that useful.
>
> In fact there are 3 layers then
>
> 1) low level "do check" function

I'm a bit unclear here.  Are you thinking of a single "do check"
function that bus-specific code and chipset-specific code can hook
into, or individual "do check" functions for various bus-specific and
chipset-specific modules?

> 2) per bus code that calls the do check functions and whatever is needed
> for bus checks
>
> 3) "EDAC" central command, which basically gathers all failure reports
> and does something with them (push them to userspace or implement the
> userspace chosen policy (panic/reboot/etc))

Are you suggesting something like the following?

    - The controls that determine how the error checking is done are
      located within the various hardware subsystems.  For instance,
      with PCI parity checking, this would include stuff like setting
      the polling frequency and determining which devices to check.

    - When an error is actually detected, the subsystem that detected
      the error (for instance, PCI) would feed the error information
      to EDAC.  Then EDAC would determine how to respond to the error
      (for instance, push it to userspace or implement the
      userspace-chosen policy (panic/reboot/etc))

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751931AbWCJTId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWCJTId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 14:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbWCJTId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 14:08:33 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:18362 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1751931AbWCJTIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 14:08:32 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Fri, 10 Mar 2006 11:07:27 -0800
User-Agent: KMail/1.5.3
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com,
       gregkh@kroah.com, Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603100946.12448.dsp@llnl.gov> <1142013481.2876.89.camel@laptopd505.fenrus.org>
In-Reply-To: <1142013481.2876.89.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603101107.27244.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 March 2006 09:58, Arjan van de Ven wrote:
> > I'd be curious to hear people's opinions on the following idea:
> > move the PCI bus parity error checking functionality from EDAC
> > to the PCI subsystem.
>
> I can see the point on at least moving all the infrastructure there.
> The actual call to run it... maybe. that's more debatable I suppose.

Regarding the actual call to run it, I guess it depends on which of
the following you prefer:

    Scenario A
    ----------
    A more decentralized layout.  Here, the controls that govern the
    error handling behavior for a given category of hardware (a
    category might be "PCI devices" or "devices that use bus
    technology XYZ") are grouped together with other stuff for that
    category.

    Scenario B
    ----------
    A more centralized layout.  Here, the controls that govern a wide
    variety of error handling behaviors are all grouped together (for
    instance, within EDAC).

I tend to prefer scenario A.  The conceptual model I currently have in
my mind for EDAC is as follows:

    - Each low-level EDAC module (amd76x, e7xxx, etc.) implements
      hardware error handling functionality that is specific to just
      that platform.

    - The purpose of the core EDAC module is to serve as a home for
      abstractions that are common to the various low-level EDAC
      modules.  This creates uniformity of mechanism, and also uniform
      behavior from the user's point of view.  It also encourages
      avoidance of replicated code.  However, the core EDAC module
      (and by extension, the low-level EDAC modules) should not
      contain stuff that is generic enough to fit elsewhere (for
      instance, in the PCI subsystem).  In other words, EDAC serves as
      a catch-all for error handling functionality that is too
      platform-specific to fit anywhere else.

However, these are just my personal thoughts.  I'd be curious to hear
other ideas people may have.


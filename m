Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWFWDer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWFWDer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWFWDer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:34:47 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:64402 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932072AbWFWDeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:34:46 -0400
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Date: Thu, 22 Jun 2006 20:34:43 -0700
User-Agent: KMail/1.7.1
Cc: Mattia Dongili <malattia@linux.it>, Jiri Slaby <jirislaby@gmail.com>,
       Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-pm@osdl.org, pavel@suse.cz
References: <20060622202952.GA14135@kroah.com> <200606221624.03182.david-b@pacbell.net> <20060622235112.GA30484@kroah.com>
In-Reply-To: <20060622235112.GA30484@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606222034.44085.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 June 2006 4:51 pm, Greg KH wrote:
> > There was previously an invariant that the interfaces were marked
> > as quiescent unless the interface (a) had a driver, and (b) that
> > driver was not suspended.  Evidently that has been lost.  This patch
> > may be insufficient; ISTR other places relying on that invariant.
> > 
> > And yes, we _should_ care about whether or not any interface is
> > still active, until the pm core code starts to pay attention to
> > the driver model tree at all times ... even outside of system-wide
> > suspend transitions.  Today, the pm core code doesn't even use
> > that tree directly, and all runtime state changes (like selective
> > suspend with USB) completely bypass that pm tree.
> 
> Hm, ok, yes, we should care about interfaces, but we need some way to
> only walk them, not anything else that might be attached to us...

Under what scenario could it possibly be legitimate to suspend a
usb device -- or interface, or anything else -- with its children
remaining active?  The ability to guarantee that could _never_ happen
was one of the fundamental motivations for the driver model ...

Maybe that invariant should be replaced with something else, though
I'm not sure what.  Certainly it would make a fair amount of sense
to leave unused PCI devices in the PCI_D3 state, for example; that
would be the PCI analogue of that invariant.

- Dave


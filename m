Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVK1FPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVK1FPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 00:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVK1FPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 00:15:42 -0500
Received: from cantor2.suse.de ([195.135.220.15]:11704 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751240AbVK1FPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 00:15:41 -0500
Date: Mon, 28 Nov 2005 06:15:29 +0100
From: Andi Kleen <ak@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       kaos@sgi.com, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Douglas_Warzecha@dell.com,
       Abhay_Salunke@dell.com, achim_leubner@adaptec.com,
       dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain
Message-ID: <20051128051529.GL20775@brahms.suse.de>
References: <20051127172725.GJ20775@brahms.suse.de> <24158.1133113176@ocs3.ocs.com.au> <20051127115640.3073f8e3.akpm@osdl.org> <20051127220329.GA17786@kroah.com> <20051128024301.GA8651@us.ibm.com> <20051127205745.78b565ec.akpm@osdl.org> <20051128045922.GK20775@brahms.suse.de> <20051128050522.GD8651@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128050522.GD8651@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 09:05:22PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 28, 2005 at 05:59:22AM +0100, Andi Kleen wrote:
> > On Sun, Nov 27, 2005 at 08:57:45PM -0800, Andrew Morton wrote:
> > > "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> > > >
> > > > Any options I missed?
> > > 
> > > Stop using the notifier chains from NMI context - it's too hard.  Use a
> > > fixed-size array in the NMI code instead.
> > 
> > Or just don't unregister. That is what I did for the debug notifiers.
> 
> So the thought is to replicate the notifier code in all non-NMI subsystems
> that require it?

The non NMI subsystems just need to get appropiate locking 
(or preferable just use RCU if the notifiers can't sleep) 

-Andi

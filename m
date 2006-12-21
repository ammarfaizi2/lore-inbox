Return-Path: <linux-kernel-owner+w=401wt.eu-S1161169AbWLUDEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbWLUDEp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161172AbWLUDEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:04:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47548 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161169AbWLUDEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:04:43 -0500
Subject: Re: Network drivers that don't suspend on interface down
From: Dan Williams <dcbw@redhat.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jiri Benc <jbenc@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20061221011526.GB32625@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org>
	 <200612191959.43019.david-b@pacbell.net>
	 <20061220042648.GA19814@srcf.ucam.org>
	 <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de>
	 <20061220055209.GA20483@srcf.ucam.org>
	 <1166601025.3365.1345.camel@laptopd505.fenrus.org>
	 <20061220125314.GA24188@srcf.ucam.org>
	 <20061220150009.1d697f15@griffin.suse.cz>
	 <1166638371.2798.26.camel@localhost.localdomain>
	 <20061221011526.GB32625@srcf.ucam.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 22:06:51 -0500
Message-Id: <1166670411.23168.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-21 at 01:15 +0000, Matthew Garrett wrote:
> On Wed, Dec 20, 2006 at 01:12:51PM -0500, Dan Williams wrote:
> 
> > Entirely correct.  If the card is DOWN, the radio should be off (both TX
> > & RX) and it should be in max power save mode.  If userspace expects to
> > be able to get the card to do _anything_ when it's down, that's just
> > 110% wrong.  You can't get link events for many wired cards when they
> > are down, so I fail to see where userspace could expect to do anything
> > with a wireless card when it's down too.
> 
> Because it works on the common hardware? If there's documentation about 
> what userspace can legitimately expect, then I'm happy to defer to that. 
> But in the absence of any indication as to what functionality users can 
> depend on, deciding that existing functionality is a bug is, well, 
> impolite.
> 
> > Also, how does rfkill fit into this?  rfkill implies killing TX, but do
> > we have the granularity to still receive while the transmit paths are
> > powered down?
> 
> Is rfkill not just primarily an interface for us getting events when the 
> radio changes state? Every time I read up on it I get a little more 
> confused - some time I really need to make sense of it...

That's OK, it's really complicated.  There are 3 cases of rfkill
switches AFAICT:

a) tied to the wireless hardware, switch kills hardware directly
b) tied to wireless hardware, but driver handles the kill request
c) just another key, a separate key driver handles the event and asks
the wireless driver to kill the card

It's also complicated because some switches are supposed to rfkill both
an 802.11 module _and_ a bluetooth module at the same time, or I guess
some laptops may even have one rfkill switch for each wireless device.
Furthermore, some people want to 'softkill' the hardware via software
without pushing the key, which is a subset of (b) or (c) above.

It sucks.  But we _need_ a unified interface to handle it.

Dan



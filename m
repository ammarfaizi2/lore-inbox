Return-Path: <linux-kernel-owner+w=401wt.eu-S1422636AbWLUDME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWLUDME (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWLUDME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:12:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422632AbWLUDMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:12:01 -0500
Subject: Re: Network drivers that don't suspend on interface down
From: Dan Williams <dcbw@redhat.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Michael Wu <flamingice@sourmilk.net>,
       Stephen Hemminger <shemminger@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20061221021832.GA723@srcf.ucam.org>
References: <20061220042648.GA19814@srcf.ucam.org>
	 <20061220144906.7863bcd3@dxpl.pdx.osdl.net>
	 <20061221011209.GA32625@srcf.ucam.org>
	 <200612202105.31093.flamingice@sourmilk.net>
	 <20061221021832.GA723@srcf.ucam.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 22:14:08 -0500
Message-Id: <1166670848.23168.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-21 at 02:18 +0000, Matthew Garrett wrote:
> On Wed, Dec 20, 2006 at 09:05:27PM -0500, Michael Wu wrote:
> 
> > Softmac isn't the only wireless code that likes to be configured after going 
> > up first. Configuring after the card goes up has generally been more 
> > reliable, though that should not be necessary and is a bug IMHO. 
> 
> Ok, that's nice to know. 
> 
> > In order to scan, we need to have the radio on and we need to be able to send 
> > and receive. What are you gonna turn off?
> 
> The obvious route would be to power the card down, but come back up 
> every two minutes to perform a scan, or if userspace explicitly requests 
> one. Would this cause problems in some cases?

Seriously, having all these different capabilities when the card is
"down" is just madness.  Down == Down!!!  Furthermore, every card is
going to support some other subset of capabilities when it's "down".
When you bring "up" prism54 fullmac card, you have to power up the
hardware, reload the firmware, let the firmware boot, and then talk to
it.  Doing that every 2 minutes is just a waste of time, effort, and
power.

If you want to scan, just bring the darn card up to do it.  It's so much
simpler that way, and I just don't see what having all this "every 2
minutes do a scan" policy really buys us.  That doesn't belong in the
kernel.  If something wants to scan, userspace can wake the card up and
do the scan.  It's userspace that's using the scan results to configure
the card anyway, so userspace can do the scan.

Simple == good.  Down == down.  Lets just agree on that and save
ourselves a lot of pain.

Dan



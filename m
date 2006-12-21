Return-Path: <linux-kernel-owner+w=401wt.eu-S1422663AbWLUDao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWLUDao (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbWLUDao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:30:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53427 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422656AbWLUDan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:30:43 -0500
Subject: Re: Network drivers that don't suspend on interface down
From: Dan Williams <dcbw@redhat.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jiri Benc <jbenc@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20061221031418.GA1277@srcf.ucam.org>
References: <20061220042648.GA19814@srcf.ucam.org>
	 <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de>
	 <20061220055209.GA20483@srcf.ucam.org>
	 <1166601025.3365.1345.camel@laptopd505.fenrus.org>
	 <20061220125314.GA24188@srcf.ucam.org>
	 <20061220150009.1d697f15@griffin.suse.cz>
	 <1166638371.2798.26.camel@localhost.localdomain>
	 <20061221011526.GB32625@srcf.ucam.org>
	 <1166670411.23168.13.camel@localhost.localdomain>
	 <20061221031418.GA1277@srcf.ucam.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 22:32:47 -0500
Message-Id: <1166671967.23168.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-21 at 03:14 +0000, Matthew Garrett wrote:
> On Wed, Dec 20, 2006 at 10:06:51PM -0500, Dan Williams wrote:
> 
> > a) tied to the wireless hardware, switch kills hardware directly
> > b) tied to wireless hardware, but driver handles the kill request
> > c) just another key, a separate key driver handles the event and asks
> > the wireless driver to kill the card
> > 
> > It's also complicated because some switches are supposed to rfkill both
> > an 802.11 module _and_ a bluetooth module at the same time, or I guess
> > some laptops may even have one rfkill switch for each wireless device.
> > Furthermore, some people want to 'softkill' the hardware via software
> > without pushing the key, which is a subset of (b) or (c) above.
> 
> If we define interface down as meaning that the device is powered down 
> and the radio switched off, then (b) and (c) would presumably just need 
> to ensure that the interface is downed. (a) is a slightly more special 
> case - if the switch disables the radio, I guess we then want the driver 
> to down the interface as well.

Correct.

> In the (a) case, drivers should presumably refuse to bring the interface 
> up if the radio is disabled?

Right; the driver simply can't do anything about it, because the switch
is hardwired to the card and either the card's firmware takes care of
it, or the chipset takes care of it.  The driver has no say whatsoever
in the state of the card's radio for this case.  I tend to think this
case is on it's way out in the same way that fullmac cards are falling
out of favor (ie, do everything in software and save $$$), but they are
around and we need to support them.

In this case, down really does mean down too.  The driver cannot honor
requests to set SSID, frequency, etc, because it's simply not possible
at that time.

Dan



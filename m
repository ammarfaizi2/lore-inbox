Return-Path: <linux-kernel-owner+w=401wt.eu-S1161075AbWLUA1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWLUA1E (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWLUA1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:27:03 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52674 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161075AbWLUA07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:26:59 -0500
Date: Tue, 19 Dec 2006 16:26:08 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network drivers that don't suspend on interface down
Message-ID: <20061219162608.6085d8aa@freekitty>
In-Reply-To: <20061221001111.GA4016@electric-eye.fr.zoreil.com>
References: <20061220042648.GA19814@srcf.ucam.org>
	<200612192114.49920.david-b@pacbell.net>
	<20061220053417.GA29877@suse.de>
	<20061220055209.GA20483@srcf.ucam.org>
	<1166601025.3365.1345.camel@laptopd505.fenrus.org>
	<20061220125314.GA24188@srcf.ucam.org>
	<1166621931.3365.1384.camel@laptopd505.fenrus.org>
	<20061220143134.GA25462@srcf.ucam.org>
	<1166629900.3365.1428.camel@laptopd505.fenrus.org>
	<20061220144906.7863bcd3@dxpl.pdx.osdl.net>
	<20061221001111.GA4016@electric-eye.fr.zoreil.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006 01:11:12 +0100
Francois Romieu <romieu@fr.zoreil.com> wrote:

> Stephen Hemminger <shemminger@osdl.org> :
> [...]
> >    IMHO:
> > 	When device is down, it should:
> > 	 a) use as few resources as possible:
> > 	       - not grab memory for buffers
> > 	       - not assign IRQ unless it could get one
> > 	       - turn off all power consumption possible
> > 	 b) allow setting parameters like speed/duplex/autonegotiation,
> >             ring buffers, ... with ethtool, and remember the state
> > 	 c) not accept data coming in, and drop packets queued
> 
> <nit>
> Imho speed/duplex/autoneg is not the business of the device: they belong
> to the phy and it's up to it to decide if its state allows to set the
> requested parameters or not.
> </nit>
> 

We need to allow ethtool setting to be done before device has been brought
up and started autonegotiation. The current MII library doesn't really support
it.

-- 
Stephen Hemminger <shemminger@osdl.org>

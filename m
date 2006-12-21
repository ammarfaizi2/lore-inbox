Return-Path: <linux-kernel-owner+w=401wt.eu-S1422637AbWLUDOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWLUDOb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWLUDOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:14:31 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:36769 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422633AbWLUDOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:14:30 -0500
Date: Thu, 21 Dec 2006 03:14:18 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Dan Williams <dcbw@redhat.com>
Cc: Jiri Benc <jbenc@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <20061221031418.GA1277@srcf.ucam.org>
References: <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de> <20061220055209.GA20483@srcf.ucam.org> <1166601025.3365.1345.camel@laptopd505.fenrus.org> <20061220125314.GA24188@srcf.ucam.org> <20061220150009.1d697f15@griffin.suse.cz> <1166638371.2798.26.camel@localhost.localdomain> <20061221011526.GB32625@srcf.ucam.org> <1166670411.23168.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166670411.23168.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Network drivers that don't suspend on interface down
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 10:06:51PM -0500, Dan Williams wrote:

> a) tied to the wireless hardware, switch kills hardware directly
> b) tied to wireless hardware, but driver handles the kill request
> c) just another key, a separate key driver handles the event and asks
> the wireless driver to kill the card
> 
> It's also complicated because some switches are supposed to rfkill both
> an 802.11 module _and_ a bluetooth module at the same time, or I guess
> some laptops may even have one rfkill switch for each wireless device.
> Furthermore, some people want to 'softkill' the hardware via software
> without pushing the key, which is a subset of (b) or (c) above.

If we define interface down as meaning that the device is powered down 
and the radio switched off, then (b) and (c) would presumably just need 
to ensure that the interface is downed. (a) is a slightly more special 
case - if the switch disables the radio, I guess we then want the driver 
to down the interface as well.

In the (a) case, drivers should presumably refuse to bring the interface 
up if the radio is disabled?
-- 
Matthew Garrett | mjg59@srcf.ucam.org

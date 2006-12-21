Return-Path: <linux-kernel-owner+w=401wt.eu-S1161109AbWLUBMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWLUBMX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 20:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWLUBMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 20:12:23 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:60127 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161109AbWLUBMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 20:12:22 -0500
Date: Thu, 21 Dec 2006 01:12:09 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Message-ID: <20061221011209.GA32625@srcf.ucam.org>
References: <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de> <20061220055209.GA20483@srcf.ucam.org> <1166601025.3365.1345.camel@laptopd505.fenrus.org> <20061220125314.GA24188@srcf.ucam.org> <1166621931.3365.1384.camel@laptopd505.fenrus.org> <20061220143134.GA25462@srcf.ucam.org> <1166629900.3365.1428.camel@laptopd505.fenrus.org> <20061220144906.7863bcd3@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220144906.7863bcd3@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Network drivers that don't suspend on interface down
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 02:49:06PM -0800, Stephen Hemminger wrote:

> 	When device is down, it should:
> 	 a) use as few resources as possible:
> 	       - not grab memory for buffers
> 	       - not assign IRQ unless it could get one
> 	       - turn off all power consumption possible
> 	 b) allow setting parameters like speed/duplex/autonegotiation,
>             ring buffers, ... with ethtool, and remember the state

Veering off at something of a tangent - how much of this should be true 
for wireless devices? Softmac seems to be unhappy about setting the 
essid unless the card is up, which breaks various assumptions...

Beyond that, I think your descriptions of up and down states make sense 
for userspace. As Arjan suggests, there's then the intermediate state of 
"disable as much as possible while still providing scanning and link 
detection".

> 2) Network device infrastructure should make it easier for devices:
>     bring interface down on suspend and bring it up after resume
>     (if it was running when suspended). This would allow many devices to
>     have no suspend/resume hook; except those that have some better power
>     control over hardware.

I'd have some concerns over how that would interact with the rest of the 
PM infrastructure, but it certainly sounds good in principle.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

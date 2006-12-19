Return-Path: <linux-kernel-owner+w=401wt.eu-S932934AbWLSUdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbWLSUdF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 15:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932891AbWLSUdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 15:33:04 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:58582 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932935AbWLSUdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 15:33:03 -0500
Date: Tue, 19 Dec 2006 20:32:51 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, gregkh@suse.de
Message-ID: <20061219203251.GA14648@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <1166556889.3365.1269.camel@laptopd505.fenrus.org> <20061219194410.GA14121@srcf.ucam.org> <1166558602.3365.1271.camel@laptopd505.fenrus.org> <20061219200803.GA14332@srcf.ucam.org> <1166559785.3365.1276.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166559785.3365.1276.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Changes to sysfs PM layer break userspace
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 09:23:05PM +0100, Arjan van de Ven wrote:
> On Tue, 2006-12-19 at 20:08 +0000, Matthew Garrett wrote:
> > I'm not sure. Suspending the chip means you lose things like link beat 
> > detection, so it's not something you necessarily want to automatically 
> > tie to something like interface status. 
> 
> right now the "spec" for Linux network drivers assumes that you put the
> NIC into D3 on down, except for cases where Wake-on-Lan is enabled etc.

Really? I can't find any drivers that seem to do this. The only calls to 
pci_set_power_state seem to be in the suspend, resume, init and exit 
routines.

> > Some chips support more 
> > fine-grained power management, so we could do something more sensible in 
> > that case - but right now, there doesn't seem to be a lot of driver 
> > support for it.
> 
> sounds like that's the right approach at least .. not talking to the PCI
> hardware directly from userspace...

I'd certainly agree that that's the right thing to do, but userspace has 
a habit of using whatever functionality /is/ available to get to a given 
end. The semantics of the device/power/state file were never made 
terribly clear, and it did have the desired effect of suspending the 
device. Removing it without providing warning or a transition pathway is 
a pain.

> I can see the point of having more than just "UP" and "DOWN" as
> interface states; "UP", "DOWN" and "OFF" for example... 

Agreed.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
